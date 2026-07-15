# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.1.0]

### Added

- Multi-arch distroless Docker images for every supported Kubernetes version.
- Matrix build from `versions.txt` — one image tag per kubectl version.
- SHA-256 checksum verification against official `dl.k8s.io` at build time.
- `linux/amd64` and `linux/arm64` manifests published to GHCR.

[Unreleased]: https://github.com/fabiocicerchia/kubectl-versioned/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/fabiocicerchia/kubectl-versioned/releases/tag/v0.1.0
