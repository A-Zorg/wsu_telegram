@sd_test4_bot
Feature: forward
   Background: base
    Given user - send message -/start-
     And user - send message -message-
     And background create list_info_ticket: message is -message-

  Scenario Outline: part1
    When lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> check message : -<send_1>- quantity 2
     And <role> click the button -Передать на 1 уровень- quantity 2
     And <role> click the button -Да- quantity 2
    Examples: forward
      | button_1                   | role     | send_1           | send_2      |
      | Передать в HR              |  hr_1    |1 LVL ➡ ️HR     |HR ➡ ️1 LVL|
      | Передать в PR              |  pr_1    |1 LVL ➡ ️PR     |PR ➡ ️1 LVL|
      | Передать в 5 отделение     |  project |1 LVL ➡ ️5 отд. |5 отд. ➡ ️1 LVL|
      | Передать в Проектный отдел |  cyprus  |1 LVL ➡ ️PROJECT|PROJECT ➡ ️1 LVL|
    And lvl1_1 check message : -<send_2>- quantity 2
    And user click the button -Отменить тикет- quantity 2


    Scenario Outline: part2
    When lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> - add event to list_info_ticket: -<send_1>-
     And <role> click the button -Взять тикет- quantity 2
     And <role> - add event to list_info_ticket: -Тикет принял: -
     And <role> click the button -Передать на 1 уровень- quantity 2
     And <role> click the button -Да- quantity 2
     And lvl1_1 - add event to list_info_ticket: -<send_2>-
    Examples: forward
      | button_1                   | role     | send_1           | send_2            |
      | Передать в HR              |  hr_1    |1 LVL ➡ ️HR     |HR ➡ ️1 LVL      |
      | Передать в PR              |  pr_1    |1 LVL ➡ ️PR     |PR ➡ ️1 LVL      |
      | Передать в 5 отделение     |  project |1 LVL ➡ ️5 отд. |5 отд. ➡ ️1 LVL  |
      | Передать в Проектный отдел |  cyprus  |1 LVL ➡ ️PROJECT|PROJECT ➡ ️1 LVL |
    And lvl1_1 check data of tickets quantity 3
    And user click the button -Отменить тикет- quantity 3
