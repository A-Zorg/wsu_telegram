@sd_test4_bot @sd_test3_bot
Feature: forward
   Background: base
    Given user - send message -/start-
     And user - send message -message_to_it-
     And pause 3

   Scenario: to support-IT 1
    Given lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Пересадка в IT- quantity 2
     And hr_1 click the button -Да- quantity 2
    Then hr_1 check message : -Тикет передан в ⚡️ Smart.Support- quantity 2
     And pause 2
     And user check message : -Ваш тикет передан в ⚡️ Smart.Support- quantity 2
     And user check message : -message_to_it- in bot # 1 quantity 2
     And hr_1 check message : -message_to_it- in bot # 1 quantity 2
     And hr_1 click the button -Взять тикет- in ticket_bot # 1 quantity 2
     And hr_1 click the button -Закрыть тикет- in ticket_bot # 1 quantity 2
     And hr_1 click the button -Да- in ticket_bot # 1 quantity 2

   Scenario: to support-IT 2
    Given lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Взять тикет- quantity 2
     And hr_1 click the button -Пересадка в IT- quantity 2
     And hr_1 click the button -Да- quantity 2
    Then hr_1 check message : -Тикет передан в ⚡️ Smart.Support- quantity 2
     And pause 2
     And user check message : -Ваш тикет передан в ⚡️ Smart.Support- quantity 2
     And user check message : -message_to_it- in bot # 1 quantity 2
     And hr_1 check message : -message_to_it- in bot # 1 quantity 2
     And hr_1 click the button -Взять тикет- in ticket_bot # 1 quantity 2
     And hr_1 click the button -Закрыть тикет- in ticket_bot # 1 quantity 2
     And hr_1 click the button -Да- in ticket_bot # 1 quantity 2

    Scenario: to support
    Given lvl1_1 click the button -Передать в ⚡️ Smart.Support- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When user check message : -Ваш тикет из 👐 SmartSpace- in bot # 1 quantity 2
     And user check message : -message_to_it- in bot # 1 quantity 2
     And lvl1_1 check message : -Ваш тикет из 👐 SmartSpace- in bot # 1 quantity 2
     And lvl1_1 check message : -message_to_it- in bot # 1 quantity 2
     And lvl1_1 click the button -Взять тикет- in ticket_bot # 1 quantity 2
     And lvl1_1 click the button -Закрыть тикет- in ticket_bot # 1 quantity 2
     And lvl1_1 click the button -Да- in ticket_bot # 1 quantity 2