Feature: Initializing the database backend
  Scenario: Initialize a new database
    Given the following files should not exist:
      | test.db |
    When I run "melon -d test.db init"
    Then the following files should exist:
      | test.db |
    And the file "test.db" should be an sqlite database

  Scenario: Calling initialize on a database that already exists

  Scenario: Forcing a database to be re-initialized
