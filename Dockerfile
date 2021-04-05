FROM        ubuntu:18.04

LABEL       author="denNorske" maintainer="den@ducky.rocks"

RUN         dpkg --add-architecture i386 \
            && apt-get update -qq\
            && apt-get upgrade -qq \
            && apt-get install -qq libstdc++6 lib32stdc++6 tar curl iproute2 nano wget openssl:i386 ca-certificates\
            && apt-get install -qq libtbb2:i386 libtbb-dev:i386 libmysqlclient-dev:i386\
            && useradd -d /home/container -m container
RUN         add-apt-repository ppa:deadsnakes/ppa

            # Let's install dependencies for pip, python and wheel on 32-bit
RUN         apt-get -qq install libc6-dev:i386 gcc:i386 && \
            apt-get -qq install python3.8:i386 libpython3.8:i386 python3-pip && \
            apt-get -qq install python3.8-dev:i386
RUN         apt-get -qq install libc6:i386 libncurses5:i386 libstdc++6:i386
RUN         apt-get -qq install gcc-i686-linux-gnu
            
            # Manual dependencies here (commonly used)
RUN         python3 -m pip install discord.py whirlpool mysql-connector-python datetime --upgrade

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
