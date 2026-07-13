# Contributing

Thanks for taking the time to contribute to kubectl-versioned!

## Getting started

You need Docker (with buildx for multi-arch), `make`, and `shellcheck`.

1. Fork and clone the repo.
1. Install the git hooks and dev tooling: `make setup`.
1. Create a branch: `git checkout -b feat/short-description`.

```sh
make build   # build the image locally
make lint    # hadolint + shellcheck
make test    # build + smoke test (./test.sh)
```

## Making changes

- Keep changes focused; one logical change per PR.
- Ensure CI (`ci`, `code-quality`, `security`) passes.
- Match the existing style; don't reformat unrelated files.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/): `feat:`,
`fix:`, `docs:`, `chore:`, etc. It keeps history readable.

## Publishing a version

Images are published by [`.github/workflows/release.yml`](.github/workflows/release.yml),
which runs whenever `versions.txt` or the `Dockerfile` changes on `main`. It
builds one multi-arch image tag per line in `versions.txt` (the first line also
gets `:latest`).

To publish a new kubectl release, open a PR that adds its patch tag to
`versions.txt` (and prunes any version that fell out of the support window).
Merging to `main` does the rest — no manual tagging or pushing.

## Pull requests

Fill out the PR template, link related issues, and request review. By
participating you agree to the [Code of Conduct](CODE_OF_CONDUCT.md).
