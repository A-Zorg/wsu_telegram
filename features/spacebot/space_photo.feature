@sd_test4_bot
Feature: space photo

  Background: base
    Given background send message -/start-
     And background send message -message-

  Scenario Outline: hr, pr, project, cyprus watch photo
    Given lvl1_1 click the button -<button_1>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
     And <role> click the button -Взять тикет- quantity 2
     And <role> click the button -Фото и место- quantity 2
    Then <role> - check photo or another media
     And <role> click the button -Закрыть тикет- quantity 3
     And <role> click the button -Да- quantity 3
    Examples:
      | button_1                   | role     |
      | Передать в HR              |  hr_1    |
      | Передать в PR              |  pr_1    |

