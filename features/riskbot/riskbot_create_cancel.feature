@sd_test8_bot @Risk_Group_for_missed_tickets
Feature: space create cancel

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-
     And risk_1 on Отменить подстраховку
     And risk_2 on Отменить ночной дозор
     And risk_2 on Отменить подстраховку
     And The riskman maintains the user: false

  Scenario: cancel and create ticket
    Given risk risk_1 check data of ticket in group #message:2
     And risk user check message : -Тикет отправлен- #message:2
     And risk user click the button -Отменить тикет- #message:2
    Then risk user check message : -Тикет отменен- #message:2
     And risk risk_1 check message : -Тикет отменен пользователем- in group #message:2

  Scenario: create, take and cancel ticket
    Given risk risk_1 click the button -Взять тикет- in group #message:2
     And risk risk_1 check data of ticket #message:2
     And risk user click the button -Отменить тикет- #message:2
    Then risk risk_1 check message : -Тикет отменен пользователем- #message:2



































