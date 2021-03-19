import configparser
from telethon import TelegramClient
from behave import fixture

config = configparser.ConfigParser()
config.read("config/cred.ini")


@fixture()
def finbot(context):
    """the fixture for Fin bot"""
    context.agent = TelegramClient(*list(config['fin_ops_lvl1_risk'].values())[:-1])
    context.client = TelegramClient(*list(config['client_spacebot(project-cyprus)'].values())[:-1])
    context.another_agent = TelegramClient(*list(config['fin_sd_pr_risk(nightwatch)'].values())[:-1])
    yield


@fixture()
def supportbot(context):
    """the fixture for Support bot"""
    context.user = TelegramClient(*list(config['client_spacebot(project-cyprus)'].values())[:-1])
    context.ops1 = TelegramClient(*list(config['fin_ops_lvl1_risk'].values())[:-1])
    context.ops2 = TelegramClient(*list(config['ops_lvl1'].values())[:-1])
    context.sd1 = TelegramClient(*list(config['fin_sd_pr_risk(nightwatch)'].values())[:-1])
    context.sd2 = TelegramClient(*list(config['sd_pr'].values())[:-1])
    context.it1 = TelegramClient(*list(config['it_hr1'].values())[:-1])
    context.it2 = TelegramClient(*list(config['it_hr2'].values())[:-1])
    yield


@fixture()
def spacebot(context):
    """the fixture for Space bot"""
    context.user = TelegramClient(*list(config['client_spacebot(project-cyprus)'].values())[:-1])
    context.lvl1_1 = TelegramClient(*list(config['fin_ops_lvl1_risk'].values())[:-1])
    context.lvl1_2 = TelegramClient(*list(config['ops_lvl1'].values())[:-1])
    context.pr_1 = TelegramClient(*list(config['fin_sd_pr_risk(nightwatch)'].values())[:-1])
    context.pr_2 = TelegramClient(*list(config['sd_pr'].values())[:-1])
    context.hr_1 = TelegramClient(*list(config['it_hr1'].values())[:-1])
    context.hr_2 = TelegramClient(*list(config['it_hr2'].values())[:-1])
    context.project = context.user
    context.cyprus = context.user
    yield

@fixture()
def riskbot(context):
    """the fixture for Risk bot"""
    context.user = TelegramClient(*list(config['client_spacebot(project-cyprus)'].values())[:-1])
    context.risk_1 = TelegramClient(*list(config['fin_ops_lvl1_risk'].values())[:-1])
    context.risk_2 = TelegramClient(*list(config['fin_sd_pr_risk(nightwatch)'].values())[:-1])
    context.risk_3 = TelegramClient(*list(config['it_hr2'].values())[:-1])
    yield
