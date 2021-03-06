import re
import time
import datetime
from behave import *
from base.user_telegram import User


@step("background send message -{message}-")
def step_impl(context, message):
    client = User(context.user, context.bot[0])
    client.send_message(message)

@step("background create list_info_ticket: message is -{message}-")
def step_impl(context, message):
    client = User(context.user, context.bot[0])
    start = time.time()
    while True:
        time.sleep(1)
        messsage = client.get_message()
        result = re.search(r'(#\d+)', messsage)
        if result:
            break
        if time.time()-start>20:
            raise Exception("20 sec expired")
        client.send_message(message)
    profile = client.get_profile_fl_name_username()
    context.list_info_ticket = [result.group(0), message, profile]

@step("interuser pause")
def step_impl(context):
    time.sleep(3)

@step("user pause {sec}")
def step_impl(context, sec):
    time.sleep(float(sec))

@step("pause {sec}")
def step_impl(context, sec):
    time.sleep(float(sec))


@step("check work_datetime: {workdays} - {workhours} - {message}")
def step_impl(context, workdays, workhours, message):
    """
    workday = x-x-x-x-x
    workhours x-x
    """
    client = User(context.user, context.bot[0])
    today = datetime.datetime.utcnow().weekday() + 1
    hour = datetime.datetime.utcnow().hour

    if str(today) not in workdays.split('-'):
        context.scenario.skip("not worktime")
    elif int(workhours.split('-')[1]) <= hour < int(workhours.split('-')[0]):
        context.scenario.skip("not worktime")

    if message:
        assert client.check_message(message)

