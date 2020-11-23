@sd_test3_bot
Feature: support 30sec

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

   Scenario: ops waits 30 sec
     When user pause 31
      And ops check message after waiting
      And user pause 31
      And ops check message after waiting
     Then user click the button -Отменить тикет-
      And user click the button -Да-


  Scenario: ops waits 30 sec after sending a ticket from sd
    Given ops click the button -Передать в IT- 2
     And ops click the button -Да- 2
     And user pause 31
     And it check message after waiting
    When it click the button -Передать в Support- 2
     And it click the button -Да- 2
     And user pause 35
    Then ops check message after waiting
     And user click the button -Отменить тикет-
     And user click the button -Да-