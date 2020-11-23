from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
import re
logger = LogGen.loggen()

@step("client click the button -{button}-")
def step_impl(context, button):
    client = User(context.client, context.bot[0])
    client.click_button(button)

@when("client send message -{message}-")
def step_impl(context, message):
    client = User(context.client, context.bot[0])
    client.send_message(message)


@step("client get a ticket number")
def step_impl(context):
    client = User(context.client, context.bot[0])
    message = client.get_message()
    result = re.search(r'(#\d+)', message)
    context.ticket_number = result.group(0)

@step("client check a message: Ваш запит -ticket number- прийняв -agent-")
def step_impl(context):
    client = User(context.client, context.bot[0])
    agent = User(context.agent, context.bot[0])
    profile = agent.get_profile_fl_name_username()
    assert client.check_message('Ваш запит '+context.ticket_number+' прийняв '+profile)

@step("client check a message: Ваш запит -ticket number- прийняв -another agent-")
def step_impl(context):
    client = User(context.client, context.bot[0])
    another_agent = User(context.agent, context.bot[0])
    profile = another_agent.get_profile_fl_name_username()
    assert client.check_message('Ваш запит '+context.ticket_number+' прийняв '+profile)

@step("client empty button -{button}-")
def step_impl(context, button):
    client = User(context.agent, context.bot[0])
    assert client.button_is_disappeared(button)

@step("client check message -{message}-{code}-")
def step_impl(context, message, code):
    client = User(context.client, context.bot[0])
    assert client.check_message_code(code)

@given("client send message -{message}-")
def step_impl(context, message):
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(context.bot))
    client = User(context.client, context.bot[0])
    client.send_message(message)