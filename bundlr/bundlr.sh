#!/bin/sh
echo -e "\033[0;31m"
echo " ▄▀▀▀█▀▀▄  ▄▀▀█▄▄▄▄  ▄▀▀▄▀▀▀▄  ▄▀▀▄ ▀▄  ▄▀▀▀▀▄   ▄▀▀█▄▄   ▄▀▀█▄▄▄▄ ";
echo "█    █  ▐ ▐  ▄▀   ▐ █   █   █ █  █ █ █ █      █ █ ▄▀   █ ▐  ▄▀   ▐ ";
echo "▐   █       █▄▄▄▄▄  ▐  █▀▀█▀  ▐  █  ▀█ █      █ ▐ █    █   █▄▄▄▄▄  ";
echo "   █        █    ▌   ▄▀    █    █   █  ▀▄    ▄▀   █    █   █    ▌  ";
echo " ▄▀        ▄▀▄▄▄▄   █     █   ▄▀   █     ▀▀▀▀    ▄▀▄▄▄▄▀  ▄▀▄▄▄▄   ";
echo "█          █    ▐   ▐     ▐   █    ▐            █     ▐   █    ▐   ";
echo "▐          ▐                  ▐                 ▐         ▐        ";
echo -e "\e[0m"
echo -e "\033[1;31m"
echo "Discord : XDexa#5062";
echo "Channel : Airdrop Sultan Indonesia";
echo "Telegram : @dexa555";
echo "Twitter  : @nft_week";
echo -e "\e[0m"
sleep 2

# update package
sudo apt update && sudo apt upgrade -y

sleep 1

# install docker
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

sleep 1

# install docker-compose

mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose

sudo chown $USER /var/run/docker.sock

sleep 1

# install depencies
sudo apt-get install curl wget jq libpq-dev libssl-dev \
build-essential pkg-config openssl ocl-icd-opencl-dev \
libopencl-clang-dev libgomp1 -y

sleep 1

# install npm
apt install npm -y

sleep 1

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source ~/.bashrc
nvm install 16
nvm use 16

sleep 1

# validator repository
git clone --recurse-submodules https://github.com/Bundlr-Network/validator-rust.git