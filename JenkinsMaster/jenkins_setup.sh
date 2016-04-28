#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

#Install cURL and docker automated setup from Docker site
sudo apt-get install curl -y

#Setup Git and pull Dockerfile
sudo apt-get install git -y

sudo docker build -t jenkins .
sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins

echo "JENKINS RUNNING ON PORT 8080"
