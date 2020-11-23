@sd_test3_bot
Feature: support close ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-
     And ops click the button -Взять тикет- 2
     And ops click the button -Закрыть тикет- 2
     And ops click the button -Да- 2


  Scenario: ops close ticket
    Then user message of closed message
     And user check message: -Тикет закрыт-
     But user pause 15

  Scenario: ops close ticket and pick star
    When user click the button -3x-
    Then user check message: -Спасибо за отзыв-
     And user empty button -4x-
     But user pause 15

  Scenario: ops close ticket and leave a comment
    When user click the button -Добавить комментарий-
     And user check message: -Введите Ваш комментарий или нажмите /cancel для отмены-
     And user send message -COMMENT-
    Then user check message: -Ваш комментарий добавлен-
     And user empty button -Добавить комментарий-
     But user pause 15

  Scenario: ops close ticket and watch ticket
    When user click the button -Посмотреть тикет-
    Then user check data of ticket
     And user empty button -Посмотреть тикет-
     But user click the button -5x-
     But user click the button -Добавить комментарий-
     And user send message -/cancel-