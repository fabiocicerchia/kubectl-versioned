# CLAUDE.md

Guidance for Claude Code (and other AI agents) working in this repo.

## Project

kubectl-versioned packages plain upstream `kubectl` as multi-arch, distroless
Docker images — one image tag per supported Kubernetes version. There is no
application code: the whole surface is the `Dockerfile` (fetches and checksum-
verifies the kubectl binary from `dl.k8s.io`), `versions.txt` (the list of
versions to publish), and `test.sh` (a smoke test). Images are built and pushed
by `.github/workflows/release.yml` whenever `versions.txt` or the `Dockerfile`
changes on `main`.

## Commands

```sh
# build:  make build VERSION=1.33.2   # single-arch local image
# test:   make test  VERSION=1.33.2   # build + smoke test (./test.sh)
# lint:   make lint                    # hadolint + shellcheck
# run:    docker run --rm IMAGE:TAG version --client
```

## Conventions

- Match existing style; don't reformat unrelated files.
- Conventional Commits for messages (see CONTRIBUTING.md).
- To publish a new kubectl version, add its patch tag to `versions.txt`.
- Pin GitHub Actions to a full commit SHA; pin apk packages in the Dockerfile.
- Never commit secrets; CI runs gitleaks. Keep `.env` out of git.

## Guardrails

- No new dependencies or base-image changes without a clear reason.
- Don't weaken the image hardening (distroless, non-root UID 65532, no shell).
- Ask before large refactors or destructive operations.
