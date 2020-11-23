@sd_test12_bot
Feature: finbot_spd_income

  Background: begin
    Given client clicks a set of buttons
      | button_name     |
      | Операції по СПД |
      | Доходи СПД за декларацією            |

  Scenario Outline: spd_income_I
    Given client click the button -<button>-
     And client click the button -Відмінити тікет-
    When client click the button -Так-
    Then client check message -Тікет скасований-1138-

    Examples: доходи СПД_I
        |  button                                              |
        |  Загальна сума доходу за весь період роботи компанії |
        |  Запит за декларацією на поточний рік                |


  Scenario Outline: spd_income_II
    Given client click the button -<button>-
     And client send message -запит-
     And client click the button -Відмінити тікет-
    When client click the button -Так-
    Then client check message -Тікет скасований-1138-

    Examples: доходи СПД_II
        |  button                                             |
        |  Створити тікет на іншу тему в поточній категорії   |
        |  Запит за декларацією за попередні роки             |
