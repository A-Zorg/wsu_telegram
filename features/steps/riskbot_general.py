import random
import re
from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list, get_random_month_day, get_random_file_path
from base.google_table_function import GSpread
from base.sql_functions import pgsql_select, pgsql_update

logger = LogGen.loggen()

""""""
def to_int(text):
    return int(text)

def to_list(text):
    return eval(text)

register_type(Number=to_int, List=to_list)

role_dict={
    'user' : 'context.user',
    'risk_1' : 'context.risk_1',
    'risk_2' : 'context.risk_2',
    'risk_3' : 'context.risk_3',
}


@step("risk {role} click the button -{button}- #message:{number:Number}")
def step_impl(context, role, button, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    client.click_button(button,mess_quant=number)

@step("risk {role} click one of the button -{button1}- or -{button2}- #message:{number:Number}")
def step_impl(context, role, button1, button2, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    try:
        client.click_button(button1,mess_quant=number)
        assert client.check_message('Подписка на Лекцию Арика удалена', mess_quant=number)
    except:
        client.click_button(button2, mess_quant=number)
        assert client.check_message('Вы подписались на Лекцию Арика', mess_quant=number)

@step("risk {role} click the button -{button}- in group #message:{number:Number}")
def step_impl(context, role, button, number):
    context_role = eval(role_dict[role])
    group = ' '.join(context.bot[1].split('_'))
    client = User(context_role, group)
    client.click_button_wit4sec_waiting(button,mess_quant=number)

@step("risk {role} - send message -{message}-")
def step_impl(context,role, message):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    client.send_message(message)

@step("risk {role} - send file")
def step_impl(context,role):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    path = get_random_file_path()
    with open(path, 'rb') as file:
        client.send_file(file=file)

@step("risk {role} - save the data of photo #message:{number:Number}")
def step_impl(context, role, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    messages = client.get_messages(quantity_mess=number)

    for message in messages:
        if message.media:
            try:
                context.photo.append(message.media.document.thumbs)
            except:
                context.photo = [message.media.document.thumbs]

@step("risk compared photos should be {comp}")
def step_impl(context,comp):
    if comp == 'equal':
        assert all([element == context.photo[0] for element in context.photo])
    else:
        assert not all(context.photo)

@step("risk {role} check message : -{message}- #message:{number:Number}")
def step_impl(context, role, message, number):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[0])
    assert agent.check_message(message, mess_quant=number)

@step("risk {role} check message : -{message}- in group #message:{number:Number}")
def step_impl(context, role, message, number):
    context_role = eval(role_dict[role])
    group = ' '.join(context.bot[1].split('_'))
    try:
        group = int(group)
    except:
        group = str(group)
    agent = User(context_role, group)
    assert agent.check_message(message, mess_quant=number)

@step("risk {role} check message : {riskman_from} plus {part_text}")
def step_impl(context, role, riskman_from, part_text):
    context_role = eval(role_dict[role])
    risk_major = User(context_role, context.bot[0])

    context_role = eval(role_dict[riskman_from])
    risk_minor = User(context_role, context.bot[0])
    message = risk_minor.get_profile_fl_name_username() +' '+ part_text
    assert risk_major.check_message(message)

@step("risk {role} check data of ticket #message:{number:Number}")
def step_impl(context, role, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    messages = client.get_messages(quantity_mess=number)

    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("risk {role} check data of ticket in group #message:{number:Number}")
def step_impl(context, role, number):
    context_role = eval(role_dict[role])
    group = ' '.join(context.bot[1].split('_'))
    client = User(context_role, group)
    messages = client.get_messages(quantity_mess=number)

    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("risk {role} - add to list_info_ticket some agent")
def step_impl(context,role):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    profile = client.get_profile_fl_name_username()
    context.list_info_ticket.append(profile)

@step("risk {role} - check message by list_info_ticket{checklist:List} #message:{number:Number}")
def step_impl(context,role, checklist, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])

    messages = client.get_messages(quantity_mess=5)
    message = messages[number-1]
    for i in checklist:
        assert check_message_by_list(message.text, context.list_info_ticket[i])

@step("risk {role} click the button -{button}- in SupportBot #message:{number:Number}")
def step_impl(context, role, button, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[2])
    client.click_button(button,mess_quant=number)

@step("risk {role} check message : -{message}- in SupportBot #message:{number:Number}")
def step_impl(context, role, message, number):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[2])
    assert agent.check_message(message, mess_quant=number)

@step("The riskman maintains the user: {answer}")
def step_impl(context, answer):
    #get hr_id of riskbot
    risk3_context_role = eval(role_dict["risk_3"])
    risk_3 = User(risk3_context_role, context.bot[0])
    risk_username = risk_3.get_profile_fl_name_username().split('@')[1][:-1]
    hr_id_request = f'SELECT hr_id FROM public."user" WHERE tg_username=\'{risk_username}\''
    risk_hr_id = pgsql_select(request=hr_id_request, **context.my_config['pgsql'])[0][0]

    #pick riskman
    user_context_role = eval(role_dict["user"])
    user = User(user_context_role, context.bot[0])
    user_username = user.get_profile_fl_name_username().split('@')[1][:-1]
    if answer == 'true':
        user_request = f'UPDATE public."user" SET riskman1 = {risk_hr_id} WHERE tg_username = \'{user_username}\''
    elif answer == 'false':
        user_request = f'UPDATE public."user" SET riskman1 = null WHERE tg_username = \'{user_username}\''
    result = pgsql_update(request=user_request, **context.my_config['pgsql'])
    assert result == 1

@step("{role} on {answer}")
def step_impl(context,role, answer):
    risk_context_role = eval(role_dict[role])
    risk = User(risk_context_role, context.bot[0])

    risk.send_message('/start')
    risk.click_button('Админ')

    if risk.button_is_disappeared(button_name=answer) == False:
        risk.click_button(answer)

@step("check riskman who could take the ticket: {check_list}")
def step_impl(context, check_list):
    group = ' '.join(context.bot[1].split('_'))
    users = [
        User(context.risk_1, context.bot[0]),
        User(context.risk_2, context.bot[0]),
        User(context.risk_3, context.bot[0]),
        User(context.risk_1, group)
    ]

    check_list = eval(check_list)
    for i in range(len(users)):
        if check_list[i] == '-':
            messages = users[i].get_messages()
            for message in messages:
                if message.text.startswith(context.list_info_ticket[0]):
                    assert check_message_by_list(message.text, context.list_info_ticket) == False
        elif check_list[i] == '+':
            messages = users[i].get_messages()
            for message in messages:
                if message.text.startswith(context.list_info_ticket[0]):
                    assert check_message_by_list(message.text, context.list_info_ticket)
                    break
            else:
                assert False
        elif check_list[i] == '++':
            assert users[i].check_message(context.list_info_ticket[0] + " не обработана в теч ")

@step("risk takes the ticket: {risk_man}")
def step_impl(context, risk_man):
    group = ' '.join(context.bot[1].split('_'))
    bot = context.bot[0]

    agent = eval(risk_man)
    agent.immutable_after_click('Взять тикет')

@step("the ticket is intersepted by: {check_list}")
def step_impl(context, check_list):
    group = ' '.join(context.bot[1].split('_'))
    users = [
        User(context.risk_1, context.bot[0]),
        User(context.risk_2, context.bot[0]),
        User(context.risk_3, context.bot[0]),
        User(context.risk_2, group)
    ]

    check_list = eval(check_list)
    for i in range(len(check_list)):
        if check_list[i] == "+":
            users[i].immutable_after_click('Перехватить тикет')
        elif check_list[i] == "-":
            assert users[i].button_is_disappeared('Перехватить тикет')

@step("change risk_google_table: {gt_change}")
def step_impl(context, gt_change):
    google_t = GSpread(context.my_config['GS']['risk_spreadsheet'])
    work_sheet = google_t.worksheet('Main')
    if gt_change == 'clean fields:"Заказаное inv"':
        work_sheet.update('D6:D25', [['']] * 19)
        work_sheet.update('G6:G25', [['']] * 19)
        work_sheet.update('I6:I25', [['']] * 19)
        work_sheet.update('K6:K25', [['']] * 19)
    elif 'amount of rows to the fields:"Заказаное inv"' in gt_change:
        amount = int(re.findall(r'add (.*) amount of rows to the fields:"Заказаное inv"', gt_change)[0])
        work_sheet.update('D6:D25', [[12]] * amount)
        work_sheet.update('G6:G25', [[12]] * amount)
        work_sheet.update('I6:I25', [[12]] * amount)
        work_sheet.update('K6:K25', [[12]] * amount)

@step("check report after distribution NBP: {persons_qty} and {nbp}")
def step_impl(context, persons_qty, nbp):
    group = ' '.join(context.bot[1].split('_'))
    agent = User(context.risk_2, group)
    for fail in range(int(persons_qty)+1):
        with open('C:\\Users\\wsu\\Desktop\\xxx.txt', 'a') as file:
            file.write(str(fail) + '\n')
        success = int(persons_qty)-fail
        message = f"Отправка данных {nbp} завершена\nОтправлено: {success} заявок\nНе удалось отправить: {fail} заявок"
        if agent.check_message(search_text=message):
            break
    else:
        assert False

@step("add {platform_type} INV to the google_risk_table: {amount}")
def step_impl(context, platform_type, amount):
    google_t = GSpread(context.my_config['GS']['risk_spreadsheet'])
    work_sheet = google_t.worksheet('Main')

    user_context_role = eval(role_dict["user"])
    user = User(user_context_role, context.bot[0])
    user_username = user.get_profile_fl_name_username().split('@')[1][:-1]
    hr_id_request = f'SELECT hr_id FROM public."user" WHERE tg_username=\'{user_username}\''
    user_hr_id = pgsql_select(request=hr_id_request, **context.my_config['pgsql'])[0][0]

    try:
        work_sheet.find(str(user_hr_id))
    except:
        work_sheet.update('A14', str(user_hr_id))

    user_in_table = work_sheet.find(str(user_hr_id))
    user_row = user_in_table.row

    if platform_type == "Takion":
        work_sheet.update(f'E{user_row}', amount)
        # work_sheet.update(f'F{user_row}', amount)
    elif platform_type == "Sterling 5 N":
        work_sheet.update(f'H{user_row}', amount)
        work_sheet.update(f'J{user_row}', amount)
    elif platform_type == "Sterling 4":
        work_sheet.update(f'L{user_row}', amount)

@step("risk {role} check presence new ticket in the opened tickets: {answer}")
def step_impl(context, role, answer):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[0])
    ticket_number = context.list_info_ticket[0][1:]
    assert str(agent.check_message("Ticket №" + ticket_number)) == answer














































