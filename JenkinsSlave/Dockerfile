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

# Add user jenkins to the image 
RUN adduser --quiet autobuild
# Set password for the jenkins user (you may want to alter this). 
#RUN echo 'autobuild:$up3rNe+S!ave64' | chpasswd && adduser autobuild sudo
RUN echo 'autobuild:$up3rNe+S!ave64' | chpasswd 
RUN passwd -l autobuild

#RUN touch /etc/sudoers.d/autobuild
#RUN echo "autobuild ALL=(ALL) NOAPSSWD: ALL" >> /etc/sudoers.d/autobuild
# Standard SSH port 
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
