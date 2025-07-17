FROM ubuntu:24.04

LABEL \
    org.opencontainers.image.authors="Vlad Belo" \
    org.opencontainers.image.title="Ubuntu Lab Image" \
    org.opencontainers.image.description="Ubuntu 24.04 with troubleshooting tools" \
    org.opencontainers.image.url="https://hub.docker.com/r/vladbelo2/ubuntu-lab"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    sudo \
    curl wget iproute2 iputils-ping net-tools dnsutils lsb-release \
    bash-completion vim less tmux htop ufw openssh-server netcat-traditional \
    systemd iputils-tracepath traceroute tcpdump \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add lab files and create student user
COPY lab/ /lab/
RUN useradd -ms /bin/bash student \
    && echo "student ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && chown -R student:student /lab

# Start the troubleshooting lab setup
USER student
WORKDIR /home/student
CMD ["/lab/start.sh"]
