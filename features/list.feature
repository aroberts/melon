Feature: List
  In order to see what's tracked by the database
  As a user
  I should be able to get a list of tracked files

  Scenario: Listing files
    Given a file named "test_file" with:
    """
    Test file 1
    """
    And a file named "file_test" with:
    """
    Test file 2
    """
    And I run "melon -d test.db add -q test_file file_test"
    When I run "melon -d test.db list"
    Then the output should contain "test_file"
    And the output should contain "file_test"
