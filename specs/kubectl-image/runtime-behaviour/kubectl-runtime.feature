@domain:kubectl-image @area:runtime-behaviour @from:kubectl-versioned/dockerfile
Feature: Running kubectl from the image
  Lets operators use the image exactly like a local kubectl, with a harmless default when no command is given.

  @id:kubectl-image.runtime-behaviour.001 @rule:kubectl-image.runtime.default-prints-client-version @inferred @source:Dockerfile#CMD
  Scenario: Running the image with no command prints the kubectl client version
    Given the published image for kubectl version 1.34.10
    When an operator runs the image without any arguments
    Then kubectl prints its client version 1.34.10
    And it does not contact any cluster

  @id:kubectl-image.runtime-behaviour.002 @rule:kubectl-image.runtime.arguments-go-to-kubectl @inferred @source:Dockerfile#ENTRYPOINT
  Scenario: Arguments given to the image are passed straight to kubectl
    Given the published image for kubectl version 1.34.10
    When an operator runs the image with the arguments "get pods -n demo"
    Then kubectl runs "get pods -n demo"
