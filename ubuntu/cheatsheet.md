# Ubuntu commands cheatsheet

| Purpose                                                         | Command                                                                                        | More info                                                                                                                                  |
|-----------------------------------------------------------------|------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------|
| List all users                                                  | `cut -d: -f1 /etc/passwd`                                                                      |                                                                                                                                            |
| List all groups                                                 | `cat /etc/group`                                                                               |                                                                                                                                            |
| Check groups of user                                            | `groups <username>`                                                                            |                                                                                                                                            |
| Create group                                                    | `addgroup [-r or --system] [-g or --gid GID] <groupname>`                                      | `GID` is Group ID, an unique positive number. `-r or --system` create system group                                                         |
| Create user                                                     | `adduser <username>`                                                                           |                                                                                                                                            |
| Create a new user or update default new user information        | `useradd <username>`                                                                           |                                                                                                                                            |
| Add user into group                                             | `adduser <username or uid> <groupname or gid>` or `usermod -a -G <groupname> <username>`       |                                                                                                                                            |
| Delete user from group                                          | `deluser <username> <groupname>`                                                               |                                                                                                                                            |
| Add user into sudo group                                        | `adduser <username> sudo` or `usermod -aG sudo <username>`                                     |                                                                                                                                            |
| Change user's password                                          | `passwd <username>`                                                                            |                                                                                                                                            |
| Change user's login name                                        | `usermod -l <current_username> <new_username>`                                                 |                                                                                                                                            |
| Compress with `tar`                                             | `tar -czvf [--exclude=regex-path] <filename> <directory-path>`                                 | `-c`: create, `-z`: using gzip, `-v`: verbose, `-f`: specify filename, `--exclude`: exclude path. Should use extension `.tar.gz` or `.tgz` |
| Uncompress with `tar`                                           | `tar -xzvf <filename> [-C <directory-path>]`                                                   | `-x`: extract                                                                                                                              |
| Check port                                                      | `netstat [options] grep <port>`                                                                | `-n`: no foreign IP check, `-p`: show protocol, `-t`: tcp, `-u`: udp, `-l`: list                                                           |
| View crontab                                                    | `cat /etc/crontab`                                                                             | System crontab                                                                                                                             |
| Make symbolic link                                              | `ln -s <src> <dst>`                                                                            | Windows: `mklink /D /H /J <src> <dst>`                                                                                                     |
| Check IP tables                                                 | `cat /etc/sysconfig/iptables`     OR `iptables -L`                                             |                                                                                                                                            |
| Restore IP table                                                | `sudo iptables-restore < /etc/iptables/rules.v4`                                               |                                                                                                                                            |
| Save IP table                                                   | `sudo iptables-save > /etc/iptables/rules.v4`                                                  |                                                                                                                                            |
| Generate private key and cerificate RSA, PEM format             | `openssl req -newkey rsa:2048 -x509 -days 3650 -keyout ved_pri.pem -out cert.cer -new -nodes ` |                                                                                                                                            |
| Generate private key and **request** cerificate RSA, PEM format | `openssl req -newkey rsa:2048 -x509 -days 3650 -keyout ved_pri.pem -out cert.cer`              |                                                                                                                                            |
| Check package available versions                                | `apt-cache policy <package_name>`                                                              |                                                                                                                                            |
| SSH key print openSSH public key to PEM format                  | `ssh-keygen -f path_to_pub_file -e -m pem`                                                     |                                                                                                                                            |
| Change hostname                                                 | Edit file `/etc/hostname` and Edit `127.0.0.1 <hostname>` in `/etc/hosts`                      | Can do either reload network or reboot machine                                                                                             |
| Check version of SSL/TLS of a server                            | `openssl ciphers -v | awk '{print $2}' | sort | uniq`                                          |                                                                                                                                            |


# Make process still runs even close terminal

`nohup` is defined by POSIX while `disown` is not. This means that while many shells (e.g. `bash`, `zsh`, `ksh`) have it, others (for example `tcsh`, `csh`, `dash` and `sh`) won't have it.

`nohup` will already disown the process.

`disown` can be used _after_ a command has been launched while `nohup` must be used _before_.

## Disown then background

1. Press `Ctrl` + `Z`, take a look at the number of the process
2. `disown -h %<number>`
3. `bg 1`

For example

```
$ sudo tailf /var/log/my_log1.log
# Ctrl + Z
[1]+  Stopped                 sudo tailf /var/log/my_log1.log
$ disown -h %1
$ bg 1
$ sudo tailf /var/log/my_log2.log
# Ctrl + Z
[2]+  Stopped                 sudo tailf /var/log/my_log2.log
$ disown -h %2
$ bg 2
```

## Nohup

`nohup <command> &`

# Optimized server

## Open files limit

Most OS can change the open-files limit. Example:

```
$ ulimit -n 65536
```
To permanently set the soft and hard values _for all users of the system_ to allow for up to 65536 open files.
Edit `/etc/security/limits.conf` and append the following two lines:

```
*       soft    nofile  65535
*       hard    nofile  65535
```
Save file. Start a new session so that the limits take effect (Logout -> Login).

## More ports for testing

```
sudo sysctl -w net.ipv4.ip_local_port_range="1025 65535"
```

## Increase the maximum number of possible open file descriptors:

```
echo 300000 | sudo tee /proc/sys/fs/nr_open
echo 300000 | sudo tee /proc/sys/fs/file-max
```

## Kernel and Network Tuning
Edit `/etc/sysctl.conf`

```
net.ipv4.tcp_max_syn_backlog = 40000
net.core.somaxconn = 40000
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.ipv4.tcp_sack = 1
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_fin_timeout = 15
net.ipv4.tcp_keepalive_intvl = 30
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_moderate_rcvbuf = 1
net.core.rmem_max = 134217728
net.core.wmem_max = 134217728
net.ipv4.tcp_mem  = 134217728 134217728 134217728
net.ipv4.tcp_rmem = 4096 277750 134217728
net.ipv4.tcp_wmem = 4096 277750 134217728
net.core.netdev_max_backlog = 300000
```

# Add user to sudo

`adduser <username> sudo`

or

`usermod -aG sudo <username>`

or

```
visudo

# Add this line
<username> ALL=(ALL) [NOPASSWD:]ALL
```

# Changing shell

`chsh -s /bin/bash <username>`

If not success, use the following command

`usermod -s /bin/bash <username>`

# Timezones

## Ubuntu 16

View current timezone `timedatectl`

View list timezones `timedatectl list-timezones`

Set timezone `timedatectl set-timezone Asia/Ho_Chi_Minh`