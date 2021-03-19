@sd_test3_bot
Feature: support create/cancel ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

  Scenario: cancel and create ticket ops
    Given ops check data of ticket
     And user click the button -Отменить тикет-
     And user click the button -Нет-
     And user click the button -Отменить тикет-
    When user click the button -Да-
    Then user check message: -Тикет отменен-
     And ops check message: -Task was canceled by user-
    
  Scenario: cancel ticket sd
    Given ops click the button -Передать в SD- 3
     And ops click the button -🐞 Bug- 3
     And user click the button -Отменить тикет-
     And user click the button -Нет-
     And user click the button -Отменить тикет-
    When user click the button -Да-
    Then user check message: -Тикет отменен-
     And sd check message: -Task was canceled by user-