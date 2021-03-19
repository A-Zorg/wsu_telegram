@sd_test4_bot
Feature: to base
   Background: base
    Given user - send message -/start-
     And user - send message -message-
     And pause 3


  Scenario Outline:  hr flags
     And background create list_info_ticket: message is -message-
    Given lvl1_1 click the button -<depart>- quantity 2
     And lvl1_1 click the button -Да- quantity 2
    When <role_1> click the button -Взять тикет- quantity 2
     And <role_1> click the button -Пометить- quantity 2
     And <role_1> click the button -💉- quantity 2
     And <role_1> click the button -💉- quantity 2
     And <role_1> click the button -📢- quantity 2
     And <role_1> click the button -📢- quantity 2
     And <role_1> click the button -🎓- quantity 2
     And <role_1> click the button -🎓- quantity 2
     And <role_1> click the button -🏁- quantity 2
     And <role_1> click the button -🏁- quantity 2
     And <role_1> click the button -🌅- quantity 2
     And <role_1> click the button -🌅- quantity 2
     And <role_1> click the button -💁- quantity 2
    Then <role_2> click the button -Перехватить тикет- quantity 2
     And <role_2> click the button -💁- quantity 2
     And <role_2> click the button -Очистить- quantity 2
     And <role_2> click the button -Пометить- quantity 2
     And <role_2> click the button -Очистить- quantity 2
     And <role_2> click the button -Закрыть тикет- quantity 2
     And <role_2> click the button -Да- quantity 2
    Examples: forward
      | role_1    | role_2  | depart        |
      | hr_1      |  hr_2   | Передать в HR |
      | pr_1      |  pr_2   | Передать в PR |