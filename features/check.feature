Feature: Check
  In order to see if a given file is tracked by the database
  As a user
  I should be able to query the database with a file

  Background:
    Given a file named "test_file" with:
    """
    This file is a test file
    """

  Scenario: Checking a file that is not in the database
    When I run `melon -d test.db check test_file`
    Then the output should contain "test_file"
    And the output should start with "/"

  Scenario: Checking a file that is in the database:
    When I run `melon -d test.db add -q test_file`
    And I run `melon -d test.db check test_file`
    Then the output should be empty

  Scenario: Checking a file that doesn't exist
    When I run `melon -d test.db check nonexistant_file`
    Then it should fail with:
    """
    melon: no such file: nonexistant_file
    """

  Scenario: Checking recursively
    Given a file named "dir/test2" with:
    """
    Another test file
    """
    And a file named "dir/sub/test3" with:
    """
    Nothing to see here, folks
    """
    When I run `melon -d test.db check -r dir`
    Then the output should contain "dir/test2"
    And the output should contain "dir/sub/test3"
