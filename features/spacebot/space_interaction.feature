@sd_test4_bot
Feature: spacebot interaction

  Background: base
    Given user - send message -/start-
     And user - send message -message-
     And background create list_info_ticket: message is -message-

  Scenario Outline: part1
    When lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role_1> click the button -Взять тикет- quantity 2
    And <role_1> - add event to list_info_ticket: -Тикет принял: -
    And <role_2> click the button -Перехватить тикет- quantity 2
#    And <role_2> - add event to list_info_ticket: -Тикет принял: -
    And <role_1> click the button -Перехватить тикет- quantity 2
    And <role_1> - add event to list_info_ticket: -Тикет принял: -
    And <role_1> click the button -Закрыть тикет- quantity 2
    And <role_1> click the button -Да- quantity 2
    And <role_1> - add event to list_info_ticket: -Task closed: -
    And <role_1> check data of tickets quantity 3

    Examples: forward
      | button_1                   | role_1   | role_2    |
      | Передать в HR              |  hr_1    | hr_2      |
      | Передать в PR              |  pr_1    | pr_2      |


