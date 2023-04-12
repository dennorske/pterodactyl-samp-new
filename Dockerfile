FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        gcc:i386 \
        g++:i386 \
        libstdc++6:i386 \
        python3-dev:i386 \
        libmysqlclient-dev:i386 \
        openssl:i386 \
        tar \
        curl \
        iproute2 \
        nano \
        wget \
        ca-certificates \
        python3:i386 \
        python3-pip \
    && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --upgrade \
        pip \
        setuptools \
        wheel \
        bcrypt \
        black==22.10.0 \
        click==8.1.3 \
        flake8==6.0.0 \
        mccabe==0.7.0 \
        mypy==0.991 \
        mypy-extensions==0.4.3 \
        mysql-connector-python==8.0.31 \
        pathspec==0.10.2 \
        platformdirs==2.5.4 \
        protobuf==3.20.1 \
        pycodestyle==2.10.0 \
        pyflakes==3.0.1 \
        pymysql \
        python-dotenv==0.21.0 \
        requests==2.28.2 \
        SQLAlchemy==2.0.0b3 \
        tomli==2.0.1 \
        typing_extensions==4.4.0 \
        Whirlpool==1.0.0 \ 
    && \
    pip list


RUN useradd -d /home/container -m container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY        ./entrypoint.sh /entrypoint.sh

CMD         ["/bin/bash", "/entrypoint.sh"]
