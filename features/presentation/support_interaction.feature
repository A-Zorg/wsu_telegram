@sd_test3_bot
Feature: support interaction

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


#  Scenario: 10 sec block
#    Given ops click the button -Взять тикет- 2
#     And user pause 2
#    When ops2 try to click: -Перехватить тикет-
#     And user pause 5
#     And ops2 try to click: -Перехватить тикет-
#     And user pause 4
#    Then ops2 click the button -Перехватить тикет- 2
#     And ops2 click the button -Да- 2
#     And ops2 click the button -Закрыть тикет- 2
#     And ops2 click the button -Да- 2
#
#  Scenario: members of the ops department see the same ticket
#    When ops check data of ticket
#     And ops2 check data of ticket
#    Then ops click the button -Передать в SD- 3
#     And ops2 click the button -Передать в SD- 3
#     And ops2 click the button -Нет- 3
#     And ops2 click the button -Взять тикет- 3
#     And ops2 click the button -Закрыть тикет- 2
#     And ops2 click the button -Да- 2

  Scenario Outline: members of the sd and it department see the same ticket
    Given ops click the button -<button_1>- 3
     And ops click the button -<button_2>- 3
    When <member_1> check data of ticket
     And <member_2> check data of ticket
    Then <member_1> click the button -Передать в Support- 3
     And <member_2> click the button -Передать в Support- 3
     And <member_2> click the button -Нет- 3
     And <member_2> click the button -Взять тикет- 3
     And <member_2> click the button -Закрыть тикет- 2
     And <member_2> click the button -Да- 2
     Examples: forward
        |  member_1   | member_2   | button_1       | button_2  |
#        |  sd         | sd2        | Передать в SD  |  🐞 Bug   |
        |  it         | it2        | Передать в IT  |  Да       |

#  Scenario: members of the ops department intercept tickets
#    Given ops click the button -Взять тикет- 3
#     And ops2 empty button -Закрыть тикет-
#     And user pause 12
#     And ops2 click the button -Перехватить тикет- 2
#     And ops2 click the button -Да- 2
#    Then ops empty button -Закрыть тикет-
#     And ops2 click the button -Закрыть тикет- 2
#     And ops2 click the button -Да- 2
#     And Compare last message in department in ops



  Scenario Outline: members of the sd and it department intercept tickets
    Given ops click the button -<button_1>- 3
     And ops click the button -<button_2>- 3
     And user pause 2
    When <member_1> click the button -Взять тикет- 3
     And <member_2> empty button -Закрыть тикет-
     And user pause 12
     And <member_2> click the button -Перехватить тикет- 2
     And <member_2> click the button -Да- 2
    Then <member_1> empty button -Закрыть тикет-
     And <member_2> click the button -Закрыть тикет- 2
     And <member_2> click the button -Да- 2
     And Compare last message in department in sd
     Examples: forward
        |  member_1   | member_2   | button_1       | button_2  |
        |  sd         | sd2        | Передать в SD  |  🐞 Bug   |
#        |  it         | it2        | Передать в IT  |  Да       |

    Scenario Outline: it and sd comment
     Given ops click the button -Взять тикет- 2
      And ops add event to list_info_ticket: -Тикет принял: -
      And ops click the button -<button_1>- 2
      And ops click the button -<button_2>- 2
      And interuser pause
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
#        |  Передать в IT          |it    | OPS ➡ ️IT  |  Да       |