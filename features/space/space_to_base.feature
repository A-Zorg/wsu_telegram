@sd_test4_bot
Feature: to base
   Background: base
    Given user - send message -/start-
     And user - send message -message-
     And pause 3

#    Scenario Outline: to base hr illness and vacation
#    Given lvl1_1 click the button -Передать в HR- quantity 2
#     And lvl1_1 click the button -Да- quantity 2
#     And pause 3
#    When hr_1 click the button -Взять тикет- quantity 2
#     And hr_1 click the button -Оформить тикет в базу- quantity 2
##     And hr_1 click the button -Отмена- quantity 2
##     And hr_1 click the button -Оформить тикет в базу- quantity 2
#     And hr_1 click the button -<button>- quantity 2
#     And hr_1 - choose incorrect time interval
#     And hr_1 click the button -❌ Введите даты заново- quantity 2
#     And hr_1 - choose correct time interval
#     And hr_1 click the button -Изменить даты- quantity 2
#     And hr_1 - choose correct time interval
#     And hr_1 click the button -Отменить добавление в базу- quantity 2
#    Then hr_1 click the button -Закрыть тикет- quantity 2
#     And hr_1 click the button -Да- quantity 2
#     Examples: forward
#      | button        |
#      | Отпуск        |
#      | Больничный    |


#  Scenario Outline: to base hr illness and vacation
#     And background create list_info_ticket: message is -message-
#    Given lvl1_1 click the button -Передать в HR- quantity 2
#     And lvl1_1 click the button -Да- quantity 2
#     And pause 3
#    When hr_1 click the button -Взять тикет- quantity 2
#     And hr_1 click the button -Оформить тикет в базу- quantity 2
#     And hr_1 click the button -Отмена- quantity 2
#     And hr_1 click the button -Оформить тикет в базу- quantity 2
#     And hr_1 click the button -<button>- quantity 2
#     And hr_1 - choose correct time interval
#     And hr_1 - add event to list_info_ticket: -Категория: <button>-
#    Then hr_1 click the button -Добавить в базу и закрыть- quantity 2
#     And hr_1 click the button -Да- quantity 2
#     And hr_1 check data of tickets quantity 2
#     But user click the button -Посмотреть тикет- quantity 2
#     And user check data of tickets quantity 1
#     And user check message : -Дата от: - quantity 1
#     And user check message : -Дата до: - quantity 1
#     Examples: forward
#      | button        |
#      | Отпуск        |
#      | Больничный    |
#
#
#    Scenario: to base hr lection
#    Given lvl1_1 click the button -Передать в HR- quantity 2
#     And lvl1_1 click the button -Да- quantity 2
#     And pause 3
#    When hr_1 click the button -Взять тикет- quantity 2
#     And hr_1 click the button -Оформить тикет в базу- quantity 2
#     And hr_1 click the button -Пропуск лекции- quantity 2
#     And hr_1 click the button -15- quantity 2
#     And hr_1 click the button -Изменить пропуск лекции- quantity 2
#     And hr_1 click the button -12- quantity 2
#     And hr_1 click the button -Отменить добавление в базу- quantity 2
#    Then hr_1 click the button -Закрыть тикет- quantity 2
#     And hr_1 click the button -Да- quantity 2

#  Scenario: to base hr lection
#     And background create list_info_ticket: message is -message-
#    Given lvl1_1 click the button -Передать в HR- quantity 2
#     And lvl1_1 click the button -Да- quantity 2
#     And pause 3
#    When hr_1 click the button -Взять тикет- quantity 2
#     And hr_1 click the button -Оформить тикет в базу- quantity 2
#     And hr_1 click the button -Пропуск лекции- quantity 2
#     And hr_1 click the button -11- quantity 2
#     And hr_1 - add event to list_info_ticket: -Категория: Пропуск лекции-
#    Then hr_1 click the button -Добавить в базу и закрыть- quantity 2
#     And hr_1 click the button -Да- quantity 2
#     And hr_1 check data of tickets quantity 2
#     But user click the button -Посмотреть тикет- quantity 2
#     And user check data of tickets quantity 1
#     And user check message : -Дата: - quantity 1

  Scenario Outline: to base hr workshop
     And background create list_info_ticket: message is -message-
    Given lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When hr_1 click the button -Взять тикет- quantity 2
     And hr_1 click the button -Оформить тикет в базу- quantity 2
     And hr_1 click the button -Обучение- quantity 2
     And hr_1 click the button -<button_1>- quantity 2
     And hr_1 click the button -Изменить событие- quantity 2
     And hr_1 click the button -<button_2>- quantity 2
     And hr_1 click the button -Отменить добавление в базу- quantity 2
     And hr_1 click the button -Оформить тикет в базу- quantity 2
     And hr_1 click the button -Обучение- quantity 2
     And hr_1 - add event to list_info_ticket: -Категория: <category>-
     And hr_1 click the button -<button_1>- quantity 2
     And hr_1 - add event to list_info_ticket: -Событие: <button_1>-
    Then hr_1 click the button -Добавить в базу и закрыть- quantity 2
     And hr_1 click the button -Да- quantity 2
     And hr_1 check data of tickets quantity 2
     But user click the button -Посмотреть тикет- quantity 2
     And user check data of tickets quantity 1
    Examples: forward
      | button_1                   | button_2     |category|
      | Первая школа рекрутинга    |  qweqwe      |Обучение|


    Scenario Outline: to base pr workshop
     And background create list_info_ticket: message is -message-
    Given lvl1_1 click the button -Передать в HR- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And pause 3
    When pr_1 click the button -Взять тикет- quantity 2
     And pr_1 click the button -Оформить тикет в базу- quantity 2
     And pr_1 click the button -Обучение- quantity 2
     And pr_1 click the button -<button_1>- quantity 2
     And pr_1 click the button -Изменить событие- quantity 2
     And pr_1 click the button -<button_2>- quantity 2
     And pr_1 click the button -Отменить добавление в базу- quantity 2
     And pr_1 click the button -Оформить тикет в базу- quantity 2
     And pr_1 click the button -Обучение- quantity 2
     And pr_1 - add event to list_info_ticket: -Категория: <category>-
     And pr_1 click the button -<button_1>- quantity 2
     And pr_1 - add event to list_info_ticket: -Событие: <button_1>-
    Then pr_1 click the button -Добавить в базу и закрыть- quantity 2
     And pr_1 click the button -Да- quantity 2
     And pr_1 check data of tickets quantity 2
     But user click the button -Посмотреть тикет- quantity 2
     And user check data of tickets quantity 1
    Examples: forward
      | button_1                    | button_2                       |category       |
      | New  yEar                   |  event                         |Спорт          |
      | Новый мастре класс!"№!"№    |  Новый мастре класс!"№!"№      |Мастер_класс   |









