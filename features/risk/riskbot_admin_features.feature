@sd_test8_bot
Feature: checking admin function buttons



   Scenario: offline days
     Given risk risk_1 - send message -/start-
      And risk risk_1 click the button -Админ- #message:2
      And risk risk_1 click the button -В offline на N дне- #message:2
      And risk risk_1 check message : -Напишите количество дней- #message:2
     When risk risk_1 - send message -5-
      And risk risk_1 check message : -Теперь вы offline- #message:2
     Then risk risk_1 click the button -Админ- #message:2
      And risk risk_1 click the button -Вернуться online- #message:2
      And risk risk_1 check message : -Теперь вы online- #message:2

  Scenario: offline immediately
     Given risk risk_1 - send message -/start-
      And risk risk_1 click the button -Админ- #message:2
     When risk risk_1 click the button -Уйти в offline- #message:2
      And risk risk_1 check message : -Теперь вы offline- #message:2
     Then risk risk_1 click the button -Админ- #message:2
      And risk risk_1 click the button -Вернуться online- #message:2
      And risk risk_1 check message : -Теперь вы online- #message:2

   Scenario: night watch
     Given risk risk_2 - send message -/start-
      And risk risk_2 click the button -Админ- #message:2
     When risk risk_2 click the button -Ночной дозор- #message:2
      And risk risk_2 check message : -в ночном дозоре- #message:2
      And pause 3
      And risk risk_1 check message : -в ночном дозоре- #message:2
     Then risk risk_2 click the button -Отменить ночной дозор- #message:2
      And risk risk_2 check message : -покинул ночной дозор- #message:2
      And pause 3
      And risk risk_1 check message : -покинул ночной дозор- #message:1