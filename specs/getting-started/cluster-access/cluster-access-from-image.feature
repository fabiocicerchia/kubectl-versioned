@domain:getting-started @area:cluster-access @from:kubectl-versioned/makefile
Feature: Using kubectl from the image against your cluster
  Operators run kubectl from the image with their own kubeconfig without the container being able to change it.

  @id:getting-started.cluster-access.001 @rule:getting-started.cluster-access.kubeconfig-mounted-read-only @inferred @source:Makefile#run
  Scenario: kubectl in the image reads the operator's kubeconfig but cannot modify it
    Given the operator has a kubeconfig in ~/.kube
    When the operator runs kubectl from the image with arguments "get pods"
    Then kubectl in the container sees the operator's ~/.kube as /home/nonroot/.kube
    And the mounted kubeconfig is read-only inside the container
    And the container is removed when kubectl exits
