from behave import *
from base.user_telegram import User
from base.functions import check_message_by_list
import re

"""Steps as IT in Supportbot"""

@step("it check message: -{message}-")
def step_impl(context, message):
    agent = User(context.it1, context.bot[0])
    assert agent.check_message(message, mess_quant=3)

@step("it add event to list_info_ticket: -{message}-")
def step_impl(context, message):
    agent = User(context.it1, context.bot[0])
    profile = agent.get_profile_fl_name_username()
    if '➡' in message:
        context.list_info_ticket.append(message)
    elif 'Коммент от' in message:
        result = re.search(r'(\(.+\))', profile)
        context.list_info_ticket.append('Коммент от '+result.group(0)[1:-1]+': comment')
    else:
        context.list_info_ticket.append(message+profile)

@step("it click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.it1, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("it check data of ticket")
def step_impl(context):
    agent = User(context.it1, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("it check photo or another media")
def step_impl(context):
    agent = User(context.it1, context.bot[0])
    messages = agent.get_messages()
    if messages[0].media:
        assert True
    else:
        assert False

@step("it send message -{message}-")
def step_impl(context, message):
    client = User(context.it1, context.bot[0])
    client.send_message(message)

@step("it empty button -{button}-")
def step_impl(context, button):
    client = User(context.it1, context.bot[0])
    assert client.button_is_disappeared(button)

@step("it check message after waiting")
def step_impl(context):
    agent = User(context.it1, context.bot[0])
    message = agent.get_message()
    assert "Заявка {} не обработана в теч ".format(context.list_info_ticket[0][1:]) not in message

@step("it choose a category of ticket")
def step_impl(context):
    agent = User(context.it1, context.bot[0])
    for row in context.table:
        check_list = ['Вы действительно хотите сохранить категорию:', row['button'],'для тикета ' + context.list_info_ticket[0]]
        agent.click_button(row['button'])
        messages = agent.get_messages()
        assert check_message_by_list(messages[0].text, check_list)
        agent.click_button(row['answer'])

@step("it2 try to click: -{button}-")
def step_impl(context, button):
    client = User(context.it2, context.bot[0])
    assert client.immutable_after_click(button)

@step("it2 click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.it2, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("it2 check data of ticket")
def step_impl(context):
    agent = User(context.it2, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("it2 empty button -{button}-")
def step_impl(context, button):
    client = User(context.it2, context.bot[0])
    assert client.button_is_disappeared(button)

@step("Compare last message in department in it")
def step_impl(context):
    it1 = User(context.it1, context.bot[0])
    it2 = User(context.it2, context.bot[0])

    messages_it2 = it2.get_messages()
    message_it1 = it1.get_message()
    message_it2 = None
    for message in messages_it2:
        if message.text == message_it1:
            message_it2 = message.text
    assert message_it1==message_it2