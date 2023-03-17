FROM --platform=amd64 ubuntu:jammy

LABEL maintainer="Giã Dương Đức Minh"
LABEL email="giaduongducminh@gmail.com"

RUN apt-get update \
    && apt-get install -y wget git

RUN wget https://dl.google.com/go/go1.19.4.linux-amd64.tar.gz \
    && rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz \
    && echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile

