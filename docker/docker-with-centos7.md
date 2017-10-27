Update packages `sudo yum check-update`

Download and install docker `curl -fsSL https://get.docker.com/ | sh`

Start docker: `sudo systemctl start docker`

Verify status if docker starts or not `sudo systemctl status docker`

Make sure it starts at every server reboot `sudo systemctl enable docker`

Add user into current group (which may have sudo permission): `sudo usermod -aG docker $(whoami)`