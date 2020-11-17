@sd_test12_bot
Feature: finbot_spd_operation_MoneyTransferTicket

  Background: reaching button - "Банк"
    Given client clicks a set of buttons
      | button_name     | element_code|
      | Операції по СПД |             |
      | Банк            |             |


  Scenario Outline: Transfer money to bank card
    Given client click the button -<button>-
     And client click the button -Створити тікет на поточну тему-
    When client send message -123, 3456 4567 9467 1234-
    Then agent get message -123, 3456 4567 9467 1234-

    Examples: transfer types
        |  button                                              |
        |  Обмін валюти і перерахування на картку Приватбанк   |
        |  Обмін валюти і перерахування на картку інших банків |
        |  Перерахування грн на картку Приватбанк              |
        |  Перерахування грн на картку іншого банку            |

  Scenario Outline: transfer_money_check_text
    Given client click the button -<button>-
    Then client check message -text-<code_1>-
     And client check message -text-<code_2>-
     And client click the button -В головне меню-
  Examples: transfer types
        |  button                                              |code_1|code_2|
        |  Обмін валюти і перерахування на картку Приватбанк   |2185  |2012  |
        |  Обмін валюти і перерахування на картку інших банків |2179  |2283  |
        |  Перерахування грн на картку Приватбанк              |2175  |2331  |
        |  Перерахування грн на картку іншого банку            |2186  |2350  |
        |  Щомісячні платежі                                   |1311  |2192  |

  Scenario: payment_info_category_ticket
    Given client send message -/start-
     And client click the button -Операції по СПД-
     And client click the button -Банк-
     And client click the button -Створити тікет на іншу тему в поточній категорії-
    When client send message -запит-
    Then agent get message -запит-