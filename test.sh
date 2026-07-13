#!/usr/bin/env sh
# Smoke test: the image must report the exact kubectl version it was built for.
set -eu
IMAGE="${1:?usage: test.sh <image:tag>}"
TAG="${IMAGE##*:}"
OUT="$(docker run --rm "$IMAGE" version --client --output=yaml)"
echo "$OUT" | grep -q "gitVersion: v${TAG}" || {
  echo "FAIL: expected kubectl v${TAG}, got:" >&2
  echo "$OUT" >&2
  exit 1
}
echo "PASS: kubectl v${TAG}"
