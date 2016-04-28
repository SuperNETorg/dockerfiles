## SETUP JENKINS MASTER AND SLAVE USING DOCKER
This repository contains files to setup `Jenkins Master/Slave` using `docker` on a given node/server
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server
- User ubuntu is present on given node/server

If anything is missing setup will fail.
To install docker run following command in a terminal. 
```
curl -fsSL https://get.docker.com/ | sh
```
### JENKINS MASTER 
To setup Jenkins Master on a given node/server run shell/bash script `jenkins_setup.sh` in terminal. Follow the below instructions: 
- Go to JenkinsMaster directory using terminal.
- Make script executable by running command `chmod -f u+x jenkins_setup.sh`
- Run the script by running command `./jenkins_setup.sh`

If above commands executes without any error then an image with name **jenkins** will be created along with Jenkins Master container having following details:
- Host/Node/Server port 8080 will be mapped to master container's port 8080
- Container's volume will be mounted at **/home/ubuntu/jenkins_home**
- User**jenkins** will be created.


### JENKINS SLAVE
To setup Jenkins Slave on a given node/server run shell/bash script `SlaveSetup.sh` in terminal. Follow the below instructions:
- Got to JenkinsSlave directory using terminal.
- Make script `SlaveSetup.sh` executable by running command `chmod -f u+x SlaveSetup.sh`
- Run the script by running command `./SlaveSetup.sh`

If above commands executes without any error then an image with name **jenkins_slave** will be created along with Jenkins slave container having following details:
- Host/Node/Server port 21777 will be mapped to slave container's SSH Port 22
- Container's volume will be mounted at **/home/ubuntu/slave_home**
- User **autobuild** will be created to run without any password and having no root privileges.

### Verification.
In order to verify if above process has setup Jenkins Master/Slave on give node/server check docker containers.
To display all docker containers run following command:
```
sudo docker ps -a -q
```

To display all docker images run following command:
```
sudo docker images 
```

