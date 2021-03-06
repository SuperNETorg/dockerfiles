## SETUP JENKINS SLAVE USING DOCKER
This repository contains files to setup `Jenkins Slave` using `docker` on a given node/server
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server
- User ubuntu (or any user that you want to use e.g. root/ubuntu/etc) is present on given node/server
- For Jenkins slave port 21777 of host/server/node is open and not in use by any other process.

If anything is missing setup will fail.
To install docker run following command in a terminal. 
```
curl -fsSL https://get.docker.com/ | sh
```


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
In order to verify if above process has setup Jenkins Slave on give node/server check docker containers.
To display all docker containers run following command:
```
sudo docker ps -a 
```

To display all docker images run following command:
```
sudo docker images 
```

### Troubleshoot Setup
If above scripts fails to create containers on given node or machine then please follow all the below steps to debug and manually create all required containers.

**JENKINS SLAVE**

To setup Jenkins Slave manually we need to make sure no old image or container for Jenkins slave exists. Procedure to remove old image and container is same as above, only difference is instead of looking for master container and image you will be looking for slave container and image. Slave image REPOSITORY is `jenkins_slave`. After removing all image and containers please follow these steps to create image and container:
- Goto directory `JenkinsSlave`.
- To create an image run 
```
sudo docker build -t jenkins_slave .
```
This will create image `jenkins_slave`. If first run fails try again for 2 or 3 times. If it still fails then more debugging is required.

- To create a container make sure directory for container volume mapping exists. Create a directory at `/home/ubuntu/slave_home` or any desired location that you prefer. Note down the comlpete path for this directory. Make sure port 21777 is open and not in use. Run below command to create the container
To restart container automatically add restart policy to run command as shown below:

```
sudo docker run --restart="always" -d -p 21777:22 -v /home/ubuntu/slave_home:/home/autobuild jenkins_slave
```

Or use below command without restart policy
```
sudo docker run --restart="always" -d -p 21777:22 -v /home/ubuntu/slave_home:/home/autobuild jenkins_slave
```

`-d` flag makes container as daemon and keeps it running in the background.

`-p 21777:22` maps port 21777 of host to containers port 22.

`-v /home/ubuntu/slave_home:/home/autobuild` maps the volume for container.

`jenkins_slave` is local REPOSITORY image that we created.

This will create Jenkins slave container. You can check this by listing all containers using command `sudo docker ps -a`


### ENVIRONMENT SETUP FOR IGUANA CHROME BUILD
This step is required only once when `slave_home` directory contains nothing.
- Copy `boot.sh` file into `slave_home` directory i.e. `/home/ubuntu/slave_home/`
- Login to docker container, obtain container id by running `sudo docker ps -a`, run command `sudo docker exec -i -t --user=autobuild containerid /bin/bash`
- After login to container go to `/home/autobuild/` and run command `./boot.sh`, if boot.sh is not executable then make it executable by running command `chmod u+x boot.sh`
- This will steup the environment for chrome build.
