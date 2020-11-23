from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
from base.functions import check_message_by_list
import re
logger = LogGen.loggen()

@step("user check list")
def step_impl(context):
    with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
        file.write(str(context.list_info_ticket))

@step("user click the button -{button}-")
def step_impl(context, button):
    user = User(context.user, context.bot[0])
    user.click_button(button,mess_quant=3)

@step("user check message: -{message}-")
def step_impl(context, message):
    user = User(context.user, context.bot[0])
    assert user.check_message(message,mess_quant=3)

@step("user check message in bot")
def step_impl(context):
    user = User(context.user, context.bot[1])

    part1 = 'Ваш тикет из ⚡️ Smart.Support:'
    part2 = context.list_info_ticket[1]
    part3 = 'From: '+context.list_info_ticket[2]

    assert user.check_message(part1,mess_quant=2)
    assert user.check_message(part2, mess_quant=2)
    assert user.check_message(part3, mess_quant=2)

@step("user after taking the ticket check the message")
def step_impl(context):
    user = User(context.user, context.bot[0])
    message = 'Ваш запрос '+ context.list_info_ticket[0]+' принял'+context.list_info_ticket[-1][13:]
    assert user.check_message(message)

@step("user empty button -{button}-")
def step_impl(context, button):
    client = User(context.user, context.bot[0])
    assert client.button_is_disappeared(button, mess_quant=3)

@step("user message of closed message")
def step_impl(context):
    user = User(context.user, context.bot[0])
    message = user.get_message()
    assert context.list_info_ticket[0] in message
    assert 'Пожалуйста, оцени насколько качественно мы тебе помогли.' in message
    assert 'Любые комментарии приветствуются!' in message

@step("user send message -{message}-")
def step_impl(context, message):
    client = User(context.user, context.bot[0])
    client.send_message(message)

@step("user check data of ticket")
def step_impl(context):
    user = User(context.user, context.bot[0])
    message = user.get_message()
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(message)+'\n'+str(context.list_info_ticket))
    if message.startswith(context.list_info_ticket[0]):
        assert check_message_by_list(message, context.list_info_ticket)
    else:
        assert False