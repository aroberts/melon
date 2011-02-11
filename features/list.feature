Feature: List
  In order to see what's tracked by the database
  As a user
  I should be able to get a list of tracked files

  Background:
    Given a file named "test_file" with:
    """
    Test file 1
    """
    And a file named "file_test" with:
    """
    Test file 2
    """
    And I run "melon -d test.db add -q test_file file_test"


  Scenario: Listing files
    When I run "melon -d test.db list"
    Then the output should contain "test_file"
    And the output should contain "file_test"
    And the output should contain 2 hashes

  Scenario: Listing paths only
    When I run "melon -d test.db list -p"
    Then the output should contain "test_file"
    And the output should contain "file_test"
    And the output should not contain a hash

  Scenario: Listing hashes only
    When I run "melon -d test.db list -c"
    Then the output should not contain "test_file"
    And the output should not contain "file_test"
    And the output should contain 2 hashes
