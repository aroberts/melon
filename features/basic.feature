Feature: Basic usage

  Scenario: Adding files to a melon database
    Given a file named "test_file" with:
    """
    This file is a test file for md5 to hash
    """
    When I run "melon -d test.db add test_file"
    And I run "melon -d test.db check test_file"
    Then the output should contain a hash

