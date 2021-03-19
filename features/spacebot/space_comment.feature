@sd_test4_bot @sd_test1_bot @sd_test2_bot
Feature: space take ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


  Scenario: lvl1 comment
    Given lvl1_1 click the button -Добавить комментарий- quantity 2
     And lvl1_1 check message : -Добавьте комментарий- quantity 2
     And lvl1_1 - send message -comment-
     And lvl1_1 - add event to list_info_ticket: -Коммент от-
     And lvl1_1 click the button -Закрыть тикет- quantity 4
     And lvl1_1 click the button -Да- quantity 4
    When user click the button -Посмотреть тикет- quantity 2
    Then user check data of tickets quantity 1
     And lvl1_1 check data of tickets quantity 4

  Scenario Outline: hr, pr, project, cyprus comment first level
    Given lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> click the button -Добавить комментарий- quantity 2
     And <role> check message : -Добавьте комментарий- quantity 2
     And <role> - send message -comment-
     And <role> - add event to list_info_ticket: -Коммент от-
     And <role> click the button -Закрыть тикет- quantity 4
     And <role> click the button -Да- quantity 4
    When user click the button -Посмотреть тикет- quantity 2
    Then user check data of tickets quantity 1
    Examples:
      | button_1                   | role     |
      | Передать в HR              |  hr_1    |
      | Передать в PR              |  pr_1    |
      | Передать в Проектный отдел |  project |
      | Передать в 5 отделение     |  cyprus  |


  Scenario Outline: hr, pr, project, cyprus comment second level
    Given lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> click the button -Взять тикет- quantity 2
     And <role> click the button -Добавить комментарий- quantity 2
     And <role> check message : -Добавьте комментарий- quantity 2
     And <role> - send message -comment-
     And <role> - add event to list_info_ticket: -Коммент от-
     And <role> click the button -Закрыть тикет- quantity 5
     And <role> click the button -Да- quantity 5
    When user click the button -Посмотреть тикет- quantity 2
    Then user check data of tickets quantity 1
    Examples:
      | button_1                   | role     |
      | Передать в HR              |  hr_1    |
      | Передать в PR              |  pr_1    |
      | Передать в Проектный отдел |  project |
      | Передать в 5 отделение     |  cyprus  |