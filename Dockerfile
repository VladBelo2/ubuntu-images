FROM ubuntu:24.04

LABEL maintainer="vladbelo2"
LABEL description="Ubuntu 24.04 with networking & troubleshooting tools preinstalled"

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
