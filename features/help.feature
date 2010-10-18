Feature: Get help on a command
  Scenario: Running help with no arguments
    When I run "melon help"
    Then the output should contain:
    """
    Usage: melon [options] COMMAND [command-options] [ARGS]
    """
    
    # TODO model after trout#help
    # TODO write stories for add

  Scenario: Running help with arguments
    When I run "melon help help"
    Then the output should contain:
    """
    Something
    """

  Scenario: Running help with 'commands' as an argument

  Scenario: Running help with a command as an argument

  Scenario: Running help with an invalid command as an argument
    When I run "melon help whizzle"
    Then the exit status should be 1
    And the output should contain:
    """
    melon: 'whizzle' is not a recognized command.
    """
  Scenario: Running help with an invalid command options
    When I run "melon help --force"
    Then the exit status should be 1
    And the output should contain:
    """
    melon: invalid option: --force
    """
