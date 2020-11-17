from behave import *
from base.user_telegram import User
import re


@step("client get a ticket number")
def step_impl(context):
    client = User(context.client, context.bot[0])
    message = client.get_message()
    result = re.search(r'(#\d+)', message)
    context.ticket_number = result.group(0)

@step("agent check a ticket number")
def step_impl(context):
    # with open('C:/Users/wsu/Desktop/ttt.txt','a') as file:
    #     file.write(str(context.ticket_number))
    client = User(context.agent, context.bot[0])
    assert client.check_message(context.ticket_number)

@step("agent check a ticket message -{message}-")
def step_impl(context, message):
    agent = User(context.agent, context.bot[0])
    assert agent.check_message(message)

@step("agent check a ticket -{message}- and client")
def step_impl(context, message):
    agent = User(context.agent, context.bot[0])
    client = User(context.client, context.bot[0])
    profile = client.get_profile_fl_name_username()
    assert agent.check_message(message+profile)

@step("agent check a ticket -{message}- and agent")
def step_impl(context, message):
    agent = User(context.agent, context.bot[0])
    profile = agent.get_profile_fl_name_username()
    assert agent.check_message(message+profile)

@step("agent check a ticket -{message}- and another agent")
def step_impl(context, message):
    another_agent = User(context.another_agent, context.bot[0])
    profile = another_agent.get_profile_fl_name_username()
    assert another_agent.check_message(message+profile)

@step("agent click the button -{button}-")
def step_impl(context, button):
    agent = User(context.agent, context.bot[0])
    agent.click_button(button)

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

@step("agent check message -{message}-{code}-")
def step_impl(context, message, code):
    client = User(context.client, context.bot[0])
    assert client.check_message_code(code)

@step("another agent click the button -{button}-")
def step_impl(context, button):
    another_agent = User(context.another_agent, context.bot[0])
    another_agent.click_button(button)