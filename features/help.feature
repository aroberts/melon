Feature: Getting help
  In order to use all of melon's features correctly
  As a user
  I should be able to get help using melon

  Scenario: General help
    When I run `melon help`
    Then the output should contain "Usage:"
    And the output should contain "Commands:"
    And the output should contain "Options:"

  Scenario: Help with a particular command
    When I run `melon help add`
    Then the output should contain "Usage: melon add"
    And the output should contain "Options:"
