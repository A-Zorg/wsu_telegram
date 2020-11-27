from behave import use_fixture
from base.fixtures import finbot, support, space
from allure_behave.hooks import allure_report

bot_fixture_dict = {
                'sd_test3_bot' : 'support',
                'sd_test12_bot' : 'finbot',
                'sd_test4_bot' : 'space',
}

"""turn on fixture for each feature"""
def before_feature(context, feature):
    bot = feature.tags[0]
    fixture = eval(bot_fixture_dict[bot])
    context.bot = feature.tags
    use_fixture(fixture, context)


"""create allure reports"""
allure_report("reports/")



