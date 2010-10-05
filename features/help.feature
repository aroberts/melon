Feature: get help on using melon

  Scenario Outline: Specify an unknown command
    When I run "melon <unknown-command>"
    Then the output should contain:
      """
      Melon: I don't understand the command
      '<unknown-command>'.  See 'melon --help'.
      """
    Examples:
      | unknown-command |
      | split           |
      | roll            |

  Scenario Outline: Spec
