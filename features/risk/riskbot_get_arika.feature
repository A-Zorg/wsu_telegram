@sd_test8_bot
Feature: checking Arika, top-30, smartheat

   Scenario Outline: checking Arika, top-30, smartheat
     Given risk risk_1 - send message -/start-
      And risk risk_1 click the button -Админ- #message:3
      And risk risk_1 click the button -<button_1>- #message:3
      And risk risk_1 - send file
      And risk risk_1 - save the data of photo #message:2
#      And pause 2
      And risk user - send message -/start-
      And risk user click the button -Инфо-доска- #message:3
      And risk user click the button -<button_2>- #message:3
      And risk user - save the data of photo #message:1
     Then risk compared photos should be equal
      And risk user click the button -Назад- #message:3
      And risk risk_1 - send message -/start-
     Examples: forward
      | button_1                  | button_2               |
      | Загрузить Топ-30          |  Топ-30                |
      | Загрузить SmartHeat       |  SmartHeat             |


#
#   Scenario: subscribe/unsubscribe LA
#     Given risk user - send message -/start-
#      And risk user click the button -Инфо-доска- #message:2
#      And risk user click one of the button -Отказаться от подписки- or -Подписаться на лекцию Арика- #message:2
#     Then risk user click one of the button -Отказаться от подписки- or -Подписаться на лекцию Арика- #message:2
