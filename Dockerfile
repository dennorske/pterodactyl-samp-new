FROM        ubuntu:18.04

LABEL       author="denNorske" maintainer="den@ducky.rocks"

RUN         dpkg --add-architecture i386 \
            && apt-get update -qq\
            && apt-get upgrade -qq \
            && apt-get install -qq libstdc++6 lib32stdc++6 tar curl iproute2 nano wget openssl:i386 ca-certificates python3 python3-dev python3-pip\
            && apt-get install -qq libtbb2:i386 libtbb-dev:i386 libmysqlclient-dev:i386\
            && useradd -d /home/container -m container

RUN         python3 -m pip install discord.py
USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
