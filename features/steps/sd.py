from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list
import re
logger = LogGen.loggen()

@step("sd check message: -{message}-")
def step_impl(context, message):
    agent = User(context.sd1, context.bot[0])
    assert agent.check_message(message)

@step("sd add event to list_info_ticket: -{message}-")
def step_impl(context, message):
    agent = User(context.sd1, context.bot[0])
    profile = agent.get_profile_fl_name_username()
    if '➡' in message:
        context.list_info_ticket.append(message)
    elif 'Коммент от' in message:
        result = re.search(r'(\(.+\))', profile)
        context.list_info_ticket.append('Коммент от '+result.group(0)[1:-1]+': comment')
    else:
        context.list_info_ticket.append(message+profile)
    # with open('C:/Users/wsu/Desktop/ttt.txt','a', encoding='utf-8') as file:
    #     file.write(str(context.list_info_ticket)+'\n')

@step("sd click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.sd1, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("sd check data of ticket")
def step_impl(context):
    agent = User(context.sd1, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("sd check photo or another media")
def step_impl(context):
    agent = User(context.sd1, context.bot[0])
    messages = agent.get_messages()
    if messages[0].media:
        assert True
    else:
        assert False

@step("sd send message -{message}-")
def step_impl(context, message):
    client = User(context.sd1, context.bot[0])
    client.send_message(message)

@step("sd empty button -{button}-")
def step_impl(context, button):
    client = User(context.sd1, context.bot[0])
    assert client.button_is_disappeared(button)

@step("sd2 try to click: -{button}-")
def step_impl(context, button):
    client = User(context.sd2, context.bot[0])
    assert client.immutable_after_click(button)

@step("sd2 click the button -{button}- {quantity}")
def step_impl(context, button, quantity):
    agent = User(context.sd2, context.bot[0])
    agent.click_button(button, mess_quant=int(quantity))

@step("sd2 check data of ticket")
def step_impl(context):
    agent = User(context.sd2, context.bot[0])
    messages = agent.get_messages()
    for message in messages:
        if message.text.startswith(context.list_info_ticket[0]):
            assert check_message_by_list(message.text, context.list_info_ticket)

@step("sd2 empty button -{button}-")
def step_impl(context, button):
    client = User(context.sd2, context.bot[0])
    assert client.button_is_disappeared(button)

@step("Compare last message in department in sd")
def step_impl(context):
    sd1 = User(context.sd1, context.bot[0])
    sd2 = User(context.sd2, context.bot[0])

    messages_sd2 = sd2.get_messages()
    message_sd1 = sd1.get_message()
    message_sd2 = None
    for message in messages_sd2:
        if message.text == message_sd1:
            message_sd2 = message.text
    assert message_sd1 == message_sd2