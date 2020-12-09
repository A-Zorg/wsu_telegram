from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list, get_random_month_day, get_random_file_path
import re
import datetime
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
}


@step("risk {role} click the button -{button}- #message:{number:Number}")
def step_impl(context, role, button, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    client.click_button(button,mess_quant=number)

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
    with open('C:/Users/wsu/Desktop/ttt.txt', 'a', encoding='utf-8') as file:
        file.write(str(context.photo) + '\n' )
    with open('C:/Users/wsu/Desktop/ttt.txt', 'a', encoding='utf-8') as file:
        file.write(str(all([element == context.photo[0] for element in context.photo])) + '\n' )
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
    agent = User(context_role, group)
    assert agent.check_message(message, mess_quant=number)

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

