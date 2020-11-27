@sd_test3_bot
Feature: support close ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


   Scenario: ops close ticket
     Given ops click the button -Взять тикет- 3
      And ops add event to list_info_ticket: -Тикет принял: -
      And ops click the button -Закрыть тикет- 3
      And ops click the button -Да- 2
      And ops add event to list_info_ticket: -Task closed: -
     Then ops check data of ticket
      But user pause 5


  Scenario: ops close ticket and choose a category of ticket
     Given ops click the button -Взять тикет- 3
      And ops click the button -Закрыть тикет- 3
      And ops click the button -Да- 3
      And ops check message: -Выберите категорию по тикету-
     Then ops choose a category of ticket
        |  button         |  answer  |
        |  Takion         |  Нет     |
        |  eSignal        |  Нет     |
        |  Sterling       |  Нет     |
        |  ECHO           |  Нет     |
        |  Services       |  Нет     |
        |  Subscriptions  |  Нет     |
        |  Other          |  Да      |
      And ops check message: -Успешно сохранено!-

  Scenario: sd close ticket
    Given ops click the button -Взять тикет- 3
     And ops add event to list_info_ticket: -Тикет принял: -
     And ops click the button -Передать в SD- 3
     And ops click the button -Bug- 3
     But interuser pause
     And sd add event to list_info_ticket: -OPS ➡ ️SD-
     And sd click the button -Взять тикет- 3
     And sd add event to list_info_ticket: -Тикет принял: -
     And sd click the button -Закрыть тикет- 3
     And sd click the button -Да- 3
    When sd add event to list_info_ticket: -Task closed: -
    Then sd check data of ticket


  Scenario: ops close ticket and choose a category of ticket
     Given ops click the button -Передать в IT- 3
      And ops click the button -Да- 3
      And user pause 2
      And it click the button -Взять тикет- 3
      And it click the button -Закрыть тикет- 3
      And it click the button -Да- 3
      And it check message: -Выберите категорию по тикету-
     Then it choose a category of ticket
        |  button             |  answer  |
        |  Сбой сеть/подрядчик|  Нет  |
        |  Сбой сервер        |  Нет  |
        |  Сбой ПК            |  Нет  |
        |  Личный вопрос      |  Нет  |
        |  Другое             |  Нет  |
        |  Доп. железо        |  Нет  |
        |  Доп. софт          |  Нет  |
        |  Доступ             |  Да   |
      And it check message: -Успешно сохранено!-



