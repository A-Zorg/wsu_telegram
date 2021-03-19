@sd_test3_bot
Feature: support take ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-

  Scenario: ops take
    When ops click the button -Взять тикет- 3
     And ops add event to list_info_ticket: -Тикет принял: -
    Then user after taking the ticket check the message
     And user empty button -Отменить тикет-
     And  ops click the button -Закрыть тикет- 3
     And  ops click the button -Да- 3


  Scenario: sd take
    Given ops click the button -Передать в SD- 3
     And ops click the button -Bug- 3
     And sd add event to list_info_ticket: -OPS ➡ ️SD-
     And sd click the button -Взять тикет- 3
     And sd add event to list_info_ticket: -Тикет принял: -
    Then user after taking the ticket check the message
     And sd check data of ticket
     And sd click the button -Закрыть тикет- 3
     And sd click the button -Да- 3

  Scenario: sd->it take
    Given ops click the button -Передать в SD- 3
     And ops click the button -Feature request- 3
     And sd add event to list_info_ticket: -OPS ➡ ️SD-
     And sd click the button -Передать в IT- 3
     And sd click the button -Нет- 3
     And sd click the button -Передать в IT- 3
     And sd click the button -Да- 3
     And it add event to list_info_ticket: -SD ➡ ️IT-
    When it click the button -Взять тикет- 3
     And it add event to list_info_ticket: -Тикет принял: -
    Then user after taking the ticket check the message
     And it check data of ticket
     And it click the button -Закрыть тикет- 3
     And it click the button -Да- 3

  Scenario: ops take -> sd take
    When ops click the button -Взять тикет- 3
     And ops add event to list_info_ticket: -Тикет принял: -
     But user after taking the ticket check the message
     And ops click the button -Передать в SD- 3
     And ops click the button -Not classified- 3
     And sd add event to list_info_ticket: -OPS ➡ ️SD-
     And sd click the button -Взять тикет- 3
     And sd add event to list_info_ticket: -Тикет принял: -
    Then user after taking the ticket check the message
     And sd check data of ticket
     And sd click the button -Закрыть тикет- 3
     And sd click the button -Да- 3