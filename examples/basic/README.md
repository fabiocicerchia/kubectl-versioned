# Basic Example

## As a Kubernetes Job

```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: kubectl-job
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: kubectl
          image: ghcr.io/fabiocicerchia/kubectl-versioned:1.34.10
          args: ["get", "pods", "-A"]
```

## Local usage

```sh
docker run --rm -v ~/.kube:/home/nonroot/.kube:ro \
  ghcr.io/fabiocicerchia/kubectl-versioned:1.34.10 version
```
