@sd_test8_bot @SD.Feedback.Test
Feature: space create cancel


  Scenario Outline: cancel and create ticket
    Given risk user - send message -/start-
     And risk user click the button -Фидбек- #message:2
     And risk user check message : -Выберите тип фидбека который вы хотите оставить- #message:2
     And risk user click the button -Отмена- #message:2
     And risk user click the button -Фидбек- #message:2
     And risk user click the button -<button>- #message:2
     And risk user check message : -Добавьте текст/картинку- #message:2
     And risk user - send message -feedback-
    Then risk risk_2 check message : -feedback- in group #message:2

     Examples:
      | button                |
      | Сообщить об ошибке    |
      | Предложить улучшение  |
