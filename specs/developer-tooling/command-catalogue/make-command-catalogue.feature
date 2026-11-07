@domain:developer-tooling @area:command-catalogue @from:kubectl-versioned/makefile
Feature: Discovering the available commands
  Contributors see every repository command with a one-line description just by running make, so nobody has to read the Makefile.

  @id:developer-tooling.command-catalogue.001 @rule:developer-tooling.catalogue.help-is-default @inferred @source:Makefile#help
  Scenario: Running make with no command lists every command and what it does
    Given the contributor is in the repository
    When the contributor runs make without naming a command
    Then a list of commands is printed, one per line with its description
    And the list includes help, setup, build, lint, test, install, run, format, analyze, push and release
    And no image is built
