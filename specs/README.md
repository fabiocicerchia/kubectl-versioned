# Specifications of kubectl-versioned

What this code does, one atomic Gherkin scenario per behaviour, read from the code by code-atlas.
Tags: `@verified` a test asserts it · `@inferred` read from the code only · `@gap` an entry point no test covers · `@human` written or amended by a person, never rewritten.

## Developer Tooling
The commands contributors use to set up, check and test the project locally.

- **Command catalogue**: [Discovering the available commands](developer-tooling/command-catalogue/make-command-catalogue.feature) (1)

## Documentation Site
The look and feel of the project's documentation website and landing page.

- **Brand theme and palette**: [Keeping the documentation on one brand palette](documentation-site/brand-theme/docs-brand-theme.feature) (3)
- **Typography and layout**: [Presenting the documentation without network-loaded assets](documentation-site/typography-and-layout/docs-typography-and-layout.feature) (4)

## Getting Started
How a user obtains the image and starts using kubectl against their clusters.

- **Using kubectl with your cluster**: [Using kubectl from the image against your cluster](getting-started/cluster-access/cluster-access-from-image.feature) (1)
- **One-line install**: [Installing kubectl-versioned with one command](getting-started/one-line-install/one-line-install.feature) (3)

## kubectl Image
The container image that delivers a plain upstream kubectl at a chosen Kubernetes version.

- **Binary download and verification**: [Downloading and verifying the kubectl binary](kubectl-image/binary-acquisition/kubectl-binary-verification.feature) (2)
- **Image metadata and licensing**: [Image metadata and licensing](kubectl-image/image-metadata/kubectl-image-metadata.feature) (2)
- **Runtime behaviour**: [Running kubectl from the image](kubectl-image/runtime-behaviour/kubectl-runtime.feature) (2)
- **Version selection**: [Choosing the kubectl version an image carries](kubectl-image/version-selection/kubectl-version-selection.feature) (2)

## Publishing & Releases
Building and distributing the image to the container registry for each supported version.

- **Multi-arch release**: [Releasing multi-architecture kubectl images](publishing/multi-arch-release/multi-arch-release.feature) (2)

## Security & Supply Chain
Guarantees that the published image is minimal, locked down and built from trusted, pinned inputs.

- **Non-root execution**: [Running kubectl as an unprivileged user](security-hardening/non-root-execution/non-root-kubectl.feature) (1)
- **Security scanning**: [Scanning the source tree for security problems](security-hardening/security-scanning/source-security-scan.feature) (2)
