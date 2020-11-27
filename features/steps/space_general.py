from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list
import re
logger = LogGen.loggen()

""""""
def to_int(text):
    return int(text)

register_type(Number=to_int)

role_dict={
    'user' : 'context.user',
    'lvl1_1' : 'context.lvl1_1',
    'lvl1_2' : 'context.lvl1_2',
    'pr_1' : 'context.pr_1',
    'pr_2' : 'context.pr_2',
    'hr_1' : 'context.hr_1',
    'hr_2' : 'context.hr_2',
    'project' : 'context.project',
    'cyprus' : 'context.cyprus',

}

@step("{role} click the button -{button}- quantity {number:Number}")
def step_impl(context, role, button, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    client.click_button(button,mess_quant=number)

@step("{role} click the button -{button}- in ticket_bot # {bot:Number} quantity {number:Number}")
def step_impl(context, role, button, bot, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[bot])
    client.click_button(button,mess_quant=number)

@step("{role} check data of tickets quantity {number:Number}")
def step_impl(context, role, number):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    messages = client.get_messages(quantity_mess=number)

    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            with open('C:/Users/wsu/Desktop/ttt.txt', 'a', encoding='utf-8') as file:
                file.write(str(context.list_info_ticket) + '\n' + str(message.text))
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("{role} check data of tickets in ticket_bot # {bot:Number}")
def step_impl(context, role, bot):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[bot])
    messages = client.get_messages()
    for message in messages:
        if message.text.startswith('Тикет 👐 '+context.list_info_ticket[0][1:]):
            assert check_message_by_list(message.text, context.list_info_ticket[1:3])

@step("{role} check message : -{message}- quantity {number:Number}")
def step_impl(context, role, message, number):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[0])
    assert agent.check_message(message, mess_quant=number)

@step("{role} check empty message : -{message}- quantity {number:Number}")
def step_impl(context, role, message, number):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[0])
    assert agent.check_message(message, mess_quant=number) is False

@step("{role} check message : -{message}- in bot # {bot:Number} quantity {number:Number}")
def step_impl(context, role, message, bot, number):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[bot])
    assert agent.check_message(message, mess_quant=number)

@step("{role} - empty button -{button}-")
def step_impl(context, role, button):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    assert client.button_is_disappeared(button, mess_quant=3)

@step("{role} - send message -{message}-")
def step_impl(context,role, message):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    client.send_message(message)

@step("{role} - add event to list_info_ticket: -{message}-")
def step_impl(context, role, message):
    context_role = eval(role_dict[role])
    client = User(context_role, context.bot[0])
    profile = client.get_profile_fl_name_username()
    if '➡' in message:
        context.list_info_ticket.append(message)
    elif 'Коммент от' in message:
        result = re.search(r'(\(.+\))', profile)
        context.list_info_ticket.append('Коммент от '+result.group(0)[1:-1]+': comment')
    else:
        context.list_info_ticket.append(message+profile)

@step("{role} - check photo or another media")
def step_impl(context, role):
    context_role = eval(role_dict[role])
    agent = User(context_role, context.bot[0])
    messages = agent.get_messages(quantity_mess=3)
    if messages[0].media:
        assert True
    else:
        assert False