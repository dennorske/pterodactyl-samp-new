FROM        ubuntu:14.04

LABEL       author="denNorske" maintainer="den@ducky.rocks"

RUN         dpkg --add-architecture i386 \
            && apt update \
            && apt upgrade -qq \
            && apt install -qq libstdc++6 lib32stdc++6 tar curl iproute2 nano openssl:i386\
            && apt install -qq libtbb2:i386 libtbb-dev:i386 libonig2:i386\
            && useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
