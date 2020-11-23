@sd_test12_bot
Feature: finbot_spd_operations_moneytransfer_user_agent


   Background: begin
    Given client clicks a set of buttons
      | button_name     |
      | Операції по СПД |
      | Банк            |


   Scenario Outline: check agent ticket
     Given client click the button -<button>-
     And client click the button -Створити тікет на поточну тему-
     And client send message -1233,1234 5678 7890 3456-
     Then client get a ticket number
     When agent check a ticket number
      And agent check a ticket message -1233,1234 5678 7890 3456-
      And agent check a ticket message -Тема: <button>-
      And agent check a ticket -From: - and client


      Examples: check agent ticket
          |  button                                               |
          |  Обмін валюти і перерахування на картку Приватбанк    |
          |  Обмін валюти і перерахування на картку інших банків  |
          |  Перерахування грн на картку Приватбанк               |
          |  Перерахування грн на картку іншого банку             |

   Scenario Outline: cancel ticket
     Given client click the button -<button>-
     And client click the button -Створити тікет на поточну тему-
     And client send message -1233,1234 5678 7890 3456-
     Then client get a ticket number
      And client click the button -Відмінити тікет-
      And client click the button -Ні-
      And client click the button -Відмінити тікет-
      And client click the button -Так-
     When agent check a ticket number
      And agent check a ticket message -1233,1234 5678 7890 3456-
      And agent check a ticket message -Тема: <button>-
      And agent check a ticket -From: - and client
      And agent check a ticket message -Task was canceled by user-
      But client check message -тікет скасований-1138-
      But client empty button -Відмінити тікет-
      But client click the button -Головне меню-


      Examples: cancel ticket
          |  button                                               |
          |  Обмін валюти і перерахування на картку Приватбанк    |
          |  Обмін валюти і перерахування на картку інших банків  |
          |  Перерахування грн на картку Приватбанк               |
          |  Перерахування грн на картку іншого банку             |

  Scenario Outline: take ticket
     Given client click the button -<button>-
      And client click the button -Створити тікет на поточну тему-
      And client send message -1233,1234 5678 7890 3456-
     Then client get a ticket number
      And agent click the button -Взяти тікет-
     When agent check a ticket number
      And agent check a ticket message -1233,1234 5678 7890 3456-
      And agent check a ticket message -Тема: <button>-
      And agent check a ticket -From: - and client
      And agent check a ticket -Тікет прийняв: - and agent
      And client check a message: Ваш запит -ticket number- прийняв -agent-
      And client empty button -Відмінити тікет-
      But client click the button -Головне меню-

      Examples: take ticket
          |  button                                               |
          |  Обмін валюти і перерахування на картку Приватбанк    |
          |  Обмін валюти і перерахування на картку інших банків  |
          |  Перерахування грн на картку Приватбанк               |
          |  Перерахування грн на картку іншого банку             |

  Scenario Outline: take and close ticket
     Given client click the button -<button>-
      And client click the button -Створити тікет на поточну тему-
      And client send message -1233,1234 5678 7890 3456-
     When client get a ticket number
      And agent click the button -Взяти тікет-
      And agent click the button -Закрити тікет-
      And agent click the button -Ні-
      And agent click the button -Закрити тікет-
      And agent click the button -Так-
     Then agent check a ticket number
      And agent check a ticket message -1233,1234 5678 7890 3456-
      And agent check a ticket message -Тема: <button>-
      And agent check a ticket -From: - and client
      And agent check a ticket -Тікет прийняв: - and agent
      And agent check a ticket -Task closed: - and agent
      And client check a message: Ваш запит -ticket number- прийняв -agent-
      And client empty button -Відмінити тікет-
      And client check message -Тікет закритий ....-173-
      But client click the button -Головне меню-


      Examples: take and close ticket
          |  button                                               |
          |  Обмін валюти і перерахування на картку Приватбанк    |
          |  Обмін валюти і перерахування на картку інших банків  |
          |  Перерахування грн на картку Приватбанк               |
          |  Перерахування грн на картку іншого банку             |
