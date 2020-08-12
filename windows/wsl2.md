# Install WSL 2 Dist

## Ubuntu (20.04)

```bash
apt-get update
apt-get install -y figlet fonts-powerline

echo "SET DEFAULT PYTHON 3.8"
update-alternatives --install /usr/bin/python python /usr/bin/python3.8 1
apt-get install python3-pip zsh pipenv

echo "INSTALL DEV TOOLS"
apt-get install -y redis-tools libmysqlclient-dev

echo "INSTALL OH MY ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "INSTALL DIRENV"
curl -sfL https://direnv.net/install.sh | bash
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
```
