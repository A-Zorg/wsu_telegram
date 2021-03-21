@sd_test8_bot @Risk_Group_for_missed_tickets
Feature: NBP


  Scenario Outline: check NBP(agent)
   Given change risk_google_table: clean fields:"Заказаное inv"
    And risk risk_2 - send message -/start-
    And risk risk_2 click the button -Админ- #message:2
    And risk risk_2 click the button -Разослать NBP- #message:2
    And risk risk_2 click the button -Назад- #message:2
    And risk risk_2 click the button -Разослать NBP- #message:2
    And risk risk_2 click the button -Разослать <NBP>- #message:2
   When change risk_google_table: add <persons_qty> amount of rows to the fields:"Заказаное inv"
    And risk risk_2 click the button -Да- #message:2
    And risk risk_2 check message : -Начата рассылка <NBP>- #message:2
    And risk risk_2 check message : -Рассылка <NBP> завершена- #message:2
   Then check report after distribution NBP: <persons_qty> and <NBP>

   Examples:
      |   NBP               | persons_qty   |
      |   NBP Takion        |   8           |
      |   NBP Sterling 5 N  |   5           |
#      |   NBP Sterling 4    |   7           |

  Scenario Outline: check NBP(user)
   Given change risk_google_table: clean fields:"Заказаное inv"
    And risk user - send message -/start-
    And risk user click the button -Заявка NBP- #message:2
    And risk user click the button -NBP <NBP>- #message:2
    And check work_datetime: 1-2-3-4-5 - 8-19 - принимаем с 03:00 до 15:00 EST в будние дни
    And risk user check message : -Введите заявку на <NBP> NBP- #message:2
    And risk user - send message -<incorrect_request>-
    And risk user check message : -Неправильный ввод\nВведите заявку на <NBP>- #message:2
    And risk user - send message -<correct_request_1>-
    And risk user check message : -Заявка на <NBP> NBP успешно сформирована- #message:2
   When risk user click the button -Заявка NBP- #message:2
    And risk user click the button -NBP <NBP>- #message:2
    And risk user check message : -Ваш текущая заявка на <tail> = <correct_request_1>\nВведите дробь или целое число если хотите изменить\n0, если хотите удалить:- #message:2
    And risk user - send message -<correct_request_2>-
    And risk user check message : -Заявка на <NBP> NBP успешно сформирована- #message:2
    And add <NBP> INV to the google_risk_table: <response>
    And risk risk_2 - send message -/start-
    And risk risk_2 click the button -Админ- #message:2
    And risk risk_2 click the button -Разослать NBP- #message:2
    And risk risk_2 click the button -Разослать NBP <NBP>- #message:2
    And risk risk_2 click the button -Да- #message:2
   Then risk user check message : -NBP <NBP>\nНа сегодня- #message:2
     And risk user check message : -<response>- #message:2

   Examples:
      |   NBP          | incorrect_request | correct_request_1 | correct_request_2  | response | tail           |
      |   Takion       |   8asd            |    12             |      6             | 125      | NBP            |
      |   Sterling 5 N |   fh12            |    -14,4          |      64            | qwe      | Nomura         |
      |   Sterling 4   |   hjh564          |    36,67          |      13            | asd      | Sterling 4 NBP |


Scenario Outline: cancel NBP
   Given change risk_google_table: clean fields:"Заказаное inv"
    And risk user - send message -/start-
    And risk user click the button -Заявка NBP- #message:2
    And risk user click the button -Назад- #message:2
    And risk user click the button -Заявка NBP- #message:2
    And risk user click the button -NBP <NBP>- #message:2
    And check work_datetime: 1-2-3-4-5 - 8-19 - принимаем с 03:00 до 15:00 EST в будние дни
    And risk user - send message -<correct_request>-
   When risk user click the button -Заявка NBP- #message:2
    And risk user click the button -NBP <NBP>- #message:2
    And risk user check message : -Ваш текущая заявка на <tail> = <correct_request>\nВведите дробь или целое число если хотите изменить\n0, если хотите удалить:- #message:2
    And risk user - send message -0-
   Then risk user check message : -Заявка на <NBP> NBP успешно удалена- #message:2
    And risk user click the button -Заявка NBP- #message:2
    And risk user click the button -NBP <NBP>- #message:2
    And risk user check message : -Введите заявку на <NBP> NBP- #message:2
    And risk user click the button -Назад- #message:2
    And risk user click the button -Назад- #message:2
 Examples:
      |   NBP          | correct_request   | tail           |
      |   Takion       |    12             | NBP            |
      |   Sterling 5 N |    -14,4          | Nomura         |
      |   Sterling 4   |    36,67          | Sterling 4 NBP |
