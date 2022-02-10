# Install SSH Server

`sudo apt-get install openssh-server`

# Allow a user connect via SSH

1. Edit `sshdconfig` file: `nano /etc/ssh/sshd_config`  
2. Not Allow root SSH login Set `PermitRootLogin` to `No`  
3. Allow specify user: add `AllowUsers <username>`, you can skip this step if allow all users with keys
4. Login to new user `su - <username>`.  
5. Add `.ssh` directory and set permission:  
    `mkdir .ssh`  
    `chmod 700 .ssh`  
    `nano .ssh/authorized_keys`  
    Add Public key  
    `chmod 600 .ssh/authorized_keys`  
    `exit`  
6. Restart SSH `service ssh restart` 