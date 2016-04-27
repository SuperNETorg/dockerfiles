#!/bin/bash
curl -fsSL https://get.docker.com/ | sh
mkdir -p /home/ubuntu/slave_home
sudo docker build -t jenkins_slave
sudo docker run -d -p 21777:22 -v /home/ubuntu/slave_home:/home/autobuild jenkins_slave
