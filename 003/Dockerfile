FROM jenkins/jenkins:latest

ENV ROOT_PATH /root

USER root
RUN apt-get update -y && \
    curl -fL -o docker.tgz "https://download.docker.com/linux/static/test/x86_64/docker-19.03.4.tgz" && \
    tar --strip-components=1 -xvzf docker.tgz -C /usr/bin && \
    groupadd docker && \
    gpasswd -a jenkins docker
