@domain:security-hardening @area:security-scanning @from:kubectl-versioned/makefile
Feature: Scanning the source tree for security problems
  Maintainers check the repository locally for vulnerabilities, misconfigurations and leaked secrets the same way CI does, before pushing.

  @id:security-hardening.security-scanning.001 @rule:security.scanning.critical-and-high-vuln-misconfig-secret @inferred @source:Makefile#analyze
  Scenario: The scan reports critical and high vulnerabilities, misconfigurations and secrets
    Given the scanner trivy is installed
    When the maintainer scans the repository
    Then findings of severity CRITICAL and HIGH are reported for vulnerabilities, misconfigurations and secrets
    And findings of lower severity are not reported

  @id:security-hardening.security-scanning.002 @rule:security.scanning.refused-without-scanner @inferred @source:Makefile#analyze
  Scenario: The scan is refused with install guidance when the scanner is missing
    Given the scanner trivy is not installed
    When the maintainer scans the repository
    Then the message "analyze needs trivy: https://trivy.dev/latest/getting-started/installation/" is shown on standard error
    And the command exits with status 69
    And no scan is performed
