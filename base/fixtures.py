from telethon import  TelegramClient
from behave import fixture
import  os

@fixture()
def user(context):
    agent_dict = eval(os.environ.get('chan'))
    client_dict = eval(os.environ.get('stalone'))
    another_agent_dict = eval(os.environ.get('seagal'))

    context.agent = TelegramClient('chan', agent_dict['api_id'], agent_dict['api_hash'])
    context.client = TelegramClient('stalone', client_dict['api_id'] , client_dict['api_hash'])
    context.another_agent = TelegramClient('seagal', another_agent_dict['api_id'] , another_agent_dict['api_hash'])
    yield
    # context.agent.disconnect()
    # context.client.disconnect()