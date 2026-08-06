# Changelog

All notable changes to this project are documented here. The format is based
on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project
adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.1](https://github.com/fabiocicerchia/kubectl-versioned/compare/v0.1.0...v0.1.1) (2026-08-06)


### Bug Fixes

* **pre-commit:** stop check-yaml failing on Helm templates and multi-doc manifests ([ff68e00](https://github.com/fabiocicerchia/kubectl-versioned/commit/ff68e00869b93a276c49b16fa6b98c485260d5d4))
* **security:** skip the SARIF upload on private repos ([2b4dc74](https://github.com/fabiocicerchia/kubectl-versioned/commit/2b4dc74a8de52bf96b72359f7ede5c10c3da413b))

## [Unreleased]

## [0.1.0]

### Added

- Multi-arch distroless Docker images for every supported Kubernetes version.
- Matrix build from `versions.txt` — one image tag per kubectl version.
- SHA-256 checksum verification against official `dl.k8s.io` at build time.
- `linux/amd64` and `linux/arm64` manifests published to GHCR.

[Unreleased]: https://github.com/fabiocicerchia/kubectl-versioned/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/fabiocicerchia/kubectl-versioned/releases/tag/v0.1.0
