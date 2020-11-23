from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
import re
import time


@step("background send message -{message}-")
def step_impl(context, message):
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(context.ticket_number))
    client = User(context.user, context.bot[0])
    client.send_message(message)

@step("background create list_info_ticket: message is -{message}-")
def step_impl(context, message):
    client = User(context.user, context.bot[0])
    mess = client.get_message()
    result = re.search(r'(#\d+)', mess)
    profile = client.get_profile_fl_name_username()
    context.list_info_ticket = [result.group(0),message,profile]

@step("interuser pause")
def step_impl(context):
    time.sleep(1.5)

@step("user pause {sec}")
def step_impl(context, sec):
    time.sleep(float(sec))


