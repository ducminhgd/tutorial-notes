# Overview

> Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application’s services. Then, with a single command, you create and start all the services from your configuration.

Services will be defined in `docker-compose.yml` file.

Documentation [here](https://docs.docker.com/compose/)

# Installation

```
sudo curl -L https://github.com/docker/compose/releases/download/1.17.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

# Sample

Build a simple Python web application using Flask and Redis with docker compose

**Dockerfile** for building Flask app

```
FROM python:3.4-alpine
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD ["python", "app.py"]
```

This tells Docker to:

* Build an image starting with the Python 3.4 image.
* Add the current directory . into the path /code in the image.
* Set the working directory to /code.
* Install the Python dependencies.
* Set the default command for the container to python app.py.

**docker-compose.yml**

```
version: '3'
services:
  web:
    build: .
    ports:
     - "5000:5000"
  redis:
    image: "redis:alpine"
```

This Compose file defines two services, web and redis. The web service:

* Uses an image that’s built from the Dockerfile in the current directory.
* Forwards the exposed port 5000 on the container to port 5000 on the host.

Build and run
```
docker-compose up

# detach container
docker-compose up -d
```

Mount host directory to container

```
version: '3'
services:
  web:
    build: .
    ports:
     - "5000:5000"
    volumes:
     - .:/code
  redis:
    image: "redis:alpine"
```

This mount current directory to `/code` dir in the container.
