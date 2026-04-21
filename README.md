# ARC Runner

Lightweight runner for integrating workloads with GitHub Actions using Kubernetes and ARC (Actions Runner Controller).

## Overview

This project provides a custom runner implementation designed to work with GitHub Actions through Kubernetes, leveraging ARC for scalable and dynamic execution.

The goal is to enable:

* Ephemeral runners
* Scalable CI workloads
* Secure execution in isolated environments

## Architecture

* Kubernetes cluster
* ARC (Actions Runner Controller)
* GitHub Actions integration
* Containerized workloads

## Features

* Dynamic runner provisioning
* Kubernetes-native deployment
* Support for ephemeral runners
* CI/CD workload isolation

## Requirements

* Kubernetes cluster (v1.25+ recommended)
* Helm
* GitHub repository with Actions enabled
* ARC installed in the cluster

## Installation

```sh
# Add ARC Helm repo
helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller

# Install ARC
helm install arc actions-runner-controller/actions-runner-controller \
  --namespace arc-system \
  --create-namespace
```

## Configuration

Create a runner deployment:

```yaml
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: arc-runner
spec:
  replicas: 1
  template:
    spec:
      repository: <owner>/<repo>
```

Apply:

```sh
kubectl apply -f runner.yaml
```

## Usage

Once deployed, workflows in your GitHub repository will automatically use the configured runners.

Example workflow:

```yaml
jobs:
  build:
    runs-on: self-hosted
    steps:
      - uses: actions/checkout@v3
      - run: echo "Running on ARC runner"
```

## Development

To contribute:

```sh
git clone <repo>
cd arc-runner
```

Make changes and submit a pull request.

## Security

* Avoid embedding secrets in runner images
* Use Kubernetes secrets or external secret managers
* Prefer ephemeral runners for sensitive workloads

## License

GNU GENERAL PUBLIC LICENSE
