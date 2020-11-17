@sd_test12_bot
Feature: finbot_spd_tax

 Scenario Outline: finbot_spd_tax
    Given client send message -/start-
     And client click the button -Операції по СПД-
     And client click the button -Консультації з оподаткування-
     And client click the button -<button>-
     And client send message -запит-
     And client click the button -Відмінити тікет-
    When client click the button -Так-
    Then client check message -Тікет скасований-1138-

    Examples: доходи СПД_II
        |  button                                          |
        |  Єдиний податок                                  |
        |  Єдиний соціальний внесок                        |
        |  Транспортний податок                            |
        |  Податок на землю                                |
        |  Штрафні санкції                                 |
        |  Створити тікет на іншу тему в поточній категорії|
