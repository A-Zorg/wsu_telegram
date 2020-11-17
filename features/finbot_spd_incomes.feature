@sd_test12_bot
Feature: finbot_spd_incomes


   Background: begin
    Given client clicks a set of buttons
      | button_name                     |
      | Операції по СПД                 |
      | Доходи СПД за декларацією       |


   Scenario Outline: check agent ticket
     Given client click the button -<button>-
     Then client get a ticket number
     When agent check a ticket number
      And agent check a ticket message -<ticket_message>-
      And agent check a ticket message -Тема: Доходи СПД за декларацією-
      And agent check a ticket -From: - and client


      Examples: check agent ticket
          |  button                                             |  ticket_message                                               |
          |  Загальна сума доходу за весь період роботи компанії|Заявка на загальну суму доходу за весь період роботи в компанії|
          |  Запит за декларацією на поточний рік               |Заявка на декларацію на поточний рік                           |



   Scenario Outline: cancel ticket
     Given client click the button -<button>-
     Then client get a ticket number
      And client click the button -Відмінити тікет-
      And client click the button -Ні-
      And client click the button -Відмінити тікет-
      And client click the button -Так-
     When agent check a ticket number
      And agent check a ticket message -<ticket_message>-
      And agent check a ticket message -Тема: Доходи СПД за декларацією-
      And agent check a ticket -From: - and client
      And agent check a ticket message -Task was canceled by user-
      But client check message -тікет скасований-1138-
      But client empty button -Відмінити тікет-
      But client click the button -Головне меню-


      Examples: take ticket
          |  button                                             |  ticket_message                                               |
          |  Загальна сума доходу за весь період роботи компанії|Заявка на загальну суму доходу за весь період роботи в компанії|
          |  Запит за декларацією на поточний рік               |Заявка на декларацію на поточний рік                           |

  Scenario Outline: finbot_withdraw
     Given client click the button -<button>-
     Then client get a ticket number
      And agent click the button -Взяти тікет-
     When agent check a ticket number
      And agent check a ticket message -<ticket_message>-
      And agent check a ticket message -Тема: Доходи СПД за декларацією-
      And agent check a ticket -From: - and client
      And agent check a ticket -Тікет прийняв: - and agent
      And client check a message: Ваш запит -ticket number- прийняв -agent-
      And client empty button -Відмінити тікет-
      But client click the button -Головне меню-

      Examples: take ticket
          |  button                                             |  ticket_message                                               |
          |  Загальна сума доходу за весь період роботи компанії|Заявка на загальну суму доходу за весь період роботи в компанії|
          |  Запит за декларацією на поточний рік               |Заявка на декларацію на поточний рік                           |

  Scenario Outline: take and close ticket
     Given client click the button -<button>-
     When client get a ticket number
      And agent click the button -Взяти тікет-
      And agent click the button -Закрити тікет-
      And agent click the button -Ні-
      And agent click the button -Закрити тікет-
      And agent click the button -Так-
     Then agent check a ticket number
      And agent check a ticket message -<ticket_message>-
      And agent check a ticket message -Тема: Доходи СПД за декларацією-
      And agent check a ticket -From: - and client
      And agent check a ticket -Тікет прийняв: - and agent
      And agent check a ticket -Task closed: - and agent
      And client check a message: Ваш запит -ticket number- прийняв -agent-
      And client empty button -Відмінити тікет-
      And client check message -Тікет закритий ....-174-
      But client click the button -Головне меню-


      Examples: take and close ticket
          |  button                                             |  ticket_message                                               |
          |  Загальна сума доходу за весь період роботи компанії|Заявка на загальну суму доходу за весь період роботи в компанії|
          |  Запит за декларацією на поточний рік               |Заявка на декларацію на поточний рік                           |
