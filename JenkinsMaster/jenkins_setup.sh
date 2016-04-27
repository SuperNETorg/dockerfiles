#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

#Install cURL and docker automated setup from Docker site
sudo apt-get install curl -y
#curl -fsSL https://get.docker.com/ | sh

#Setup Git and pull Dockerfile
sudo apt-get install git -y

#git clone https://github.com/michaelneale/jenkins-ci.org-docker.git
sudo docker build -t jenkins jenkins-ci.org-docker/
sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins

echo "JENKINS RUNNING ON PORT 8080"
