#!/usr/bin/env bash
set -euo pipefail
# One-line installer for kubectl-versioned
# Usage: curl -fsSL https://raw.githubusercontent.com/fabiocicerchia/kubectl-versioned/main/install.sh | bash

VERSION="${1:-latest}"
IMAGE="ghcr.io/fabiocicerchia/kubectl-versioned:${VERSION}"

echo "Pulling kubectl-versioned (${VERSION}) from GHCR..."
docker pull "$IMAGE"
echo ""
echo "kubectl-versioned ready. Example usage:"
echo "  docker run --rm -v ~/.kube:/home/nonroot/.kube:ro ${IMAGE} get pods -A"
