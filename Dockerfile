FROM ubuntu:latest
MAINTAINER Jun-Ru Chang <jrjang@gmail.com>

ARG DOCKER_BINARY_TARBALL=docker-18.03.0-ce.tgz
ARG OPENJDK_JRE=openjdk-8-jre
ARG SWARM_CLIENT_VERSION=3.9
ARG SWARM_CLIENT=swarm-client-$SWARM_CLIENT_VERSION.jar

ADD https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$SWARM_CLIENT_VERSION/$SWARM_CLIENT /
ADD https://download.docker.com/linux/static/stable/x86_64/$DOCKER_BINARY_TARBALL /tmp

RUN apt-get -y update && \
    apt-get -y install curl python ssh git build-essential automake autoconf ncurses-dev flex bison quilt unzip zlib1g-dev gawk subversion libssl-dev libc6-i386 libc6-dev-i386 lib32z1 bc cpio netcat iproute2 $OPENJDK_JRE && \
    curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && \
    chmod 755 /$SWARM_CLIENT /usr/bin/python && \
    ln -s /$SWARM_CLIENT /swarm-client.jar && \
    tar zxf /tmp/$DOCKER_BINARY_TARBALL -C /usr/local/bin --strip 1

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
