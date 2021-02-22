from telethon import  TelegramClient
from behave import fixture
import configparser

config = configparser.ConfigParser()
config.read("config/cred.ini")


@fixture()
def finbot(context):
    context.agent = TelegramClient(**config['fin_ops_lvl1_risk'])
    context.client = TelegramClient(**config['client_spacebot(project-cyprus)'])
    context.another_agent = TelegramClient(**config['fin_sd_pr_risk(nightwatch)'])
    yield

@fixture()
def support(context):
    context.user = TelegramClient(**config['client_spacebot(project-cyprus)'])
    context.ops1 = TelegramClient(**config['fin_ops_lvl1_risk'])
    context.ops2 = TelegramClient(**config['ops_lvl1'])
    context.sd1 = TelegramClient(**config['fin_sd_pr_risk(nightwatch)'])
    context.sd2 = TelegramClient(**config['sd_pr'])
    context.it1 = TelegramClient(**config['it_hr1'])
    context.it2 = TelegramClient(**config['it_hr2'])
    yield



@fixture()
def space(context):
    context.user = TelegramClient(**config['client_spacebot(project-cyprus)'])
    context.lvl1_1 = TelegramClient(**config['fin_ops_lvl1_risk'])
    context.lvl1_2 = TelegramClient(**config['ops_lvl1'])
    context.pr_1 = TelegramClient(**config['fin_sd_pr_risk(nightwatch)'])
    context.pr_2 = TelegramClient(**config['sd_pr'])
    context.hr_1 = TelegramClient(**config['it_hr1'])
    context.hr_2 = TelegramClient(**config['it_hr2'])
    context.project = context.user
    context.cyprus = context.user
    yield


@fixture()
def risk(context):
    context.user = TelegramClient(**config['client_spacebot(project-cyprus)'])
    context.risk_1 = TelegramClient(**config['fin_ops_lvl1_risk'])
    context.risk_2 = TelegramClient(**config['fin_sd_pr_risk(nightwatch)'])
    yield
