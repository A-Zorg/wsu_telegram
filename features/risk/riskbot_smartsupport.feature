@sd_test8_bot @Risk_Group_for_missed_tickets
Feature: space create cancel

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

  Scenario: take ticket
    Given risk risk_1 click the button -Передать в ⚡️ Smart.Support- in group #message:2
     And risk risk_1 check message : -Нет- in group #message:1
     And risk risk_1 - add to list_info_ticket some agent
     And risk user - check message by list_info_ticket[0,3] #message:1
    When risk risk_1 click the button -Закрыть тикет- #message:2
     And risk risk_1 check message : -Тикет закрыт: - #message:2
     And risk risk_1 - check message by list_info_ticket[0,1,2,3] #message:1
    Then risk user check message : -Тикет закрыт- #message:2
     And risk user click the button -Посмотреть тикет- #message:2
     And risk user - check message by list_info_ticket[0,1,2] #message:1
