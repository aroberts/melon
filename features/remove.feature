Feature: Remove file from the database
  In order to get rid of crappy media
  As a user
  I should be able to delete from the database

  Background:
    Given a file named "test_file" with:
    """
    I am an unassuming test file
    """
    And a file named "same_file" with:
    """
    I am an unassuming test file
    """
    And a file named "different_file" with:
    """
    I am a unique flower
    """
    And I run "melon -d test.db add -q test_file"

  Scenario: Removing a tracked file
    When I run "melon -d test.db remove test_file"
    Then the output should contain "test_file"
    # TODO: demand empty list

  Scenario: Removing a tracked file by hash
    When I run "melon -d test.db remove same_file"
    Then the output should contain "test_file"

  Scenario: Attempting to removean untracked file
    When I run "melon -d test.db remove different_file"
    Then the output should contain "untracked file"
    And the output should contain "different_file"


