import datetime
import time
import random
import re
import pyexcel
import psycopg2
from telethon import TelegramClient

def find_table():
    """get table with with finbot message data"""
    table = pyexcel.get_book_dict(file_name='utiles/bot_file.xls')
    return table

def find_text_from_table(code):
    """find text in xls file by id"""
    table = pyexcel.get_book_dict(file_name='utiles/bot_file.xls')
    for row in table['pyexcel_sheet1']:
        if code in row:
            return row[4]
    return None

def find_button(messages, button_name):
    """
    find button by name in messages
    messages - messages where you want to find the button
    button_name - name of the button
    """
    for message in messages:
        if message.buttons is None:
            continue
        for butt_row in message.buttons:
            for button in butt_row:
                if re.search(button_name, button.text):
                    return button
    return None

def check_message_by_list(mesage, lis):
    """check message in the list"""
    for part in lis:
        if part not in mesage:
            return False
    return True

def get_random_month_day(min_val=2, max_val=28):
    """get random monthday"""
    return random.randint(min_val, max_val)

def get_random_file_path():
    """create path to the image path"""
    number_file = random.randint(1, 5)
    return 'files/{}.jpg'.format(number_file)

def pgsql_update(request, logger, user, password, port, host, database):
    """update data in the pgsql table"""
    try:
        with psycopg2.connect(
                user=user,
                host=host,
                port=port,
                password=password,
                database=database
        ) as connect:
            cursor = connect.cursor()
            if request.startswith('UPDATE'):
                cursor.execute(request)
                connect.commit()
                time.sleep(0.2)
                return cursor.rowcount
    except (Exception, psycopg2.DatabaseError) as error:
        logger.error(error)
    return True

def check_telethon_session(config, logger):
    """check creds and rights of each user"""
    for user in config:
        if str(user) != "DEFAULT" and str(user) != "pgsql":
            print("----------------------------------------------------------")
            print("api_id: "+config[user]["api_id"])
            config_set = list(config[user].values())[:-1]
            session = TelegramClient(*config_set)

            try:
                async def main():
                    my_data = await session.get_me()
                    phone = my_data.phone[2:]
                    bot_access = config[user]["bot_access"]
                    request = f'UPDATE public.admin SET bot_access = {bot_access} ' \
                              f'WHERE user_id = (SELECT id FROM public."user" WHERE phone LIKE \'%{phone}\')'

                    response = pgsql_update(
                        request=request,
                        logger=logger,
                        **config["pgsql"]
                    )
                    if response == 0:
                        logger.error(f"The user:{my_data.username} is absent in SB as user or as admin")
                        raise Exception(f"The user:{my_data.username} is absent in SB as user or as admin")
                    if response > 1:
                        logger.error("More then 1 user has the same phone number in SB")
                        raise Exception("More then 1 user has the same phone number in SB")

                with session:
                    session.loop.run_until_complete(main())
            except:
                logger.error("The test session isn't created")
                raise Exception("The test session isn't created")

def check_worktime_of_supportbot(context, scenario):
    """check worktime of support bot """
    time_now = datetime.datetime.utcnow().time()
    if time_now <= datetime.time(8, 0, 0) or time_now >= datetime.time(23, 0, 0):
        scenario.skip("OOPS: Assumption not met")
        context.logger.error("Support bot does not work from 08:00 to 23:00 UTC")