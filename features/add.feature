Feature: Adding files to the database
  In order to have something to compare new files to
  As a user
  I should be able to add files to the database


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
    Then it should fail with:
    """
    melon: path already present in database
    """

  Scenario: Adding a directory itself
    Given a directory named "testo"
    When I run "melon -d test.db add testo"
    Then it should fail with:
    """
    directory
    """

  Scenario: Adding a file that doesn't exist
    When I run "melon -d test.db add nonexistant_file"
    Then it should fail with:
    """
    melon: no such file: nonexistant_file
    """

  Scenario: Adding a directory recursively

