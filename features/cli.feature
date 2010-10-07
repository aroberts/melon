Feature: Basic command line usage and program options

  Scenario Outline: Specify an unknown command
    When I run "melon <unknown-command>"
    Then the output should contain:
      """
      melon: '<unknown-command>' is not a recognized command.
      """
    Examples:
      | unknown-command |
      | split           |
      | roll            |

  Scenario Outline: Request the version
    When I run "melon <version-arg>"
    Then the output should contain:
      """
      melon version
      """
    Examples:
      | version-arg |
      | -v          |
      | --version   |

  Scenario Outline: Request help
    When I run "melon <help-arg>"
    Then the output should contain:
      """
      Usage:
      """
    Examples:
      | help-arg |
      | -h       |
      | --help   |

  Scenario: Passing an invalid option
    When I run "melon -z"
    Then the exit status should be 1
    And the output should contain:
    """
    melon: invalid option: -z
    """

  Scenario: Invoking an invalid command
    When I run "melon whizzle"
    Then the exit status should be 1
    Then the output should contain:
    """
    melon: 'whizzle' is not a recognized command.
    """
    
  # each command gets a "should contain"
  Scenario Outline: Features available
    When I run "melon --help"
    Then the output should contain "   <command>"
    Examples:
      | command |
      | help    |

