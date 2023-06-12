#!/bin/bash
#
#

echo -e "\033[1;33m"
echo " ██████  ███████ ██   ██  █████  ███    ██  ██████  ██████  ███████ ";
echo " ██   ██ ██       ██ ██  ██   ██ ████   ██ ██    ██ ██   ██ ██      ";
echo " ██   ██ █████     ███   ███████ ██ ██  ██ ██    ██ ██   ██ █████   ";
echo " ██   ██ ██       ██ ██  ██   ██ ██  ██ ██ ██    ██ ██   ██ ██      ";
echo " ██████  ███████ ██   ██ ██   ██ ██   ████  ██████  ██████  ███████ ";
echo "-*-* Automatic Installer for Planq Network | Chain ID : planq_7070-2 -*-*";
echo -e "\e[0m"

sleep 1

# Variable
SOURCE=planq
WALLET=wallet
BINARY=planqd
FOLDER=.planqd
CHAIN=planq_7070-2
VERSION=v1.0.5
DENOM=aplanq
COSMOVISOR=cosmovisor
REPO=https://github.com/planq-network/planq
GENESIS=https://snap.nodexcapital.com/planq/genesis.json
ADDRBOOK=https://snap.nodexcapital.com/planq/addrbook.json
PORT=102


# Set Vars
if [ ! $NODENAME ]; then
	read -p "Enter Moniker Name : " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi

echo "Verify the information below before proceeding with the installation!"
echo ""
echo -e "Port		: \e[1m\e[1;33m$PORT\e[0m"
echo -e "Moniker        : \e[1m\e[1;33m$NODENAME\e[0m"
echo -e "Wallet Name    : \e[1m\e[1;33m$WALLET\e[0m"
echo -e "Chain Name     : \e[1m\e[1;33m$CHAIN\e[0m"
echo -e "Node Version   : \e[1m\e[1;33m$VERSION\e[0m"
echo -e "Node Folder    : \e[1m\e[1;33m$FOLDER\e[0m"
echo -e "Denomx	        : \e[1m\e[1;33m$DENOM\e[0m"
echo -e "Node Engine    : \e[1m\e[1;33m$COSMOVISOR\e[0m"
echo ""

# read -p "Is the above information correct? (y/n) " choice
# if [[ $choice == [Yy]* ]]; then

# echo "export SOURCE=${SOURCE}" >> $HOME/.bash_profile
# echo "export WALLET=${WALLET}" >> $HOME/.bash_profile
# echo "export BINARY=${BINARY}" >> $HOME/.bash_profile
# echo "export CHAIN=${CHAIN}" >> $HOME/.bash_profile
# echo "export FOLDER=${FOLDER}" >> $HOME/.bash_profile
# echo "export DENOM=${DENOM}" >> $HOME/.bash_profile
# echo "export VERSION=${VERSION}" >> $HOME/.bash_profile
# echo "export REPO=${REPO}" >> $HOME/.bash_profile
# echo "export COSMOVISOR=${COSMOVISOR}" >> $HOME/.bash_profile
# echo "export GENESIS=${GENESIS}" >> $HOME/.bash_profile
# echo "export ADDRBOOK=${ADDRBOOK}" >> $HOME/.bash_profile
# echo "export PORT=${PORT}" >> $HOME/.bash_profile
# source $HOME/.bash_profile

# else
#     echo "Installation cancelled!"
#     exit 1
# fi
# sleep 1

# Package
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade


# Install GO
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.19.7.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)

# Get mainnet version of planq
cd $HOME
rm -rf $SOURCE
git clone $REPO
cd $SOURCE
git checkout $VERSION
make build
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@v1.4.0

# Prepare binaries for Cosmovisor
mkdir -p $HOME/$FOLDER/$COSMOVISOR/genesis/bin
mv build/$BINARY $HOME/$FOLDER/$COSMOVISOR/genesis/bin/
rm -rf build

# Create application symlinks
ln -s $HOME/$FOLDER/$COSMOVISOR/genesis $HOME/$FOLDER/$COSMOVISOR/current
sudo ln -s $HOME/$FOLDER/$COSMOVISOR/current/bin/$BINARY /usr/local/bin/$BINARY

# Init generation
$BINARY config chain-id $CHAIN
$BINARY config keyring-backend file
$BINARY config node tcp://localhost:${PORT}57
$BINARY init $NODENAME --chain-id $CHAIN

# Set peers and seeds
PEERS="$(curl -sS https://rpc.planq.nodexcapital.com/net_info | jq -r '.result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"' | awk -F ':' '{print $1":"$(NF)}' | sed -z 's|\n|,|g;s|.$||')"
SEEDS=""
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$FOLDER/config/config.toml
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS > $HOME/$FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$FOLDER/config/addrbook.json

# EVM Set Port 
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${PORT}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${PORT}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"tcp://127.0.0.1:${PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${PORT}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \"127.0.0.1:${PORT}60\"%" $HOME/$FOLDER/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://127.0.0.1:${PORT}17\"%; s%^address = \":8080\"%address = \"127.0.0.1:${PORT}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"127.0.0.1:${PORT}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"127.0.0.1:${PORT}91\"%; s%^address = \"0.0.0.0:8545\"%address = \"127.0.0.1:${PORT}45\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"127.0.0.1:${PORT}46\"%" $HOME/$FOLDER/config/app.toml

# Set Config Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="19"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/$FOLDER/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/$FOLDER/config/app.toml

# Set Config prometheus
sed -i -e "s/prometheus = false/prometheus = true/" $HOME/$FOLDER/config/config.toml

# Set minimum gas price
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0085$DENOM\"/" $HOME/$FOLDER/config/app.toml

# Enable snapshots
sed -i -e "s/^snapshot-interval *=.*/snapshot-interval = \"2000\"/" $HOME/$FOLDER/config/app.toml
$BINARY tendermint unsafe-reset-all --home $HOME/$FOLDER --keep-addr-book
curl -L https://snap.nodexcapital.com/planq/planq-latest.tar.lz4 | tar -Ilz4 -xf - -C $HOME/$FOLDER
[[ -f $HOME/$FOLDER/data/upgrade-info.json ]] && cp $HOME/$FOLDER/data/upgrade-info.json $HOME/$FOLDER/cosmovisor/genesis/upgrade-info.json

# Create Service
sudo tee /etc/systemd/system/$BINARY.service > /dev/null << EOF
[Unit]
Description=$BINARY
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
Environment="DAEMON_HOME=$HOME/$FOLDER"
Environment="DAEMON_NAME=$BINARY"
Environment="UNSAFE_SKIP_BACKUP=true"

[Install]
WantedBy=multi-user.target
EOF

# Register And Start Service
sudo systemctl daemon-reload
sudo systemctl enable $BINARY
sudo systemctl start $BINARY

echo -e "\033[0;33m-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\033[0m"
echo -e "\033[0;33mFINISH\033[0m"
echo ""
echo -e "Check Binary Status 	 : \033[1m\0;33m[34msystemctl status $BINARY\033[0m"
echo -e "Check Logs		 : \033[1m\0;33m[34mjournalctl -fu $BINARY -o cat\033[0m"
echo -e "CHECK Sync Info	 : \033[1m\0;33m[34mcurl -s localhost:${PORT}57/status | jq .result.sync_info\033[0m"
echo -e "\033[0;33m-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\033[0m"

# End
