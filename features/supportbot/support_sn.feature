@sd_test3_bot
Feature: support smart news

  Scenario: smart news
    Given ops send message -/start-
     And ops click the button -Керування аккаунтами SN- 2
     And ops click the button -Надати доступ по ID- 2
     And ops check message: -Введіть HR ID для надання доступу до SN-
     And ops send message -444-
     And ops click the button -Так- 2
     And ops check message: -Доступ надано!-
    When ops click the button -Назад- 2
     And ops click the button -Отримати список користувачів SN- 2
     And ops check message: -Користувачі SN-
     And ops check message: -444 Джеки Чан-
    Then ops click the button -Назад- 2
     And ops click the button -Видалити доступ по ID- 2
     And ops check message: -Введіть HR ID для видалення доступу до SN-
     And ops send message -444-
     And ops click the button -Так- 2
     And ops check message: -Доступ видалено!-
     But ops click the button -Назад- 2
     And ops click the button -Отримати список користувачів SN- 2
     And ops check empty message : -444 Джеки Чан-
     And ops send message -Відміна-

  Scenario: smart news
    Given ops send message -/start-
     And ops click the button -Add admin- 2
     And ops check message: -Send user id (use @ShowJsonBot to find out the id)-
     And ops send message -1064635410-
    Then ops check message: -This person has already been added as admin-
