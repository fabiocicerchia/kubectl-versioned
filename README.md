# kubectl-versioned

[![CI](https://github.com/fabiocicerchia/kubectl-versioned/actions/workflows/ci.yml/badge.svg)](https://github.com/fabiocicerchia/kubectl-versioned/actions/workflows/ci.yml)
[![Security](https://github.com/fabiocicerchia/kubectl-versioned/actions/workflows/security.yml/badge.svg)](https://github.com/fabiocicerchia/kubectl-versioned/actions/workflows/security.yml)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](LICENSE)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/fabiocicerchia/kubectl-versioned/badge)](https://securityscorecards.dev/viewer/?uri=github.com/fabiocicerchia/kubectl-versioned)
[![Release](https://img.shields.io/github/v/release/fabiocicerchia/kubectl-versioned)](https://github.com/fabiocicerchia/kubectl-versioned/releases)

Plain `kubectl`, in **every supported Kubernetes version**, as multi-arch,
distroless, tiny Docker images. One version = one tag. Nothing else inside.

The Bitnami catalogue paywall (2024–2025) left a vacuum for a boring,
trustworthy, versioned kubectl image. This is that image.

## Why

- **Version-pinned**: tag `1.34.10` contains kubectl `v1.34.10`, verified against
  the official `dl.k8s.io` SHA-256 checksum at build time.
- **Tiny & safe**: built `FROM gcr.io/distroless/static`, runs as non-root
  (UID 65532), no shell, no package manager, nothing to CVE-scan except kubectl.
- **Multi-arch**: `linux/amd64` and `linux/arm64` manifests.

## Install

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-versioned:latest
```

Pin a specific version (recommended):

```sh
docker pull ghcr.io/fabiocicerchia/kubectl-versioned:1.34.10
```

Or use the install script:

```sh
curl -fsSL https://raw.githubusercontent.com/fabiocicerchia/kubectl-versioned/main/install.sh | bash
```

## Usage

```sh
docker run --rm -v ~/.kube:/home/nonroot/.kube:ro \
  fabiocicerchia/kubectl-versioned:1.34.10 get pods -A
```

As a Kubernetes Job step:

```yaml
containers:
  - name: kubectl
    image: fabiocicerchia/kubectl-versioned:1.34.10
    args: ["rollout", "restart", "deployment/my-app"]
```

## Tags

Published tags track the upstream support window (see `versions.txt`):
the latest patch release of the three most recent minors, plus `latest`.

## Development

| Target        | What it does                                    |
|---------------|-------------------------------------------------|
| `make build`  | Build a single-arch image for `VERSION`         |
| `make lint`   | hadolint the Dockerfile                         |
| `make test`   | Smoke test: image reports the expected version  |
| `make release`| Multi-arch buildx build & push                  |

Build a different version: `make build VERSION=1.32.13`.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). By participating you agree to the
[Code of Conduct](CODE_OF_CONDUCT.md). Security issues: see [SECURITY.md](SECURITY.md) —
please don't open a public issue.

## Support

Need help implementing this? [Get in touch](https://fabiocicerchia.it/contact).

## License

Apache 2.0 — see [LICENSE](LICENSE).
