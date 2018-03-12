# Brieft Tutorial

1. Download docker. With Windows 10 Home, please download Docker Toolbox for Windows.

2. Install docker.

3. Create docker directory and `Dockerfile`. Sample docker file

    ```
    FROM ubuntu:16.04
    MAINTAINER ducminhgd

    ENV HOME /root
    ENV DEBIAN_FRONTEND noninteractive

    RUN apt-get update
    RUN apt-get install -y dialog apt-utils
    RUN apt-get install -y software-properties-common python-software-properties
    RUN add-apt-repository -y ppa:deadsnakes/ppa
    RUN apt-get update
    RUN apt-get install -y gcc python3.6 python3.6-dev unixodbc unixodbc-dev freetds-dev freetds-bin tdsodbc
    RUN rm -rf /usr/bin/python
    RUN ln -s /usr/bin/python3.6 /usr/bin/python
    RUN apt-get install -y python-pip
    ```

4. Build image with this syntax `docker build [OPTIONS] PATH | URL | -`, for example `docker build -t ducminhgd/ubuntu16.04-python3.6-unixodbc .`. Note that there is `.` (period) sign as current path.

5. Login image to test: `docker run -it --rm ducminhgd/ubuntu16.04-python3.6-unixodbc bash`

6. Push to Docker Hub: `docker push ducminhgd/ubuntu16.04-python3.6-unixodbc`