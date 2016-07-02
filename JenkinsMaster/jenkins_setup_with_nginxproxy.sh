#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

#Install cURL and docker automated setup from Docker site
sudo apt-get install curl -y

#Setup Git and pull Dockerfile
sudo apt-get install git -y

# To create image for jenkins version <2
#sudo docker build -t jenkins .

# To create image for jenkins version >=2.0
sudo docker build -t jenkins_version_2 .

# To setup old version of jenkins i.e. <2.0
#sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins
# TO setup new version of jenkins i.e. >=2.0
#sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 127.0.0.1:8080:8080 -d jenkins_version_2

# Add restart policy to restart container always
sudo docker run --restart="always" -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 127.0.0.1:8080:8080 -d jenkins_version_2

echo "JENKINS RUNNING LOCALLY(127.0.0.1) ON PORT 8080"
