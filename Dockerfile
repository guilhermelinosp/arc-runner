FROM summerwind/actions-runner:latest

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    jq \
    unzip \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/lib/docker/cli-plugins \
 && curl -fsSL "https://github.com/docker/buildx/releases/download/v0.33.0/buildx-v0.33.0.linux-amd64" \
    -o /usr/local/lib/docker/cli-plugins/docker-buildx \
 && chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx

ENV DOCKER_CLI_PLUGIN_EXTRA_DIRS=/usr/local/lib/docker/cli-plugins

RUN chown -R runner:runner /home/runner
WORKDIR /home/runner

USER runner
