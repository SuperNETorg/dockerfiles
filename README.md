## SETUP JENKINS MASTER AND SLAVE USING DOCKER
This repository contains files to setup `Jenkins Master/Slave` using `docker` on a given node/server
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server
- User ubuntu is present on given node/server
- For Jenkins master port 8080 of host/server/node is open and not in use by any other process.
- For Jenkins slave port 21777 of host/server/node is open and not in use by any other process.

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
- User **jenkins** will be created.


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

### Toubleshooting Setup
If above scripts fails to create containers on given node or machine then please follow all the below steps to debug and manually create all required containers.

**JENKINS MASTER**

To steup Jenkins Master manually we need to make sure any old docker image or container for Jenkins Master does not exists. To remove all old images and containers follow these steps:
- Execute `sudo docker ps -a` to list all container. Note down the ID of master container that has exited/running.
- If container is running we need to **stop** it before removing it. To stop the container run `sudo docker stop containerid`
- To remove stopped container execute `sudo docker rm containerid`, this will remove all containers. 
- To remove image of Jenkins Master i.e. `jenkins` image we have to find its id. List all the images of docker by running command `sudo docker images` and note down the id of image with REPOSITORY as `jenkins`
- Run `sudo docker rmi imageid` to remove the image.

This cleans up all old containers and images. In order to create a container we need to create our image using docker file provided in the repo. Goto JenkinsMaster directory and run
```
sudo docker build -t jenkins .
```
If all works then we will get an image with REPOSITORY as `jenkins`. To list all images run `sudo docker images`, new image with REPOSITORY as `jenkins` should be present. If it fails to create image on first run try again 2 or 3 times. If fails even after trying 2 or 3 time then there is some problem either with OS/Docker/Dockerfile itself.

Let us create our Jenkins Master container from above created image. In order to create container we have to make sure that our data directory for mounting container volume on host needs to be present. Create a directory at this location `/home/ubuntu/jenkins_home` or any desired location you want. Make sure to note down this path as we are going to need this when creating our container. Run
```
sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins
```

`-v /home/ububtu/jenkins_home:/var/jenkins_home` is volume mount, where in path `/home/ububtu/jenkins_home` is the one we created earlier. If you have created a directory at a different location then make sure you add that location in the above command.

`-p 8080:8080` is used to map host port 8080 to container's port 8080.

`-d` flags makes container as daemon and keeps it running in the background. 

`jenkins` is local REPOSITORY image that we created.

If everything works without any problem or error then you should see Jenkins Master running on port 8080. You can verify this by entering node/server ip followed by :port.



**JENKINS SLAVE**

To setup Jenkins Slave manually we need to make sure no old image or container for Jenkins slave exists. Procedure to remove old image and container is same as above, only difference if instead of looking for master container and image you will be looking for slave container and image. Slave image REPOSITORY is `jenkins_slave`. After removing all image and containers please follow these steps to create image and container:
- Goto directory `JenkinsSlave`.
- To create an image run 
```
sudo docker build -t jenkins_slave .
```
This will create image `jenkins_slave`. If first run fails try again for 2 or 3 times. If it still fails then more debugging is required.

- To create a container make sure directory for container volume mapping exists. Create a directory at `/home/ubuntu/slave_home` or any desired location that you prefer. Note down the comlpete path for this directory. Make sure port 21777 is open and not in use. Run below command to create the container
```
sudo docker run -d -p 21777:22 -v /home/ubuntu/slave_home:/home/autobuild jenkins_slave
```

`-d` flag makes container as daemon and keeps it running in the background.

`-p 21777:22` maps port 21777 of host to containers port 22.

`-v /home/ubuntu/slave_home:/home/autobuild` maps the volume for container.

`jenkins_slave` is local REPOSITORY image that we created.

This will create Jenkins slave container. You can check this by listing all containers using command `sudo docker ps -a`