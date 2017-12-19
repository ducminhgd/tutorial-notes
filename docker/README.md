# Overview

> Docker is a container technology for Linux that allows a developer to package up an application with all of the parts it needs.

How does docker work [here](docs/how-docker-works.md)

# Installation

## Ubuntu

```
# required packages
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

# Add GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify fingerprint
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
sudo apt-key fingerprint 0EBFCD88

# Add repo
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

# Install
sudo apt-get install docker-ce
```

## CentOS

```
# Required packages
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# add stable repo
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# install
sudo yum install docker-ce
```

## Permission

Add user to `docker` group
```
sudo usermod -aG docker $(whoami)
```

## Verify

```
docker run hello-world
```

# Docker in Windows and MacOS

There is no kernel support for container in Windows and MacOS so Docker has to run a Linux VM to host the containers. That makes Docker heavy and slow.

# Basic Command

```
# pull a box
docker pull busybox

# run a box
docker run busybox

# list container
docker ps -a

# run container command line
docker run -it busybox sh

# run container with port mapping between container and host
docker run -p 8888:80 busybox

# list port
docker port busybox

# stop
docker stop id

# delete container
docker rm container-id

# stats
docker stats

# delete all existed container
docker rm $(docker ps -a -q -f status=exited)
docker rmi
```

# Dockerfile
A Dockerfile is a simple text-file that contains a list of commands that the Docker client calls while creating an image.

## Sample
```
# base image
FROM python:3-onbuild

# specify the port number the container should expose
EXPOSE 5000

# run the application
CMD ["python", "./app.py"]
```

**Expose port**: bind container ports to the host. If the host ports are not specified, docker will bind container ports to random host ports.

## Run

```
# Build image
docker build -t name/tag

# Run
docker run name/tag
```

# Docker Compose

> Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

More [here](docs/docker-compose.md)

# References

* https://docker-curriculum.com/
