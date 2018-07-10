# Installation Guide

OS: Ubuntu 16.04
Go: 1.10

## Install Go 1.10

Most of these commands should be run with user root or sudo users.

```shell
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
```

Add `/usr/local/go/bin` into `PATH` by update file `/etc/environment` then run command to reload environemt variables

```shell
source /etc/environment
```

Check result

```shell
$ go version
go version go1.10.3 linux/amd64
```

## Install Go dependency management tool

### DEP

GitHub URL: https://github.com/golang/dep

```shell
sudo curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sudo sh
```

## Run, debug Go with VSCode

1. Install VS Code's Extenstion *Go* of *Microsoft*
1. Run command in terminal `go get -u github.com/derekparker/delve/cmd/dlv` with Administrator permission (Windows) or sudo permission (Linux)