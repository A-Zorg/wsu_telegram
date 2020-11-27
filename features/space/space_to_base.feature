@sd_test4_bot
Feature: to base
   Background: base
    Given user - send message -/start-
     And user - send message -message-
     And pause 3

   Scenario: to base
    Given lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Оформить тикет в базу- quantity 2
     And hr_1 click the button -Отмена- quantity 2
     And hr_1 click the button -Оформить тикет в базу- quantity 2