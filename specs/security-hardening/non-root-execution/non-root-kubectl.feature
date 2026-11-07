@domain:security-hardening @area:non-root-execution @from:kubectl-versioned/dockerfile
Feature: Running kubectl as an unprivileged user
  Protects hosts and clusters by ensuring kubectl in the image never runs as root.

  @id:security-hardening.non-root-execution.001 @rule:security.runtime.runs-as-uid-65532 @inferred @source:Dockerfile#USER
  Scenario: kubectl runs as the unprivileged user 65532, never as root
    Given the published image for kubectl version 1.34.10
    When an operator runs the image without overriding the user
    Then kubectl runs as user 65532 and group 65532
    And its home directory is /home/nonroot
