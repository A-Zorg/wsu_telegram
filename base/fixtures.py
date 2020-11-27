from telethon import  TelegramClient
from behave import fixture
import  os

@fixture()
def finbot(context):
    agent_dict = eval(os.environ.get('chan'))
    client_dict = eval(os.environ.get('stalone'))
    another_agent_dict = eval(os.environ.get('seagal'))

    context.agent = TelegramClient('chan', agent_dict['api_id'], agent_dict['api_hash'])
    context.client = TelegramClient('stalone', client_dict['api_id'] , client_dict['api_hash'])
    context.another_agent = TelegramClient('seagal', another_agent_dict['api_id'] , another_agent_dict['api_hash'])
    yield
    # context.agent.disconnect()
    # context.client.disconnect()

@fixture()
def support(context):

    user_dict = eval(os.environ.get('stalone'))
    ops1_dict = eval(os.environ.get('chan'))
    ops2_dict = eval(os.environ.get('flash'))
    sd1_dict = eval(os.environ.get('seagal'))
    sd2_dict = eval(os.environ.get('wonder'))
    it1_dict = eval(os.environ.get('batman'))
    it2_dict = eval(os.environ.get('green'))


    context.user = TelegramClient('stalone', user_dict['api_id'] , user_dict['api_hash'])
    context.ops1 = TelegramClient('chan', ops1_dict['api_id'] , ops1_dict['api_hash'])
    context.ops2 = TelegramClient('flash', ops2_dict['api_id'] , ops2_dict['api_hash'])
    context.sd1 = TelegramClient('seagal', sd1_dict['api_id'] , sd1_dict['api_hash'])
    context.sd2 = TelegramClient('wonder', sd2_dict['api_id'] , sd2_dict['api_hash'])
    context.it1 = TelegramClient('batman', it1_dict['api_id'] , it1_dict['api_hash'])
    context.it2 = TelegramClient('green', it2_dict['api_id'] , it2_dict['api_hash'])
    yield



@fixture()
def space(context):
    user_dict = eval(os.environ.get('stalone'))
    ops1_dict = eval(os.environ.get('chan'))
    ops2_dict = eval(os.environ.get('flash'))
    sd1_dict = eval(os.environ.get('seagal'))
    sd2_dict = eval(os.environ.get('wonder'))
    it1_dict = eval(os.environ.get('batman'))
    it2_dict = eval(os.environ.get('green'))

    context.user = TelegramClient('stalone', user_dict['api_id'], user_dict['api_hash'])
    context.lvl1_1 = TelegramClient('chan', ops1_dict['api_id'], ops1_dict['api_hash'])
    context.lvl1_2 = TelegramClient('flash', ops2_dict['api_id'], ops2_dict['api_hash'])
    context.pr_1 = TelegramClient('seagal', sd1_dict['api_id'], sd1_dict['api_hash'])
    context.pr_2 = TelegramClient('wonder', sd2_dict['api_id'], sd2_dict['api_hash'])
    context.hr_1 = TelegramClient('batman', it1_dict['api_id'], it1_dict['api_hash'])
    context.hr_2 = TelegramClient('green', it2_dict['api_id'], it2_dict['api_hash'])
    context.project = context.user
    context.cyprus = context.user
    yield