Feature: Get help on a command
  Scenario: Running help with no arguments
    When I run "melon help"
    Then the output should contain:
    """
    Usage: melon [options] COMMAND [command-options] [ARGS]
    """

  Scenario: Running help with help as an argument

  Scenario: Running help with a command as an argument

  Scenario: Running help with an invalid command as an argument
    When I run "melon help whizzle"
    Then the exit status should be 1
    And the output should contain:
    """
    melon: 'whizzle' is not a recognized command.
    """
    
