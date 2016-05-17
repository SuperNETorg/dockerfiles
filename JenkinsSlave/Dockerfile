# This Dockerfile is used to build an image containing basic stuff to be used as a Jenkins slave build node. 
FROM ubuntu:trusty 
MAINTAINER shailesh patel <shailesh.patel9999@gmail.com> 
# Make sure the package repository is up to date. 
RUN apt-get update
RUN apt-get -y upgrade

# Install a basic SSH server 
RUN apt-get install -y openssh-server
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd
RUN mkdir -p /var/run/sshd

# Install JDK 7 (latest edition) 
RUN apt-get install -y openjdk-7-jdk
RUN apt-get install -y sudo
RUN apt-get update && apt-get install -y git curl zip && rm -rf /var/lib/apt/lists/*

# Add user autobuild to the image 
RUN adduser --quiet autobuild
RUN echo 'autobuild:$up3rNe+S!ave64' | chpasswd 
RUN passwd -l autobuild

# Standard SSH port 
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
