IMAGE     ?= fabiocicerchia/kubectl-versioned
VERSION   ?= 1.34.10
PLATFORMS ?= linux/amd64,linux/arm64

.PHONY: help setup build lint test push release

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  %-10s %s\n", $$1, $$2}'

setup: ## Install the pre-commit hook
	pre-commit install

build: ## Build a single-arch image for VERSION
	docker build --network=host --build-arg KUBECTL_VERSION=$(VERSION) -t $(IMAGE):$(VERSION) .

lint: ## hadolint the Dockerfile + shellcheck
	docker run --rm -i hadolint/hadolint < Dockerfile
	shellcheck test.sh

test: build ## Build + smoke test the image
	./test.sh $(IMAGE):$(VERSION)

push: build ## Build + push a single-arch image
	docker push $(IMAGE):$(VERSION)

release: ## Multi-arch buildx build & push (VERSION + latest)
	docker buildx build --platform $(PLATFORMS) \
		--build-arg KUBECTL_VERSION=$(VERSION) \
		-t $(IMAGE):$(VERSION) -t $(IMAGE):latest --push .
