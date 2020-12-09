@sd_test8_bot
Feature: to base
   Scenario:
     Given risk risk_1 check message : -Файл за [0-9\.]* успешно загружен.- #message:2
#   Scenario Outline: checking Arika, top-30, smartheat
#     Given risk risk_1 - send message -/start-
#      And risk risk_1 click the button -Админ- #message:3
#      And risk risk_1 click the button -<button_1>- #message:3
#      And risk risk_1 - send file
#      And risk risk_1 - save the data of photo #message:2
#      And pause 2
#      And risk user click the button -Инфо-доска- #message:3
#      And risk user click the button -<button_2>- #message:3
#      And risk user - save the data of photo #message:1
#     Then risk compared photos should be equal
#      And risk user click the button -Назад- #message:3
#      And risk risk_1 - send message -/start-
#     Examples: forward
#      | button_1                  | button_2     |category|
#      | Загрузить лекцию Арика    |  Получить Лекцию Арика     |Обучение|

#
#
#     Scenario: checking Arika, top-30, smartheat
#       Given risk user click the button -Инфо-доска- #message:3
#        And risk user click the button -Получить Лекцию Арика- #message:3
#        And risk user - save the data of photo #message:1
#        And risk user click the button -Назад- #message:3
#        And pause 2
#        And risk risk_1 - send message -/start-
#        And risk risk_1 click the button -Админ- #message:3
#        And risk risk_1 click the button -Загрузить лекцию Арика- #message:3
#        And risk risk_1 - send file
#        And risk risk_1 - save the data of photo #message:2
#      Then risk compared photos should be equal
#        And risk risk_1 - send message -/start-