from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list
import re
logger = LogGen.loggen()

@step("ops check data of ticket")
def step_impl(context):
    agent = User(context.ops1, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(context.list_info_ticket)+'\n'+message.text)

@step("ops check message: -{message}-")
def step_impl(context, message):
    agent = User(context.ops1, context.bot[0])
    assert agent.check_message(message)

@step("ops check message after waiting")
def step_impl(context):
    agent = User(context.ops1, context.bot[0])
    message = agent.get_message()
    assert "Заявка {} не обработана в теч ".format(context.list_info_ticket[0][1:]) in message

@step("ops click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.ops1, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("ops add event to list_info_ticket: -{message}-")
def step_impl(context, message):
    agent = User(context.ops1, context.bot[0])
    profile = agent.get_profile_fl_name_username()
    if '➡' in message:
        context.list_info_ticket.append(message)
    elif 'Коммент от' in message:
        result = re.search(r'(\(.+\))', profile)
        context.list_info_ticket.append('Коммент от '+result.group(0)[1:-1]+': comment')
    else:
        context.list_info_ticket.append(message+profile)
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(context.list_info_ticket)+'\n')

@step("ops choose a category of ticket")
def step_impl(context):
    agent = User(context.ops1, context.bot[0])
    for row in context.table:
        check_list = ['Вы действительно хотите сохранить категорию:', row['button'],'для тикета ' + context.list_info_ticket[0]]
        agent.click_button(row['button'])
        messages = agent.get_messages()
        assert check_message_by_list(messages[0].text, check_list)
        agent.click_button(row['answer'])

@step("ops send message -{message}-")
def step_impl(context, message):
    client = User(context.ops1, context.bot[0])
    client.send_message(message)

@step("ops empty button -{button}-")
def step_impl(context, button):
    client = User(context.ops1, context.bot[0])
    assert client.button_is_disappeared(button)

@step("ops2 try to click: -{button}-")
def step_impl(context, button):
    client = User(context.ops2, context.bot[0])
    assert client.immutable_after_click(button)

@step("ops2 click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.ops2, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("ops2 check data of ticket")
def step_impl(context):
    agent = User(context.ops2, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)
@step("ops2 empty button -{button}-")
def step_impl(context, button):
    client = User(context.ops2, context.bot[0])
    assert client.button_is_disappeared(button)

@step("Compare last message in department in ops")
def step_impl(context):
    ops1 = User(context.ops1, context.bot[0])
    ops2 = User(context.ops2, context.bot[0])

    messages_ops2 = ops2.get_messages()
    message_ops1 = ops1.get_message()
    message_ops2 = None
    for message in messages_ops2:
        if message.text == message_ops1:
            message_ops2 = message.text
    assert message_ops1==message_ops2
