@sd_test3_bot
Feature: support forward

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


   Scenario Outline: forward 1
     Given ops click the button -Передать в SD- 3
      And ops click the button -🐞 Bug- 3
      And interuser pause
      And sd add event to list_info_ticket: -OPS ➡ ️SD-
      And sd click the button -<button>- 3
      And sd click the button -Да- 3
      And sd add event to list_info_ticket: -<var>-
      And interuser pause
     When <role> click the button -Взять тикет- 3
     Then <role> check data of ticket
      And <role> click the button -Закрыть тикет- 3
      And <role> click the button -Да- 3
     Examples: forward 1
        |  button               |role  |var           |
        |  Передать в Support   |ops   | SD ➡ ️OPS  |
        |  Передать в IT        |it    | SD ➡ ️IT   |

  Scenario Outline: forward 2
     Given ops click the button -Передать в IT- 3
      And ops click the button -Да- 3
      And it add event to list_info_ticket: -OPS ➡ ️IT-
      And it click the button -<button_1>- 3
      And it click the button -<button_2>- 3
      And it add event to list_info_ticket: -<var>-
     When <role> click the button -Взять тикет- 3
     Then <role> check data of ticket
      And <role> click the button -Закрыть тикет- 3
      And <role> click the button -Да- 3
     Examples: forward 2
        |  button_1             |role  |var           |button_2|
        |  Передать в Support   |ops   | IT ➡ ️OPS  |  Да     |
        |  Передать в SD        |sd    | IT ➡ ️SD   |  🐞 Bug |



  Scenario Outline: forward 3
     Given ops click the button -Передать в IT- 3
      And ops click the button -Да- 3
      And it add event to list_info_ticket: -OPS ➡ ️IT-
      And it click the button -Взять тикет- 3
      And it add event to list_info_ticket: -Тикет принял: -
      And it click the button -<button_1>- 3
      And it click the button -<button_2>- 3
      And it add event to list_info_ticket: -<var>-
     When <role> click the button -Взять тикет- 3
     Then <role> check data of ticket
      And <role> click the button -Закрыть тикет- 3
      And <role> click the button -Да- 3
     Examples: forward 3
        |  button_1             |role  |var           |button_2|
        |  Передать в Support   |ops   | IT ➡ ️OPS  |  Да     |
        |  Передать в SD        |sd    | IT ➡ ️SD   |  🐞 Bug |

   Scenario Outline: forward 4
     Given ops click the button -Передать в SD- 3
      And ops click the button -🐞 Bug- 3
      And sd add event to list_info_ticket: -OPS ➡ ️SD-
      And sd click the button -Взять тикет- 3
      And sd add event to list_info_ticket: -Тикет принял: -
      And sd click the button -<button>- 3
      And sd click the button -Да- 3
      And sd add event to list_info_ticket: -<var>-
     When <role> click the button -Взять тикет- 3
     Then <role> check data of ticket
      And <role> click the button -Закрыть тикет- 3
      And <role> click the button -Да- 3
     Examples: forward 4
        |  button               |role  |var           |
        |  Передать в Support   |ops   | SD ➡ ️OPS  |
        |  Передать в IT        |it    | SD ➡ ️IT   |


   Scenario Outline: forward 5
     Given ops click the button -Взять тикет- 3
      And ops add event to list_info_ticket: -Тикет принял: -
      And ops click the button -<button_1>- 3
      And ops click the button -<button_2>- 3
      And <role> add event to list_info_ticket: -<var>-
      And <role> click the button -Взять тикет- 3
      And <role> add event to list_info_ticket: -Тикет принял: -
      And <role> check data of ticket
     When <role> click the button -Фото и место- 3
      And <role> check photo or another media
      And <role> click the button -Закрыть тикет- 3
      And <role> click the button -Да- 3


     Examples: forward 5
        |  button_1               |role  |var           | button_2  |
        |  Передать в SD          |sd    | OPS ➡ ️SD  |  🐞 Bug    |
        |  Передать в IT          |it    | OPS ➡ ️IT  |  Да       |

