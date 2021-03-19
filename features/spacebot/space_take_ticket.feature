@sd_test4_bot @sd_test1_bot @sd_test2_bot
Feature: space take ticket

  Background: base
    Given background send message -/start-
     And background send message -message-
     And background create list_info_ticket: message is -message-


  Scenario Outline: pr or hr close ticket
    Given lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> click the button -Взять тикет- quantity 2
     And <role> - add event to list_info_ticket: -Тикет принял: -
    When user after taking the ticket check the message
     And user check data of tickets in ticket_bot # 1
     And user check message : -Ваш тикет 👐- in bot # 1 quantity 2
     And user click the button -Отменить тикет 👐- in ticket_bot # 1 quantity 2
     And user click the button -Нет- in ticket_bot # 1 quantity 2
     And user click the button -✅ 👐 - in ticket_bot # 1 quantity 2

     But <role> check data of tickets in ticket_bot # 2
     And <role> check message : -Вы приняли тикет 👐- in bot # 2 quantity 2
     And <role> click the button -Закрыть тикет- quantity 2
     And <role> click the button -Да- quantity 2



   Examples: forward
        |  button_1                        |role    |
        |  Передать в HR                   |hr_1    |
        |  Передать в PR                   |pr_1    |
        |  Передать в Проектный отдел      |project |
        |  Передать в 5 отделение          |cyprus  |

