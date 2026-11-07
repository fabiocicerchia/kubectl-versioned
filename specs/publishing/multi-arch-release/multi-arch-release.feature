@domain:publishing @area:multi-arch-release @from:kubectl-versioned/makefile
Feature: Releasing multi-architecture kubectl images
  Maintainers publish one image per kubectl version for both Intel and ARM hosts, so users can pull an exact version or simply the newest one.

  Background:
    Given the maintainer is signed in to the container registry ghcr.io/fabiocicerchia/kubectl-versioned

  @id:publishing.multi-arch-release.001 @rule:publishing.release.version-and-latest-tags-for-amd64-and-arm64 @inferred @source:Makefile#release @questionable
  Scenario Outline: A release publishes the version tag and latest for amd64 and arm64
    Given kubectl version <version> is chosen for the release
    When the maintainer releases the image
    Then the registry holds ghcr.io/fabiocicerchia/kubectl-versioned:<version> for linux/amd64 and linux/arm64
    And the latest tag points to that same <version> image
    And the image carries kubectl <version>

    Examples:
      | version |
      | 1.34.10 |
      | 1.33.13 |

  @id:publishing.multi-arch-release.002 @rule:kubectl-image.version.default-version-when-unspecified @inferred @source:Makefile#VERSION
  Scenario: Without a chosen version a release publishes kubectl 1.34.10
    Given no kubectl version is chosen
    When the maintainer releases the image
    Then the published tags are 1.34.10 and latest
    And the image carries kubectl 1.34.10
