FROM summerwind/actions-runner:latest

USER root

ARG TARGETARCH=amd64

# base mínima
RUN apt-get update && apt-get install -y \
    git \
    jq \
    curl \
    ca-certificates \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# buildx (multi-arch correto)
RUN mkdir -p /usr/local/lib/docker/cli-plugins \
 && curl -sSL https://github.com/docker/buildx/releases/latest/download/buildx-linux-${TARGETARCH} \
    -o /usr/local/lib/docker/cli-plugins/docker-buildx \
 && chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

ENV DOCKER_CLI_PLUGIN_EXTRA_DIRS=/usr/local/lib/docker/cli-plugins

# permissões
RUN chown -R runner:runner /home/runner

USER runner
