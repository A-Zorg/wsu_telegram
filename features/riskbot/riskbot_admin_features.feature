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
      And risk risk_1 check message : -в ночном дозоре- #message:2
     Then risk risk_2 click the button -Отменить ночной дозор- #message:2
      And risk risk_2 check message : -покинул ночной дозор- #message:2
      And risk risk_1 check message : -покинул ночной дозор- #message:1

   Scenario: the riskman in insurance
      Given risk_2 on Перехватить подстраховку
      And risk_2 on Отменить подстраховку
      And risk risk_2 click the button -Теперь я страхую- #message:2
      And risk risk_2 check message : -Вы на подстраховке!- #message:2
     When risk risk_1 check message : risk_2 plus на подстраховке
      And risk risk_1 click the button -Перехватить подстраховку- #message:2
      And risk risk_1 check message : -Вы на подстраховке!- #message:2
     Then risk risk_2 check message : risk_1 plus на подстраховке
      And risk risk_1 click the button -Отменить подстраховку- #message:2
      And risk risk_2 check message : risk_1 plus покинул подстраховку

   Scenario: check opened tickets
     Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-
     And risk risk_2 - send message -/start-
     And risk risk_2 click the button -Админ- #message:2
     And risk risk_2 click the button -Открытые тикеты отдела- #message:2
     And risk risk_1 - send message -/start-
     And risk risk_1 click the button -Админ- #message:2
     And risk risk_1 click the button -Мои открытые тикеты- #message:2
     And risk_1 on Теперь я страхую
    When risk risk_2 check presence new ticket in the opened tickets: False
     And risk risk_1 check presence new ticket in the opened tickets: False
     And pause 15
     And risk risk_1 click the button -Взять тикет- #message:2
    Then risk risk_1 click the button -Мои открытые тикеты- #message:2
     And risk risk_1 check presence new ticket in the opened tickets: True
    And risk risk_2 click the button -Открытые тикеты отдела- #message:2
     And risk risk_2 check presence new ticket in the opened tickets: True
     And risk user click the button -Отменить тикет- #message:2

   Scenario: Send notification
     Given risk risk_2 - send message -/start-
      And risk risk_2 click the button -Админ- #message:2
      And risk risk_2 click the button -Разослать уведомление- #message:2
      And risk risk_2 click the button -Отмена- #message:2
     When risk risk_2 click the button -Разослать уведомление- #message:2
      And risk risk_2 check message : -Введите текст уведомления:- #message:2
      And risk risk_2 - send message -notification-
      And risk risk_2 check message : -Ваше сообщение:\nnotification\n\nВыберите группу для отправки:- #message:2
      And risk risk_2 click the button -Group- #message:2
      And risk risk_2 check message : -(Да/Нет)- #message:2
      And risk risk_2 click the button -Да- #message:2
      And risk risk_2 check message : -Уведомление успешно отправлено- #message:2
     Then risk risk_1 check message : -notification- #message:2

