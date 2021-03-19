@sd_test3_bot
Feature: support feedback, opentasks
  Background: base
    Given background send message -/start-


  Scenario: feedback cancel
    Given user click the button -Фидбек-
     And user check message: -Выберите тип фидбека который вы хотите оставить-
    Then user click the button -Отмена-

  Scenario: feedback cancel
    Given user click the button -Фидбек-
     And user check message: -Выберите тип фидбека который вы хотите оставить-
     And user click the button -Сообщить об ошибке-
    Then user click the button -Отмена-

  Scenario Outline: feedback create
    Given user click the button -Фидбек-
     And user click the button -<button>-
     And user check message: -Добавьте текст/картинку-
     And user send message -BUG-
     And user check message: -Спасибо за фидбек-
     And background create list_info_ticket: message is -BUG-
    Then ops check data of ticket
     And user check message: -Ваш фидбек из ⚡️ Smart.Support:-
     But user click the button -Отменить тикет-
     But user click the button -Да-
        Examples: button
        |  button               |
        |  Сообщить об ошибке   |
        |  Предложить улучшение |

  Scenario: My open tasks
    Given ops send message -My open tasks-
    Then ops check message: -Task №-

  Scenario: Depart open tasks
    Given ops send message -Depart open tasks-
    Then ops check message: -Task №-
     And ops check message: -Admin: -
