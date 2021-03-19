@sd_test8_bot @Risk_Group_for_missed_tickets @sd_test3_bot
Feature: to SupportBot

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-
     And risk_1 on Отменить подстраховку
     And risk_2 on Отменить ночной дозор
     And risk_2 on Отменить подстраховку
     And The riskman maintains the user: false


  Scenario: to SupportBot
    Given risk risk_1 click the button -Передать в ⚡️ Smart.Support- in group #message:2
     And risk risk_1 click the button -Нет- in group #message:2
     And risk risk_1 click the button -Передать в ⚡️ Smart.Support- in group #message:2
     And risk risk_1 click the button -Да- in group #message:2
     And risk risk_1 - add to list_info_ticket some agent
    When risk user check message : -Ваш тикет передан в ⚡️ Smart.Support- #message:1
     And risk user check message : -Тикет закрыт- #message:2
     And risk user - check message by list_info_ticket[0] #message:2
    Then risk user check message : -Ваш тикет из- in SupportBot #message:2
     And risk user check message : -Risk.Ticket:- in SupportBot #message:2
     And risk user click the button -Отменить тикет- in SupportBot #message:2
     And risk user click the button -Да- in SupportBot #message:2

