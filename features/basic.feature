Feature: Basic usage

  Background:
    Given a file named "test_file" with:
    """
    This file is a test file
    """

  Scenario: Adding files to a melon database
    When I run "melon -d test.db add test_file"
    Then the output should contain a hash
    And the output should contain "test_file"

  Scenario: Adding a file that already exists
    When I run "melon -d test.db add test_file"
    And I run "melon -d test.db add test_file"
    Then the output should contain:
    """
    melon: path already present in database
    """

  Scenario: Checking a file that is not in the database
    When I run "melon -d test.db check test_file"
    Then the output should contain "test_file"
    And the output should start with "/"

