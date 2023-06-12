echo -e "\033[1;34m"
echo "		   / __ \___  _  ______ _____  ____  ____/ /__    ";
echo "		  / / / / _ \| |/_/ __ `/ __ \/ __ \/ __  / _ \	  ";
echo "		 / /_/ /  __/>  </ /_/ / / / / /_/ / /_/ /  __/   ";
echo "		/_____/\___/_/|_|\__,_/_/ /_/\____/\__,_/\___/    ";
echo ">>> Automatic Installer for Planq | Chain ID : planq_7070-2 <<<";
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
PORT=10


# Set Vars
if [ ! $NODENAME ]; then
	read -p "dexanode:~# [ENTER YOUR NODE] > " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi

echo "Verify the information below before proceeding with the installation!"
echo ""
echo -e "NODE NAME      : \e[1m\e[34m$NODENAME\e[0m"
echo -e "WALLET NAME    : \e[1m\e[34m$WALLET\e[0m"
echo -e "CHAIN NAME     : \e[1m\e[34m$CHAIN\e[0m"
echo -e "NODE VERSION   : \e[1m\e[34m$VERSION\e[0m"
echo -e "NODE FOLDER    : \e[1m\e[34m$FOLDER\e[0m"
echo -e "NODE DENOM     : \e[1m\e[34m$DENOM\e[0m"
echo -e "NODE ENGINE    : \e[1m\e[34m$COSMOVISOR\e[0m"
echo -e "SOURCE CODE    : \e[1m\e[34m$REPO\e[0m"
echo -e "NODE PORT      : \e[1m\e[34m$PORT\e[0m"
echo ""

read -p "Is the above information correct? (y/n) " choice
if [[ $choice == [Yy]* ]]; then

echo "export SOURCE=${SOURCE}" >> $HOME/.bash_profile
echo "export WALLET=${WALLET}" >> $HOME/.bash_profile
echo "export BINARY=${BINARY}" >> $HOME/.bash_profile
echo "export CHAIN=${CHAIN}" >> $HOME/.bash_profile
echo "export FOLDER=${FOLDER}" >> $HOME/.bash_profile
echo "export DENOM=${DENOM}" >> $HOME/.bash_profile
echo "export VERSION=${VERSION}" >> $HOME/.bash_profile
echo "export REPO=${REPO}" >> $HOME/.bash_profile
echo "export COSMOVISOR=${COSMOVISOR}" >> $HOME/.bash_profile
echo "export GENESIS=${GENESIS}" >> $HOME/.bash_profile
echo "export ADDRBOOK=${ADDRBOOK}" >> $HOME/.bash_profile
echo "export PORT=${PORT}" >> $HOME/.bash_profile
source $HOME/.bash_profile

else
    echo "Installation cancelled!"
    exit 1
fi
sleep 1

# Package
sudo apt -q update
sudo apt -qy install curl git jq lz4 build-essential
sudo apt -qy upgrade
sudo apt install snapd -y
sudo snap install lz4

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
PEERS="b950b6b08f7a6d5c3e068fcd263802b336ffe047@18.198.182.214:26656,25da6253fc8740893277630461eb34c2e4daf545@3.76.244.30:26656,146d27829fd240e0e4672700514e9835cb6fdd98@34.212.201.1:26656,fae8cd5f04406e64484a7a8b6719eacbb861c094@44.241.103.199:26656,443f41172aafaa6c711333c621e019fde3f0ba99@5.75.144.137:26656,cfb5d3dc65e8e1d17285964655d2b47a44d35721@144.76.97.251:42656,c782ab00baf1c86261db0570307a9ecd9c5b197a@5.9.63.216:28656,38ef1bd70583c8831c3c0e07fad7e1bab56515cc@68.183.143.17:26656,307f4024107ef114dba355fe97dab44b8b45cefc@38.242.253.58:29656,86d313c22789ffa50c76b85b460f1e1412782a27@195.3.221.59:12656,a0ba3bd9616b51c26ab6ecc49a30a13d0438ab7f@65.109.94.250:28656,cec6c3c59d1bde0862d27500bf3c0ecc39b4727d@3.144.87.60:31309,0ab23bfd2924c09a0cb2166a78e65d6d0fbd172a@57.128.162.152:26656"
SEEDS="4a72671447a1ede2a136dbac70ac4523c3433c94@seeds.cros-nest.com:29656"
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$PEERS\"|" $HOME/$FOLDER/config/config.toml
sed -i -e "s|^seeds *=.*|seeds = \"$SEEDS\"|" $HOME/$FOLDER/config/config.toml

# Download genesis and addrbook
curl -Ls $GENESIS > $HOME/$FOLDER/config/genesis.json
curl -Ls $ADDRBOOK > $HOME/$FOLDER/config/addrbook.json

# Set Port
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${PORT}58\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${PORT}57\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${PORT}60\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${PORT}56\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${PORT}60\"%" $HOME/$FOLDER/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://127.0.0.1:${PORT}17\"%; s%^address = \":8080\"%address = \":${PORT}80\"%; s%^address = \"0.0.0.0:9090\"%address = \"127.0.0.1:${PORT}90\"%; s%^address = \"0.0.0.0:9091\"%address = \"127.0.0.1:${PORT}91\"%" $HOME/$FOLDER/config/app.toml

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
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0$DENOM\"/" $HOME/$FOLDER/config/app.toml

# Enable snapshots
sed -i -e "s/^snapshot-interval *=.*/snapshot-interval = \"2000\"/" $HOME/$FOLDER/config/app.toml
$BINARY tendermint unsafe-reset-all --home $HOME/$FOLDER --keep-addr-book
curl -L https://snap.nodexcapital.com/kyve/kyve-latest.tar.lz4 | lz4 -dc - | tar -xf - -C $HOME/$FOLDER
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

echo -e "\033[0;35m-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\033[0m"
echo -e "\033[0;35mINSTALLATION FINISHED\033[0m"
echo ""
echo -e "CHECK STATUS BINARY : \033[1m\033[35msystemctl status $BINARY\033[0m"
echo -e "CHECK RUNNING LOGS : \033[1m\033[35mjournalctl -fu $BINARY -o cat\033[0m"
echo -e "CHECK LOCAL STATUS : \033[1m\033[35mcurl -s localhost:${PORT}57/status | jq .result.sync_info\033[0m"
echo -e "\033[0;35m*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*\033[0m"

# End
