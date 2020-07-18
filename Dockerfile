FROM ubuntu:latest
RUN dpkg --add-architecture i386 && \
    apt update && \
    apt-get install -qq g++-multilib git ca-certificates curl wget nano net-tools nmap sudo
RUN curl https://raw.githubusercontent.com/Southclaws/sampctl/master/install-deb.sh | sh

ENV	DEBIAN_FRONTEND=noninteractive

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
