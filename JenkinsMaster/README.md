## Jenkins Master setup with Or without Nginx Proxy using Docker
Following are the ways to setup Jenkins Master:
- Using NGINX Proxy with SSL enabled, serving all request on port 443. 
- Without Usin Nginx Proxy, serving all request on port 8080.


### Jenkins Master setup (Using NGINX Proxy with SSL enabled, serving all request on port 443)
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server
- Nginx is already installed on given node/server
- SSL service letsencrypt is already installed and certificates are ready to use.
- User ubuntu is present on given node/server
- Port 80 and 443 of host/server/node is open and not in use by any other process.

If anything is missing setup will fail.

To setup Jenkins Master on a given node/server run shell/bash script `jenkins_setup_with_nginxproxy.sh` in terminal. Follow the below instructions:
- Go to JenkinsMaster directory using terminal.
- Make script executable by running command `chmod -f u+x jenkins_setup_with_nginxproxy.sh`
- Run the script by running command `./jenkins_setup_with_nginxproxy.sh`

If above commands executes without any error then an image with name **jenkins_version_2** will be created along with Jenkins Master container having following details:
- Localhost(127.0.0.1) using port 8080 will be mapped to master container's port 8080
- Container's volume will be mounted at **/home/ubuntu/jenkins_home**
- User **jenkins** will be created.


### Verification.
In order to verify if above process has setup Jenkins Master on give node/server check docker containers.
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

To steup Jenkins Master manually we need to make sure any old docker image or container for Jenkins Master does not exists. To remove all old images and containers follow these steps:
- Execute `sudo docker ps -a` to list all container. Note down the ID of master container that has exited/running.
- If container is running we need to **stop** it before removing it. To stop the container run `sudo docker stop containerid`
- To remove stopped container execute `sudo docker rm containerid`, this will remove all containers.
- To remove image of Jenkins Master i.e. `jenkins_version_2` image we have to find its id. List all the images of docker by running command `sudo docker images` and note down the id of image with REPOSITORY as `jenkins_version_2`
- Run `sudo docker rmi imageid` to remove the image.

This cleans up all old containers and images. In order to create a container we need to create our image using docker file provided in the repo. Goto JenkinsMaster directory and run
```
sudo docker build -t jenkins_version_2 .
```
If all works then we will get an image with REPOSITORY as `jenkins_version_2`. To list all images run `sudo docker images`, new image with REPOSITORY as `jenkins_version_2` should be present. If it fails to create image on first run try again 2 or 3 times. If fails even after trying 2 or 3 time then there is some problem either with OS/Docker/Dockerfile itself.

Let us create our Jenkins Master container from above created image. In order to create container we have to make sure that our data directory for mounting container volume on host needs to be present. Create a directory at this location `/home/ubuntu/jenkins_home` or any desired location you want. Make sure to note down this path as we are going to need this when creating our container.
To restart container automatically add restart policy to the run command as shown below:

```
sudo docker run --restart="always" -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 127.0.0.1:8080:8080 -d jenkins_version_2
```

Or run follwoing command with no restart policy
```
sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 127.0.0.1:8080:8080 -d jenkins_version_2
```

`-v /home/ububtu/jenkins_home:/var/jenkins_home` is volume mount, where in path `/home/ububtu/jenkins_home` is the one we created earlier. If you have created a directory at a different location then make sure you add that location in the above command.

`-p 127.0.0.1:8080:8080` is used to map localhost(127.0.0.1) with port 8080 to container's port 8080.

`-d` flags makes container as daemon and keeps it running in the background.

`jenkins_version_2` is local REPOSITORY image that we created.

If everything works without any problem or error then you should see Jenkins Master running locally(127.0.0.1) on port 8080. You can verify this by checking details of created docker container using previously mentioned command.


### Jenkins Master setup (Without Usin Nginx Proxy, serving all request on port 8080)
This setup assumes following things:
- OS used on given node/server is Ubuntu 14.04
- Docker is already installed on given node/server
- Git is already installed on given node/server
- User ubuntu is present on given node/server
- Port 8080 of host/server/node is open and not in use by any other process.

If anything is missing setup will fail.

To setup Jenkins Master on a given node/server run shell/bash script `jenkins_setup.sh` in terminal. Follow the below instructions: 
- Go to JenkinsMaster directory using terminal.
- Make script executable by running command `chmod -f u+x jenkins_setup.sh`
- Run the script by running command `./jenkins_setup.sh`

If above commands executes without any error then an image with name **jenkins_version_2** will be created along with Jenkins Master container having following details:
- Host/Node/Server port 8080 will be mapped to master container's port 8080
- Container's volume will be mounted at **/home/ubuntu/jenkins_home**
- User **jenkins** will be created.


### Verification.
In order to verify if above process has setup Jenkins Master on give node/server check docker containers.
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

To steup Jenkins Master manually we need to make sure any old docker image or container for Jenkins Master does not exists. To remove all old images and containers follow these steps:
- Execute `sudo docker ps -a` to list all container. Note down the ID of master container that has exited/running.
- If container is running we need to **stop** it before removing it. To stop the container run `sudo docker stop containerid`
- To remove stopped container execute `sudo docker rm containerid`, this will remove all containers. 
- To remove image of Jenkins Master i.e. `jenkins_version_2` image we have to find its id. List all the images of docker by running command `sudo docker images` and note down the id of image with REPOSITORY as `jenkins_version_2`
- Run `sudo docker rmi imageid` to remove the image.

This cleans up all old containers and images. In order to create a container we need to create our image using docker file provided in the repo. Goto JenkinsMaster directory and run
```
sudo docker build -t jenkins_version_2 .
```
If all works then we will get an image with REPOSITORY as `jenkins_version_2`. To list all images run `sudo docker images`, new image with REPOSITORY as `jenkins_version_2` should be present. If it fails to create image on first run try again 2 or 3 times. If fails even after trying 2 or 3 time then there is some problem either with OS/Docker/Dockerfile itself.

Let us create our Jenkins Master container from above created image. In order to create container we have to make sure that our data directory for mounting container volume on host needs to be present. Create a directory at this location `/home/ubuntu/jenkins_home` or any desired location you want. Make sure to note down this path as we are going to need this when creating our container. Run
To restart container automatically add restart policy to the run command as shown below:
```
sudo docker run --restart="always" -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins_version_2
```

Or run following command with no restart policy

```
sudo docker run -v /home/ubuntu/jenkins_home:/var/jenkins_home -p 8080:8080 -d jenkins_version_2
```

`-v /home/ububtu/jenkins_home:/var/jenkins_home` is volume mount, where in path `/home/ububtu/jenkins_home` is the one we created earlier. If you have created a directory at a different location then make sure you add that location in the above command.

`-p 8080:8080` is used to map host port 8080 to container's port 8080.

`-d` flags makes container as daemon and keeps it running in the background. 

`jenkins_version_2` is local REPOSITORY image that we created.

If everything works without any problem or error then you should see Jenkins Master running on port 8080. You can verify this by entering node/server ip followed by :port.


