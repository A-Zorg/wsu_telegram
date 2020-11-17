from behave import *
from base.user_telegram import User


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