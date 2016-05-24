# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node. 
FROM ubuntu:trusty 
MAINTAINER shailesh patel <shailesh.patel9999@gmail.com> 

# Make perl use default yes
ENV PERL_MM_USE_DEFAULT 1
#WORKDIR /home/env

# Make sure the package repository is up to date. 
RUN apt-get update
RUN apt-get -y --force-yes upgrade
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y gcc g++
RUN apt-get install -y dpkg-dev wget curl zip
RUN apt-get install -y --force-yes openssh-server openjdk-7-jdk sudo git perl cpanminus autoconf automake cmake gettext libtool pkg-config python-pip zlib1g-dev:i386 libssl-dev:i386 libstdc++6:i386 libglib2.0-0:i386 python-dev build-essential gcc-multilib unzip
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install perl module
RUN perl -MCPAN -e 'install Bundle::LWP'

# Add user autobuild to the image 
RUN adduser --quiet autobuild
RUN echo 'autobuild:$up3rNe+S!ave64' | chpasswd 
RUN passwd -l autobuild

# Standard SSH port 
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
