## SETUP JENKINS MASTER AND SLAVE USING DOCKER i
This repository contains files to setup `Jenkins Master/Slave` using `docker` on a given node/server
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server

If docker is not installed then you can install it by running following command in a terminal. 
```
curl -fsSL https://get.docker.com/ | sh
```
### JENKINS MASTER 
To setup Jenkins Master on a given node/server run shell/bash script `jenkins_setup.sh` in terminal. Follow the below instructions: 
- Make script executable by running command `chmod -f u+x jenkins_setup.sh`
- Run the script by running command `./JenkinsMaster/jenkins_setup.sh`
If above command executes without any error then Jenkins Master will be setup in a container.

To display all docker containers run following command: 
```
sudo docker ps -a -q
``` 
### JENKINS SLAVE

