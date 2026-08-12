# kubectl-versioned — plain kubectl, every supported version as a tag, multi-arch, tiny.
ARG KUBECTL_VERSION=1.34.10

FROM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS fetch
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

FROM gcr.io/distroless/static-debian12:nonroot@sha256:1b7b9f0f0e0a1d2155f531db587cc48ec26aaf97ab64364225f5bf18a054e66a
ARG KUBECTL_VERSION
LABEL org.opencontainers.image.title="kubectl-versioned" \
      org.opencontainers.image.description="Plain kubectl in every supported version, multi-arch, minimal footprint" \
      org.opencontainers.image.version="${KUBECTL_VERSION}" \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.source="https://github.com/fabiocicerchia/kubectl-versioned"
COPY NOTICE /NOTICE
COPY --from=fetch /kubectl /usr/local/bin/kubectl
# ponytail: kubectl is a CLI, not a daemon — nothing to poll. Declared to satisfy scanners.
HEALTHCHECK NONE
USER 65532:65532
ENTRYPOINT ["/usr/local/bin/kubectl"]
CMD ["version", "--client"]
