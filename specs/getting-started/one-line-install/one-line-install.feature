@domain:getting-started @area:one-line-install @from:kubectl-versioned/install
Feature: Installing kubectl-versioned with one command
  Lets an operator fetch a kubectl-versioned image from GHCR with a single curl-pipe command and shows them how to run it against their cluster.

  Background:
    Given Docker is installed and can reach ghcr.io

  @id:getting-started.one-line-install.001 @rule:getting-started.install.pulls-requested-or-latest-version @inferred @source:install.sh#VERSION @questionable
  Scenario Outline: The installer pulls the requested version, or latest when none is given
    Given the version argument is <argument>
    When the operator runs the installer
    Then the installer announces "Pulling kubectl-versioned (<version>) from GHCR..."
    And the image ghcr.io/fabiocicerchia/kubectl-versioned:<version> is pulled onto the machine

    Examples:
      | argument  | version |
      | not given | latest  |
      | 1.34.10   | 1.34.10 |

  @id:getting-started.one-line-install.002 @rule:getting-started.install.prints-example-usage @inferred @source:install.sh#IMAGE
  Scenario: After a successful pull the installer shows how to run kubectl with the local kubeconfig mounted read-only
    Given the version argument is 1.34.10
    When the operator runs the installer
    Then the installer prints "kubectl-versioned ready. Example usage:"
    And the installer prints "docker run --rm -v ~/.kube:/home/nonroot/.kube:ro ghcr.io/fabiocicerchia/kubectl-versioned:1.34.10 get pods -A"

  @id:getting-started.one-line-install.003 @rule:getting-started.install.stops-when-pull-fails @inferred @source:install.sh#VERSION
  Scenario: The installer stops without claiming readiness when the image cannot be pulled
    Given the version argument is 0.0.0, which is not published
    When the operator runs the installer
    Then the pull error from Docker is shown
    And the installer exits with a non-zero status
    And no "kubectl-versioned ready" message or example usage is printed
