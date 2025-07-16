FROM ubuntu:24.04

LABEL maintainer="vladbelo2"
LABEL description="Ubuntu 24.04 with networking & troubleshooting tools preinstalled"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget iproute2 iputils-ping net-tools dnsutils lsb-release \
    bash-completion vim less tmux htop \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ["bash"]
