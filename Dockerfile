FROM ubuntu:24.04

LABEL \
    org.opencontainers.image.authors="Vlad Belo" \
    org.opencontainers.image.title="Ubuntu Lab Image" \
    org.opencontainers.image.description="Ubuntu 24.04 with troubleshooting tools" \
    org.opencontainers.image.url="https://hub.docker.com/r/vladbelo2/ubuntu-lab"

ENV DEBIAN_FRONTEND=noninteractive

# Install software-properties-common early to use add-apt-repository
RUN apt-get update && apt-get install -y software-properties-common

# Add the Git PPA and install Git 2.50+
RUN add-apt-repository ppa:git-core/ppa -y && \
    apt-get update && \
    apt-get install -y git

RUN apt-get install -y \
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

COPY lab/bashrc_append /tmp/bashrc_append
RUN cat /tmp/bashrc_append >> /home/student/.bashrc \
    && chown student:student /home/student/.bashrc \
    && rm /tmp/bashrc_append

# Start the troubleshooting lab setup
USER student
WORKDIR /home/student
CMD ["/lab/start.sh"]
