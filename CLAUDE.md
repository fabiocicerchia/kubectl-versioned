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
# build:  make build VERSION=1.34.10   # single-arch local image
# test:   make test  VERSION=1.34.10   # build + smoke test (./test.sh)
# lint:   make lint                    # hadolint + shellcheck
# run:    docker run --rm IMAGE:TAG version --client
make help    # Show this help
make setup   # Install the pre-commit hook
make build   # Build a single-arch image for VERSION
make lint    # hadolint the Dockerfile + shellcheck
make test    # Build + smoke test the image
make push    # Build + push a single-arch image
make release # Multi-arch buildx build & push (VERSION + latest)
```

## Tooling

Shared config — the GitHub workflows, `.pre-commit-config.yaml`,
`.editorconfig`, `.hadolint.yaml`, `SECURITY.md` — comes from
[repo-skeleton](https://github.com/fabiocicerchia/repo-skeleton). Edit it
there, not here; a local edit is drift and the next sync overwrites it.
`check-drift.sh` in that repo reports what has diverged.

- `make setup` installs the pre-commit hook, and that is the whole of it.
  Don't add a `.githooks/` directory: `core.hooksPath` replaces `.git/hooks/`
  wholesale, so setting it silently stops every pre-commit hook from running.
- Hooks are pinned by commit SHA with the tag in a trailing comment. A tag can
  be moved, a SHA cannot.
- CI runs this same `.pre-commit-config.yaml` through `pre-commit/action`, so
  what passes locally is what gates the pull request.

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
