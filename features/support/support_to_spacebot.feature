@sd_test3_bot @sd_test4_bot
Feature: to smart_space_bot

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

   Scenario: to smart_space_bot
     Given ops click the button -Передать в 👐 SmartSpace- 2
      And ops click the button -Да- 2
      And ops check message: -Тикет передан в 👐 SmartSpace-
      And pause 2
      And user check message: -Тикет закрыт-
      And user check message: -Ваш тикет передан в 👐 SmartSpace-
     Then user check message in bot

