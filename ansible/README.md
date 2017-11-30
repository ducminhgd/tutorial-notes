# Overview

> Ansible is an IT automation tool. It can configure systems, deploy software, and orchestrate more advanced IT tasks such as continuous deployments or zero downtime rolling updates.

Documentation [here](http://docs.ansible.com/ansible/latest/index.html)

# Installation

## Ubuntu
Current version in Ubuntu repo is 2.0.0. This version only supports python2.7. To install higher Ansible version (2.4) that support python 3.5

```
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible
```

## Python

```
pip install ansible
```

By default, Ansible requires python2.7 pre-installed in client machines. To force Ansible use python3 instead, check [here](docs/inventory.md)

# Configuration

Changes can be made and used in a configuration file which will be processed in the following order
```
* ANSIBLE_CONFIG (an environment variable)
* ansible.cfg (in the current directory)
* .ansible.cfg (in the home directory)
* /etc/ansible/ansible.cfg
```

Disable ssh key checking when host is unknown

```
# /etc/ansible/ansible.cfg

[defaults]
host_key_checking = False
```

# Quick start

Define host

```
# /etc/ansible/hosts
[host1]
192.168.1.1
```

Command

```
# Ping all hosts
ansible all -m ping

# Ping host1
ansible host1 -m ping
```

# [Inventory](docs/inventory.md)

Ansible hosts are defined in inventory files. Default file is `/etc/ansible/hosts`.

# [Playbooks](docs/playbooks.md)

Playbooks are `.yml` files that define which ansible will run on remote servers.

## [Sample](playbooks)

# Roles
Comming