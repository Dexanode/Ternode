#!/bin/sh


echo -e "\033[1;33m"
echo " ▄▀▀█▄▄   ▄▀▀█▄▄▄▄  ▄▀▀▄  ▄▀▄  ▄▀▀█▄   ▄▀▀▄ ▀▄  ▄▀▀▀▀▄   ▄▀▀█▄▄   ▄▀▀█▄▄▄▄ ";
echo "█ ▄▀   █ ▐  ▄▀   ▐ █    █   █ ▐ ▄▀ ▀▄ █  █ █ █ █      █ █ ▄▀   █ ▐  ▄▀   ▐ ";
echo "▐ █    █   █▄▄▄▄▄  ▐     ▀▄▀    █▄▄▄█ ▐  █  ▀█ █      █ ▐ █    █   █▄▄▄▄▄  ";
echo "  █    █   █    ▌       ▄▀ █   ▄▀   █   █   █  ▀▄    ▄▀   █    █   █    ▌  ";
echo " ▄▀▄▄▄▄▀  ▄▀▄▄▄▄       █  ▄▀  █   ▄▀  ▄▀   █     ▀▀▀▀    ▄▀▄▄▄▄▀  ▄▀▄▄▄▄   ";
echo "█     ▐   █    ▐     ▄▀  ▄▀   ▐   ▐   █    ▐            █     ▐   █    ▐   ";
echo "▐         ▐         █    ▐            ▐                 ▐         ▐        ";
echo -e "\e[0m"
echo -e "\033[0;34m"
echo "Discord 			: XDexa#5062                          	";
echo "Discuss Group Channel 	: Airdrop Sultan Indonesia    		";
echo "Telegram 			: @dexa555                         	";
echo "Twitter  			: @nft_week                            	";
echo -e "\e[0m"
sleep 2
echo
# Set Vars
if [ ! $NODENAME ]; then
	read -p "YOUR NODE NAME : " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi

if [ ! $WALLET ]; then
    read -p "YOUR WALLET NAME  : " WALLET
	echo "export WALLET=$WALLET" >> $HOME/.bash_profile
fi
echo "export ANONE_CHAIN_ID=anone-testnet-1" >> $HOME/.bash_profile
source $HOME/.bash_profile
echo '||================INFO===================||'
echo
echo -e "YOU NODE NAME : \e[1m\e[32m$NODENAME\e[0m"
echo -e "YOU WALLET NAME : \e[1m\e[32m$WALLET\e[0m"
echo -e "YOU CHAIN ID : \e[1m\e[32m$ANONE_CHAIN_ID\e[0m"
sleep 2
echo
# update
echo -e "\e[1m\e[31m[+] Update && Dependencies... \e[0m" && sleep 1
echo
sudo apt update && sudo apt upgrade -y
sudo apt install tzdata git ca-certificates curl build-essential libssl-dev pkg-config libclang-dev cmake jq -y --no-install-recommends
sudo wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/download/v4.23.1/yq_linux_amd64 && sudo chmod +x /usr/local/bin/yq
echo

#install rust
echo -e "\e[1m\e[31m[+] install rust... \e[0m" && sleep 1
echo
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
echo

#Download and build Sui binaries
echo -e "\e[1m\e[31m[+] Download and build Sui binaries... \e[0m" && sleep 1
echo
sudo mkdir -p /var/sui
cd $HOME && rm sui -rf
git clone https://github.com/MystenLabs/sui.git && cd sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout --track upstream/devnet
cargo build --release -p sui-node
sudo mv ~/sui/target/release/sui-node /usr/local/bin/
echo

#Set configuration
echo -e "\e[1m\e[31m[+] Set configuration... \e[0m" && sleep 1
wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
sudo cp crates/sui-config/data/fullnode-template.yaml /var/sui/fullnode.yaml
sudo yq e -i '.db-path="/var/sui/db"' /var/sui/fullnode.yaml \
&& yq e -i '.genesis.genesis-file-location="/var/sui/genesis.blob"' /var/sui/fullnode.yaml \
&& yq e -i '.metrics-address="0.0.0.0:9184"' /var/sui/fullnode.yaml \
&& yq e -i '.json-rpc-address="0.0.0.0:9000"' /var/sui/fullnode.yaml
echo

#Set configuration
echo "[Unit]
Description=Sui Node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/sui-node --config-path /var/sui/fullnode.yaml
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target" > $HOME/suid.service
mv $HOME/suid.service /etc/systemd/system/

sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable suid
sudo systemctl restart suid

echo
echo 'finished installing  🚀 '
echo -e 'cek sui node status: \e[1m\e[31mservice suid status\e[0m'
echo -e "cek node logs: \e[1m\e[31mjournalctl -u suid -f -o cat\e[0m"	