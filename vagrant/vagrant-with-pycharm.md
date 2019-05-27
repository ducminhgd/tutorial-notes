# Vagrant with PyCharm

This tutorial may be applied for other IDEs of JetBrains.

Using:
- PyCharm
- Ubuntu OS for guest

## Create Virtual Machine with Vagrant

### Storging directory

 Create directory to create Virtual Machine, it may be `D:/data/vagrant/dev-vm/` on Windows or  `/data/vagrant/dev-vm` on Linux. Consider it is `dev-vm` for short. Please note that there may have `dev-vm-01`, `dev-vm-02` for other machines.

### Init Virtual Machine from source

Source: [Bento Ubuntu 14.04](https://atlas.hashicorp.com/bento/boxes/ubuntu-14.04)

```
cd dev-vm
vagrant init bento/ubuntu-14.04;

# Start virtual machine, default virtual box
# vagrant up --provider virtualbox
vagrant up
```

Edit `VagrantFile`, most of overrided configurations should be added or edited below `Vagrant.configure("2") do |config|`

1. Set static IP for host-only

```
# Create a private network, which allows host-only access to the machine
# using a specific IP.
config.vm.network "private_network", ip: "192.168.33.2"
```

2. Set public network, so that guest machine can connect to WAN.

```
# Create a public network, which generally matched to bridged network.
# Bridged networks make the machine appear as another physical device on
# your network.
config.vm.network "public_network"
```

3. SSH to guest machine `vagrant ssh` or `ssh vagrant@192.168.33.2`, password default is `vagrant`

4. Mapping folders. By default, all data in `dev-vm` of _host_ will be mapped to `vagrant` of _guest_, you can add more files or folders

```
# config.vm.synced_folder <host/folders>, <guest/folders>
config.vm.synced_folder "~/data/projects", "/projects"
```

## Python & PyCharm

### Creating virtualenv on guest machine

```
sudo apt-get update
sudo apt-get instal python-pip
sudo pip install virtualenv
cd /data/projects/my_project
virtualenv .venv -p python3.6 --always-copy
```

Please remember `--always-copy`!

### Adding Interpreter to PyCharm

1. **Settings** > **Project Interpreter**.
2. Click on the gear icon, choose **Add remote**
3. Choose checkbox **Vagrant**, point **Vagrant instance folder** (should be `path/to/dev-vm`) and point **Python interpreter path** to virtualenv's interpreter of guest machine (for e.g. `/data/projects/my_project/.venv/bin/python`)

### Run configuration

1. Path mapping: 

| Host machine      | Guest machine |
|-------------------|---------------|
| `~/data/projects` | `/projects`   |

2. If you are using Django (or something like this), please edit `127.0.0.1` to `0.0.0.0` for public. For e.g. `/data/projects/my_project/.venv/bin/python path/to/project/manage.py runserver 0.0.0.0:8000`

### Adding Vagrant VM for Project

In PyCharm, choose `File` -> `Settings` (`Ctrl + Alt + A`), choose `Vagrant` under `Tools` section. For `Instance folder`, choose the directory that the `VagrantFile` stored in.