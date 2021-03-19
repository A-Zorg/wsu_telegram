@sd_test4_bot @sd_test1_bot
Feature: space close ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


  Scenario Outline: pr or hr close ticket
    Given lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> - add event to list_info_ticket: -<var>-
     And <role> click the button -Взять тикет- quantity 2
     And <role> - add event to list_info_ticket: -Тикет принял: -
     And <role> click the button -Закрыть тикет- quantity 2
     And <role> click the button -Да- quantity 2
    Then <role> check data of tickets quantity 2
     And user check message : -Тикет закрыт- quantity 3
        Examples: forward
        |  button_1               |role    |var             |
        |  Передать в HR          |hr_1    | 1 LVL ➡ ️HR  |
        |  Передать в PR          |pr_1    | 1 LVL ➡ ️PR  |

  Scenario: 1lvl close ticket
    Given lvl1_1 click the button -Добавить комментарий- quantity 2
     And lvl1_1 - send message -comment-
     And lvl1_1 click the button -Закрыть тикет- quantity 4
     And lvl1_1 click the button -Да- quantity 4
    Then user check message : -Тикет закрыт- quantity 3
     And user check message : -Пожалуйста, оцени насколько качественно- quantity 3

