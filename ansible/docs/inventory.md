# Overview

Inventory file is used to list Ansible's hosts, groups, host's variables.

Default inventory file is `/etc/ansible/hosts`. Specify different inventory file by using `-i <path>` option on the command.

Inventory file can be written in different formats (YAML, ini, etc). The following is in `ini` format.

# Host and groups

Define host and groups

```
[server-1]
192.168.1.1

[server-2]
192.168.1.2

[group-1]
server-1
192.168.1.3

#group of group
[bigboss:children]
group-1

```

# Host variables

```
[server-1]
192.168.1.1

[server-1:vars]
# ssh with user
ansible_user=root
# ssh to different port
ansible_port=2222
# use python 3
ansible_python_interpreter=/usr/bin/python3
```

# Groups variables

Similar to host variables

# Ansible command

```
ansible all -m ping

ansible server-1 -m ping

ansible server-1 -m ping -i /path/to/server-1/inventory/file
```
