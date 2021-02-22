from behave import *
from base.user_telegram import User


"""Steps as agent in Finbot"""

@then("agent get message -{message}-")
def step_impl(context, message):
    agent = User(context.agent, context.bot[0])
    assert agent.check_message(message)

@step("agent check a ticket number")
def step_impl(context):
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

@step("agent check message -{message}-{code}-")
def step_impl(context, message, code):
    client = User(context.client, context.bot[0])
    assert client.check_message_code(code)

@step("another agent click the button -{button}-")
def step_impl(context, button):
    another_agent = User(context.another_agent, context.bot[0])
    another_agent.click_button(button)