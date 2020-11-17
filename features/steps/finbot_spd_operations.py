from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
# use_step_matcher("re")
logger = LogGen.loggen()

@step("client click the button -{button}-")
def step_impl(context, button):
    client = User(context.client, context.bot[0])
    client.click_button(button)

@when("client send message -{message}-")
def step_impl(context, message):
    client = User(context.client, context.bot[0])
    client.send_message(message)


@then("agent get message -{message}-")
def step_impl(context, message):
    agent = User(context.agent, context.bot[0])
    assert agent.check_message(message)