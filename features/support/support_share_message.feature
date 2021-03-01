@sd_test3_bot
Feature: support share message

  Background: base
    Given sd send message -/start-

  Scenario: share message cancel
    Given sd click the button -Разослать уведомление- 2
     And sd check message: -Введите текст уведомления:-
    Then sd click the button -Отмена- 2
    
  Scenario: share message cancel 2
    Given sd click the button -Разослать уведомление- 2
     And sd send message -message-
     And sd check message: -Выберите группу для отправки:-
    Then sd click the button -Отмена- 2

  Scenario: share message
    Given sd click the button -Разослать уведомление- 2
     And sd send message -message-
    When sd click the button -Test2- 2
     And sd check message: -пользователям?-
     And sd click the button -Да- 2
#     And pause 2
     And sd check message: -Уведомление успешно отправлено-
    Then ops check message: -message-