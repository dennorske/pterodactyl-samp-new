FROM        ubuntu:18.04

LABEL       author="denNorske" maintainer="den@ducky.rocks"

RUN         dpkg --add-architecture i386 \
            && apt-get update -qq\
            && apt-get upgrade -qq \
            && apt-get install -qq libstdc++6 lib32stdc++6 tar curl iproute2 nano wget ca-certificates\
            && apt-get install -qq libtbb2:i386 libtbb-dev:i386 libmysqlclient-dev:i386\
            && useradd -d /home/container -m container

RUN         apt-get install -qq libssl1.0.0:i386 libssl-dev:i386


USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
