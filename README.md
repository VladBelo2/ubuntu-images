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
docker pull vladbelo2/ubuntu-tools:latest
docker run -it vladbelo2/ubuntu-tools
```

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

