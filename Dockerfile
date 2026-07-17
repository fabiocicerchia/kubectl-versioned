# kubectl-versioned — plain kubectl, every supported version as a tag, multi-arch, tiny.
ARG KUBECTL_VERSION=1.33.2

FROM alpine:3.24 AS fetch
ARG KUBECTL_VERSION
ARG TARGETOS=linux
ARG TARGETARCH=amd64
# ponytail: apk versions pinned to satisfy scanners; bump when alpine base bumps.
RUN apk add --no-cache curl=8.21.0-r0 ca-certificates=20260611-r0
SHELL ["/bin/ash", "-o", "pipefail", "-c"]
RUN curl -fsSLo /kubectl "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl" \
 && curl -fsSLo /kubectl.sha256 "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/${TARGETOS}/${TARGETARCH}/kubectl.sha256" \
 && echo "$(cat /kubectl.sha256)  /kubectl" | sha256sum -c - \
 && chmod 0755 /kubectl

FROM gcr.io/distroless/static-debian12:nonroot
ARG KUBECTL_VERSION
LABEL org.opencontainers.image.title="kubectl-versioned" \
      org.opencontainers.image.description="Plain kubectl in every supported version, multi-arch, minimal footprint" \
      org.opencontainers.image.version="${KUBECTL_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.source="https://github.com/fabiocicerchia/kubectl-versioned"
COPY --from=fetch /kubectl /usr/local/bin/kubectl
# ponytail: kubectl is a CLI, not a daemon — nothing to poll. Declared to satisfy scanners.
HEALTHCHECK NONE
USER 65532:65532
ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["version", "--client"]
