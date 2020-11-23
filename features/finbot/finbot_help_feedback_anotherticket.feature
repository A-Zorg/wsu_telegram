@sd_test12_bot
Feature: finbot_help_feedback_anotherticket

  Scenario: another_ticket
    Given client send message -/start-
     And client click the button -Створити тікет на іншу тему-
     And client send message -запит-
     And client click the button -Відмінити тікет-
    When client click the button -Так-
    Then client check message -Тікет скасований-1138-

  Scenario: help
    Given client send message -/start-
     And client click the button -Help-
    Then client check message -Якщо у тебе...-1426-

  Scenario Outline: feedback
    Given client send message -/start-
     And client click the button -Фідбек-
     And client click the button -<button>-
     And client send message -помилка-
    Then client check message -Дякую...-2141-
    Examples: transfer types
        |  button                   |
        |  Повідомити про помилку   |
        |  Запропонувати поліпшення |
