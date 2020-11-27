from behave import *
from base.user_telegram import User
from utiles.logger_file import LogGen
# use_step_matcher("re")
logger = LogGen.loggen()

@given("client clicks a set of buttons")
def step_impl(context):
    client = User(context.client, context.bot[0])
    client.send_message('/start')
    for row in context.table:
        client.click_button(row['button_name'])

@step("client click the button -{button}- (background)" )
def step_impl(context, button):
    client = User(context.client, context.bot[0])
    client.click_button(button)

@step("client send message -{message}- (background)")
def step_impl(context, message):
    client = User(context.client, context.bot[0])
    client.send_message(message)