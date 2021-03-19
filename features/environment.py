import configparser
from behave import use_fixture
from base.fixtures import finbot, supportbot, spacebot, riskbot
from allure_behave.hooks import allure_report
from base.functions import check_telethon_session, check_worktime_of_supportbot
from base.user_telegram import User
from utiles.logger_file import logger_config



bot_fixture_dict = {
    'sd_test3_bot' : 'supportbot',
    'sd_test12_bot' : 'finbot',
    'sd_test4_bot' : 'spacebot',
    'sd_test8_bot' : 'riskbot'
}

def before_all(context):
    context.logger = logger_config()
    try:
        config = configparser.ConfigParser()
        config.read("config/cred.ini")
        context.my_config = config
    except:
        context.logger.error("The cred file is absent")
    # check_telethon_session(config, context.logger)



def before_feature(context, feature):
    """turn on fixture for each feature"""
    bot = feature.tags[0]
    fixture = eval(bot_fixture_dict[bot])
    context.bot = feature.tags
    try:
        use_fixture(fixture, context)
    except:
        context.logger.error(f'The featue:"{feature.name}" was skiped due to the error in creation of the telethon session')
    check_worktime_of_supportbot(context, feature)

def after_scenario(context, scenario):
    """if scenario is failed, this func closes potentially opened ticket"""
    if str(scenario.status) == "Status.failed":
        bot = scenario.feature.tags[0]
        user = User(context.user, bot)
        try:
            user.click_button("Отменить тикет")
        except:
            pass



#
# """create allure reports"""
# allure_report("allure-results/")
#
#


