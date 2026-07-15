# Getting Started

## Prerequisites

- Docker
- A Kubernetes cluster with `~/.kube/config` configured

## Quick Start

Pull the image for your kubectl version:

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-versioned:1.33.2
```

Run it against your cluster:

```sh
docker run --rm -v ~/.kube:/home/nonroot/.kube:ro \
  ghcr.io/fabiocicerchia/kubectl-versioned:1.33.2 get pods -A
```

## Available Tags

Tags mirror the supported Kubernetes versions. See `versions.txt` for the
current list, or browse [GHCR](https://ghcr.io/fabiocicerchia/kubectl-versioned).
