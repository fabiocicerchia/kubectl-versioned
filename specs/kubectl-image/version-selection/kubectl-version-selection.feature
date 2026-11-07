@domain:kubectl-image @area:version-selection @from:kubectl-versioned/dockerfile
Feature: Choosing the kubectl version an image carries
  Lets operators get an image whose kubectl matches the exact Kubernetes patch version their cluster runs, with a sensible default when none is named.

  @id:kubectl-image.version-selection.001 @rule:kubectl-image.version.image-carries-requested-version @inferred @source:Dockerfile#fetch
  Scenario Outline: An image carries exactly the kubectl version it was built for
    Given the release maintainer builds the image <requested>
    When an operator runs the image asking for the client version
    Then kubectl reports gitVersion "v<reported>"

    Examples:
      | requested                        | reported |
      | for kubectl version 1.33.13      | 1.33.13  |
      | for kubectl version 1.32.13      | 1.32.13  |
      | without naming a kubectl version | 1.34.10  |

  @id:kubectl-image.version-selection.002 @rule:kubectl-image.version.unpublished-version-refused @inferred @source:Dockerfile#fetch
  Scenario: A kubectl version that upstream never published produces no image
    Given kubectl version 1.99.0 is not published on dl.k8s.io
    When the release maintainer builds the image for kubectl version 1.99.0
    Then the build fails
    And no image tagged 1.99.0 is produced
