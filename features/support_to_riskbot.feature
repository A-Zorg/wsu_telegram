@sd_test3_bot @sd_test8_bot
Feature: to riskbot

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

   Scenario: to riskbot
     Given ops click the button -Передать в 🔔 SmartRisk- 2
      And ops click the button -Да- 2
      And ops check message: -Тикет передан в 🔔 SmartRisk-
      And user check message: -Тикет закрыт-
      And user check message: -Ваш тикет передан в 🔔 SmartRisk-
     Then user check message in bot
