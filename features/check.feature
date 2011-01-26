Feature: Basic usage

  Background:
    Given a file named "test_file" with:
    """
    This file is a test file
    """

  Scenario: Checking a file that is not in the database
    When I run "melon -d test.db check test_file"
    Then the output should contain "test_file"
    And the output should start with "/"

  Scenario: Checking a file that is in the database:
    When I run "melon -q -d test.db add test_file"
    And I run "melon -d test.db check test_file"
    Then the output should be empty

