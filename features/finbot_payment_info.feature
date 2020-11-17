@sd_test12_bot
Feature: payment_info

  Scenario Outline: payment_info_check_text
    Given client send message -/start-
     And client click the button -Інформація по виплатам-
     And client click the button -<button>-
    Then client check message -text-<code_1>-
     And client check message -text-<code_2>-
     And client click the button -<exit_button>-
    Examples: transfer types
        |  button                                             | code_1    | code_2    |exit_button    |
        |  В яких числах очікувати зарахування ЗП?            |   1144    |  1645     | Назад         |
        |  Чому сума виплати більша ніж вказана в БОТ?        |   1169    |  1274     | В головне меню|
        |  Де я можу побачити суми зарахувань на мій СПД?     |   1153    |  2274     | В головне меню|
        |  Коли мені відкриють СПД?                           |   1137    |  1642     | Назад         |

  Scenario: payment_info_check_text_rest_salary
    Given client send message -/start-
     And client click the button -Інформація по виплатам-
     And client click the button -Який у мене залишок ЗП на виплату? (тікет)-
     And client click the button -Відмінити тікет-
    When client click the button -Так-
    Then client check message -Тікет скасований-1138-

  Scenario: payment_info_category_ticket
    Given client send message -/start-
     And client click the button -Інформація по виплатам-
     And client click the button -Створити тікет на іншу тему в поточній категорії-
    When client send message -запит-
    Then agent get message -запит-
