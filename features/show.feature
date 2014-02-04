Feature: Show
  In order to see where a file is stored (according the database)
  As a user
  I should be able to query the database with a file

  Background:
    Given a file named "dir/test_file" with:
    """
    This file is a test file
    """
    And I run `cp dir/test_file .`

  Scenario: Showing a file that is not in the database
    When I run `melon -d test.db show test_file`
    Then the output should be empty

  Scenario: Showing a file that is in the database:
    When I run `melon -d test.db add -q dir/test_file`
    And I run `melon -d test.db show test_file`
    Then the output should contain "dir/test_file"
    And the output should start with "/"

  Scenario: Showing a file that doesn't exist
    When I run `melon -d test.db show nonexistant_file`
    Then it should fail with:
    """
    melon: no such file: nonexistant_file
    """
