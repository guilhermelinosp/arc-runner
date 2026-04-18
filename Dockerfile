ARG BASE_IMAGE=summerwind/actions-runner:latest
FROM ${BASE_IMAGE}

USER root

ARG TARGETARCH=amd64
ARG BUILDX_VERSION=v0.33.0

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
    unzip \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/lib/docker/cli-plugins \
 && set -eux; \
    arch="$TARGETARCH"; \
    case "$TARGETARCH" in \
      amd64) arch="amd64" ;; \
      arm64) arch="arm64" ;; \
      arm)   arch="arm-v7" ;; \
    esac; \
    url="https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-${arch}"; \
    curl -fsSL "$url" -o /usr/local/lib/docker/cli-plugins/docker-buildx \
 && chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

ENV DOCKER_CLI_PLUGIN_EXTRA_DIRS=/usr/local/lib/docker/cli-plugins

RUN chown -R runner:runner /home/runner
WORKDIR /home/runner

USER runner
