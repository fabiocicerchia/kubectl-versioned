# Architecture

`kubectl-versioned` is a simple, deterministic build pipeline:

1. `versions.txt` lists the kubectl versions to publish.
2. `publish.yml` runs a matrix build — one job per version.
3. Each job downloads `kubectl` from `dl.k8s.io`, verifies the SHA-256
   checksum, and produces a `FROM gcr.io/distroless/static` image.
4. Multi-arch manifests (`linux/amd64`, `linux/arm64`) are pushed to GHCR.
