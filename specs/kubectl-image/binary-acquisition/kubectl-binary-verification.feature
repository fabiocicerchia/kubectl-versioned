@domain:kubectl-image @area:binary-acquisition @from:kubectl-versioned/dockerfile
Feature: Downloading and verifying the kubectl binary
  Assures operators that the kubectl inside each image is the official upstream binary for their platform and has not been tampered with.

  @id:kubectl-image.binary-acquisition.001 @rule:kubectl-image.binary.checksum-must-match @inferred @source:Dockerfile#fetch
  Scenario: A kubectl binary that does not match its official checksum is never shipped
    Given the downloaded kubectl binary does not match the SHA-256 checksum published on dl.k8s.io
    When the release maintainer builds the image
    Then the build fails with a checksum failure
    And no image is produced

  @id:kubectl-image.binary-acquisition.002 @rule:kubectl-image.binary.matches-target-platform @inferred @source:Dockerfile#fetch
  Scenario Outline: Each image holds the kubectl built for its own platform
    Given the release maintainer builds the image for platform <platform>
    When an operator runs that image on a <platform> host
    Then the image runs the official upstream kubectl for <platform>

    Examples:
      | platform    |
      | linux/amd64 |
      | linux/arm64 |
