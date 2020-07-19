FROM  ubuntu:latest
ENV   DEBIAN_FRONTEND=noninteractive
RUN   dpkg --add-architecture i386 && \
      apt update && \
      apt-get install -qq g++-multilib git ca-certificates curl wget nano net-tools nmap sudo
RUN   curl https://raw.githubusercontent.com/Southclaws/sampctl/master/install-deb.sh | sh
RUN   useradd -d /home/container -m container


USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container
#testing multiple commands in a file instead, as pterodactyl doesn't like long startup commands
RUN         echo "sampctl p get {{gituser}}/{{gitrepo}} && sampctl p ensure --update && sampctl p build && sampctl p run" > sampctl.sh
RUN         chmod +x sampctl.sh
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
