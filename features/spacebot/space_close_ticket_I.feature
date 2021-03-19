@sd_test4_bot @sd_test1_bot
Feature: space close ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-
     And lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And hr_1 click the button -Взять тикет- quantity 2
     And hr_1 click the button -Закрыть тикет- quantity 2
     And hr_1 click the button -Да- quantity 2

  Scenario: hr close ticket
    Then user message of closed message
    And user check message : -Тикет закрыт- quantity 3

  Scenario: hr close ticket and pick star
    When user click the button -3x- quantity 2
    Then user check message : -Спасибо за отзыв- quantity 3
     And user - empty button -4x-
    
  Scenario: hr close ticket and user leave a comment
    When user click the button -Добавить комментарий- quantity 2
     And user check message : -Введите Ваш комментарий или нажмите /cancel для отмены- quantity 3
     And user - send message -COMMENT-
    Then user check message : -Ваш комментарий добавлен- quantity 3
     And user - empty button -Добавить комментарий-

   Scenario: hr close ticket and user watch ticket
    Given user click the button -Добавить комментарий- quantity 2
    When user click the button -Посмотреть тикет- quantity 2
    Then user check data of tickets quantity 2
     And user - empty button -Посмотреть тикет-
     But user click the button -5x- quantity 3

