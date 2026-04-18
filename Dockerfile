FROM summerwind/actions-runner:latest

USER root

RUN curl -LO https://dl.k8s.io/release/v1.30.0/bin/linux/amd64/kubectl \
 && install -m 0755 kubectl /usr/local/bin/kubectl \
 && rm kubectl

RUN curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# IMPORTANTE: garantir permissões corretas
RUN chown -R runner:runner /home/runner

# buildx
RUN mkdir -p /usr/libexec/docker/cli-plugins \
 && curl -sSL https://github.com/docker/buildx/releases/latest/download/buildx-linux-amd64 \
    -o /usr/libexec/docker/cli-plugins/docker-buildx \
 && chmod +x /usr/libexec/docker/cli-plugins/docker-buildx

# trivy (opcional mas recomendado)
RUN curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh \
    | sh -s -- -b /usr/local/bin

USER runner
