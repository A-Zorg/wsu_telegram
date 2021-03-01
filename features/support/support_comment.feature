@sd_test3_bot
Feature: support comment ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

 Scenario Outline: it or sd comment
     Given ops click the button -Взять тикет- 2
      And ops add event to list_info_ticket: -Тикет принял: -
      And ops click the button -<button_1>- 2
      And ops click the button -<button_2>- 2
#      And interuser pause
      And <role> add event to list_info_ticket: -<var>-
      And <role> click the button -Взять тикет- 2
      And <role> click the button -Добавить комментарий- 2
      And <role> check message: -Добавьте комментарий-
      And <role> send message -comment-
      And <role> check message: -Комментарий добавлен-
     When <role> add event to list_info_ticket: -Коммент от -
      And <role> click the button -Закрыть тикет- 4
      And <role> click the button -Да- 4
      And user click the button -Посмотреть тикет-
     Then user check data of ticket
     Examples: forward 5
        |  button_1               |role  |var           | button_2  |
        |  Передать в SD          |sd    | OPS ➡ ️SD  |  🐞 Bug    |
        |  Передать в IT          |it    | OPS ➡ ️IT  |  Да       |

 Scenario: ops comment
     Given ops click the button -Взять тикет- 2
      And ops add event to list_info_ticket: -Тикет принял: -
      And ops click the button -Добавить комментарий- 2
      And ops check message: -Добавьте комментарий-
      And ops send message -comment-
      And ops check message: -Комментарий добавлен-
     When ops add event to list_info_ticket: -Коммент от -
      And ops click the button -Закрыть тикет- 4
      And ops click the button -Да- 4
      And user click the button -Посмотреть тикет-
     Then user check data of ticket
