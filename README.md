## SETUP JENKINS MASTER AND SLAVE USING DOCKER
This repository contains files to setup `Jenkins Master/Slave` using `docker` on a given node/server
Please refer to documentation in respective directory to setup Jenkins Master/Slave.

To setup NGINX and Letsencrypt please refer to the documentation in `NginxSetup` directory

### Docker Installation 
To install docker simply run below command in terminal

```
curl -fsSL https://get.docker.com/ | sh
```

### Docker Commands 
- List all containers: `sudo docker ps -a`
- List all images: `sudo docker images`
- Check docker container logs: `sudo docker logs containerid`
- Stop running container: `sudo docker stop containerid`
- Remove running container: `sudo docker rm containerid`
- Remove Image: `sudo docker rmi imageid`
