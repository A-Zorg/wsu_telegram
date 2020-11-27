@sd_test4_bot @sd_test1_bot
Feature: space create cancel

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

  Scenario: cancel and create ticket lvl1
    Given lvl1_1 check data of tickets quantity 2
     And user click the button -Отменить тикет- quantity 2
    Then user check message : -Тикет отменен- quantity 3
     And lvl1_1 check message : -Task canceled by user- quantity 3

  Scenario: cancel ticket hr
    Given lvl1_1 check data of tickets quantity 2
     And lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Нет- quantity 2
     And lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
     And user click the button -Отменить тикет- quantity 2
     And pause 2
    Then user check message : -Тикет отменен- quantity 3
     And hr_1 check message : -Task canceled by user- quantity 3

  Scenario: cancel ticket which was taken by hr
    Given lvl1_1 check data of tickets quantity 2
     And lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Взять тикет- quantity 2
     And user click the button -Отменить тикет- quantity 2
    Then user check message : -Тикет отменен- quantity 2
     And hr_1 check message : -Task canceled by user- quantity 2

  Scenario: cancel ticket which was taken by hr
    Given lvl1_1 check data of tickets quantity 2
     And lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Взять тикет- quantity 2
    Then user check data of tickets in ticket_bot # 1
     And user click the button -Отменить тикет- in ticket_bot # 1 quantity 2
     And user click the button -Нет- in ticket_bot # 1 quantity 2
     And user click the button -Отменить тикет- in ticket_bot # 1 quantity 2
     And user click the button -Да- in ticket_bot # 1 quantity 2
    Then hr_1 check message : -Task canceled by user- quantity 2