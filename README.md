![Docker Build](https://github.com/vladbelo2/ubuntu-images/actions/workflows/docker.yml/badge.svg)

🔒 This repository is read-only for the public. Only the repository owner can push to `main`.

# 🐧 Ubuntu Tools Image

A lightweight Ubuntu 24.04 Docker image preloaded with essential diagnostic tools like `ping`, `curl`, `ip`, and more.

## 🔧 Included Tools

- `curl`, `wget`, `lsb_release`
- `ping`, `ip`, `netstat`
- `dnsutils`, `net-tools`
- `vim`, `less`, `tmux`, `htop`

## 🚀 Quick Start

### Docker CLI

```bash
docker pull vladbelo2/ubuntu-lab:latest
docker run -it --rm --name ubuntu-lab vladbelo2/ubuntu-lab:latest
```

📘 See [`lab/lab_manual.md`](lab/lab_manual.md) for full scenario walkthroughs.

## 🔨 Local Build

```bash
make build
make push
```

Or:

```bash
./build-push.sh
```

## 📦 Based On

> ubuntu:24.04

## 🛠 Maintainer

Vlad Belo
