# ARC Runner

Lightweight runner for integrating workloads with GitHub Actions using Kubernetes and ARC (Actions Runner Controller).

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage Example](#usage-example)
- [Contributing](#contributing)
- [Useful Links](#useful-links)
- [Contact](#contact)

---

## Overview

This project provides a custom runner implementation for GitHub Actions via Kubernetes, using ARC for scalable and dynamic execution.

Main goals:

- Ephemeral runners
- Scalable CI workloads
- Secure execution in isolated environments

## Architecture

- Kubernetes cluster
- ARC (Actions Runner Controller)
- GitHub Actions integration
- Containerized workloads

## Features

- Dynamic runner provisioning
- Kubernetes-native deployment
- Support for ephemeral runners
- CI/CD workload isolation

## Requirements

- Kubernetes cluster (v1.25+ recommended)
- Helm
- GitHub repository with Actions enabled
- ARC installed in the cluster

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

Create a RunnerDeployment:

```yml
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: arc-runner
spec:
  replicas: 1
  template:
    spec:
      # ...
```

## Usage Example

1. Push to your repository with a configured GitHub Actions workflow.
2. ARC will create an ephemeral runner to execute the job.
3. View logs and results directly on GitHub.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines, opening issues, and pull requests.

## Useful Links

- [ARC Official Documentation](https://github.com/actions/actions-runner-controller)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Kubernetes](https://kubernetes.io/)

## Contact

For questions, suggestions, or support, open an issue or email: <your-email@example.com>
      repository: <owner>/<repo>

Apply:

```sh
kubectl apply -f runner.yml
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
