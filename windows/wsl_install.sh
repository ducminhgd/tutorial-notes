# this file is updated on 2025-08-06

# Update OS
apt-get update
apt-get -y install zsh git gcc make software-properties-common

# Install Oh-My-Zsh and setup
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## Spaceship prompt
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Install Python
add-apt-repository ppa:deadsnakes/ppa -y
apt-get update
apt-get install python3.14 python3-pip -y
pip install -U pip uv --break-system-packages

# Install Go
sudo apt-get install -y bison
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)\
gvm install go1.24.5 -B
gvm use go1.24.5 --default
mkdir -p ~/go/src/github/ducminhgd
