@domain:kubectl-image @area:image-metadata @from:kubectl-versioned/dockerfile
Feature: Image metadata and licensing
  Gives registries, scanners and compliance tooling the title, version, licence and source of each image, and ships the required attribution notice.

  Background:
    Given the published image for kubectl version 1.34.10

  @id:kubectl-image.image-metadata.001 @rule:kubectl-image.metadata.oci-labels @inferred @source:Dockerfile#LABEL
  Scenario Outline: Every image describes itself with standard OCI labels
    When a compliance tool inspects the image labels
    Then label "<label>" has value "<value>"

    Examples:
      | label                             | value                                               |
      | org.opencontainers.image.title    | kubectl-versioned                                   |
      | org.opencontainers.image.version  | 1.34.10                                             |
      | org.opencontainers.image.licenses | Apache-2.0                                          |
      | org.opencontainers.image.source   | https://github.com/fabiocicerchia/kubectl-versioned |

  @id:kubectl-image.image-metadata.002 @rule:kubectl-image.metadata.notice-bundled @inferred @source:Dockerfile#COPY
  Scenario: Every image ships the project's NOTICE file
    When a compliance reviewer extracts the image filesystem
    Then the file /NOTICE is present with the project's attribution notice
