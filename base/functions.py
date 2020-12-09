import pyexcel
import re
import random
def find_table():
    table = pyexcel.get_book_dict(file_name='utiles/bot_file.xls')
    return table

def find_text_from_table(code):
    table = pyexcel.get_book_dict(file_name='utiles/bot_file.xls')
    for row in table['pyexcel_sheet1']:
        if code in row:
            return row[4]

def find_button(messages, button_name):
    for message in messages:
        if message.buttons is None:
            continue
        for butt_row in message.buttons:
            for button in butt_row:
                if re.search(button_name,button.text ):
                    return button
                # if button_name in button.text:
                #     return button

def check_message_by_list(mesage, lis):
    for part in lis:
        if part not in mesage:
            return False
    return True


def get_random_month_day(min=2, max=28):
    return random.randint(min, max)

def get_random_file_path():
    number_file = random.randint(1,5)
    return 'files/{}.jpg'.format(number_file)