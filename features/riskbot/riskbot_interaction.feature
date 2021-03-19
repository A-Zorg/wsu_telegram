@sd_test8_bot @Risk_Group_for_missed_tickets
Feature: Riskbot interaction

  Scenario Outline: check the ticket's way
     Given The riskman maintains the user: <riskman(r_3)>
      And risk_1 on <insurance(r_1)>
      And risk_2 on <nightwatch(r_2)>
      And background send message -/start-
      And background send message -message-
      And background create list_info_ticket: message is -message-
      And check riskman who could take the ticket: <before_1_min (r_1, r_2, r_3, group)>
      And pause 60
      And check riskman who could take the ticket: <after_1_min (r_1, r_2, r_3, group)>
      And risk user click the button -Отменить тикет- #message:2

     Examples:
      | riskman(r_3) | insurance(r_1)        | nightwatch(r_2)       | before_1_min (r_1, r_2, r_3, group) | after_1_min (r_1, r_2, r_3, group) |
      | false        | Отменить подстраховку | Отменить ночной дозор |   ["-", "-", "-", "+"]              |     ["-", "-", "-", "++"]          |
      | false        | Теперь я страхую      | Отменить ночной дозор |   ["+", "-", "-", "-"]              |     ["++", "-", "-", "+"]          |
      | false        | Отменить подстраховку | Ночной дозор          |   ["-", "+", "-", "-"]              |     ["-", "++", "-", "+"]          |
      | false        | Теперь я страхую      | Ночной дозор          |   ["-", "+", "-", "-"]              |     ["+", "++", "-", "-"]          |
      | true         | Отменить подстраховку | Отменить ночной дозор |   ["-", "-", "+", "-"]              |     ["-", "-", "++", "+"]          |
      | true         | Теперь я страхую      | Отменить ночной дозор |   ["-", "-", "+", "-"]              |     ["+", "-", "++", "-"]          |
      | true         | Отменить подстраховку | Ночной дозор          |   ["-", "+", "-", "-"]              |     ["-", "++", "-", "+"]          |
      | true         | Теперь я страхую      | Ночной дозор          |   ["-", "+", "-", "-"]              |     ["+", "++", "-", "-"]          |

  Scenario Outline: check the ticket's way
     Given The riskman maintains the user: <riskman(r_3)>
      And risk_1 on <insurance(r_1)>
      And risk_2 on <nightwatch(r_2)>
      And background send message -/start-
      And background send message -message-
      And background create list_info_ticket: message is -message-
      And pause <pause>
     When risk takes the ticket: <agent who takes the ticket>
     Then the ticket is intersepted by: <access to the ticket (r_1, r_2, r_3, group)>
      And risk user click the button -Отменить тикет- #message:2

    Examples:
      | riskman(r_3) | insurance(r_1)        | nightwatch(r_2)       | pause | agent who takes the ticket  | access to the ticket (r_1, r_2, r_3, group) |
      | false        | Отменить подстраховку | Отменить ночной дозор |  1    | User(context.risk_1, group) | ["-", "-", "-", "+"]                        |
      | false        | Теперь я страхую      | Отменить ночной дозор |  60   | User(context.risk_2, group) | ["+", "+", "-", "+"]                        |
      | false        | Теперь я страхую      | Ночной дозор          |  60   | User(context.risk_2, bot)   | ["+", "+", "-", "-"]                        |
      | true         | Отменить подстраховку | Отменить ночной дозор |  60   | User(context.risk_2, group) | ["-", "-", "+", "+"]                        |
      | true         | Теперь я страхую      | Отменить ночной дозор |  60   | User(context.risk_3, bot)   | ["+", "-", "+", "-"]                        |
      | true         | Теперь я страхую      | Ночной дозор          |  60   | User(context.risk_2, bot)   | ["+", "+", "-", "-"]                        |


