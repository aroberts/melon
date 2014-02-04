Feature: Edge cases

  Scenario: Adding two files with the identical contents
    Given a file named "test_file" with:
    """
    This file is a test file
    """
    When I run `cp test_file test_file_2`
    And I run `melon -d test.db add test_file test_file_2`
    Then it should fail with:
    """
    melon: file exists elsewhere in the database
    """

  Scenario: Unrecognized command
    When I run `melon whizzle bang`
    Then it should fail with:
    """
    melon: unrecognized command: whizzle
    """
