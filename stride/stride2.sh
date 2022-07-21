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
echo

# Set Vars
if [ ! $NODENAME ]; then
	read -p "NODENAME 👉  : " NODENAME
	echo 'export NODENAME='$NODENAME >> $HOME/.bash_profile
fi
STRIDE_PORT=16
echo "export NODENAME=$NODENAME" >> $HOME/.bash_profile
if [ ! $WALLET ]; then
	echo "export WALLET=wallet" >> $HOME/.bash_profile
fi
echo "export STRIDE_CHAIN_ID=STRIDE" >> $HOME/.bash_profile
echo "export STRIDE_PORT=${STRIDE_PORT}" >> $HOME/.bash_profile
source $HOME/.bash_profile
echo
echo '[+]================INFO===================[+]'
echo
echo -e "Node Name : \e[1m\e[32m$NODENAME\e[0m"
echo -e "Wallet Name : \e[1m\e[32m$WALLET\e[0m"
echo -e "Chain ID : \e[1m\e[32m$STRIDE_CHAIN_ID\e[0m"
sleep 2
echo
echo -e "\e[1m\e[31m[+] Update && Dependencies... \e[0m" && sleep 1
echo
sudo apt update && sudo apt upgrade -y
echo
sudo apt install curl build-essential git wget jq make gcc tmux chrony -y

# Install go
ver="1.18.2"
cd $HOME
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
rm "go$ver.linux-amd64.tar.gz"
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
source ~/.bash_profile
go version
echo
echo -e "\e[1m\e[31m[+] Download binary... \e[0m" && sleep 1
echo
#Download and build binaries
cd $HOME
git clone https://github.com/Stride-Labs/stride.git
cd stride
git checkout c53f6c562d9d3e098aab5c27303f41ee055572cb
make build
sudo cp $HOME/stride/build/strided /usr/local/bin

#config app
strided config chain-id $STRIDE_CHAIN_ID
strided config keyring-backend test
strided config node tcp://localhost:${STRIDE_PORT}657

#init 
strided init $NODENAME --chain-id $STRIDE_CHAIN_ID

#Download genesis and addrbook
wget -qO $HOME/.stride/config/genesis.json "https://raw.githubusercontent.com/Stride-Labs/testnet/main/poolparty/genesis.json"


#persistent peers
SEEDS="baee9ccc2496c2e3bebd54d369c3b788f9473be9@seedv1.poolparty.stridenet.co:26656"
peers="f1cd1d30c51ea1f1431d7da718f923f6c70ebc80@rpc2.bonded.zone:20156"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.stride/config/config.toml

#custom port
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${STRIDE_PORT}658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:${STRIDE_PORT}657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${STRIDE_PORT}060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${STRIDE_PORT}656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${STRIDE_PORT}660\"%" $HOME/.stride/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${STRIDE_PORT}317\"%; s%^address = \":8080\"%address = \":${STRIDE_PORT}080\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${STRIDE_PORT}090\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${STRIDE_PORT}091\"%" $HOME/.stride/config/app.toml

#Pruning
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.stride/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.stride/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.stride/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.stride/config/app.toml

sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0ustrd\"/" $HOME/.stride/config/app.toml

sed -i -e "s/prometheus = false/prometheus = true/" $HOME/.stride/config/config.toml

strided tendermint unsafe-reset-all --home $HOME/.stride
echo -e "\e[1m\e[31m[+] create service... \e[0m" && sleep 1
#crate serivce
sudo tee /etc/systemd/system/strided.service > /dev/null <<EOF
[Unit]
Description=stride
After=network-online.target
[Service]
User=$USER
ExecStart=$(which strided) start --home $HOME/.stride
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable strided
sudo systemctl restart strided

sudo systemctl stop strided
strided tendermint unsafe-reset-all --home $HOME/.stride

#SEt rpc
RPC="http://rpc2.bonded.zone:20157"

#set variable
LATEST_HEIGHT=$(curl -s $RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000)); \
TRUST_HASH=$(curl -s "$RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH && sleep 2

#persistent peers
peers="f1cd1d30c51ea1f1431d7da718f923f6c70ebc80@rpc2.bonded.zone:20156"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.stride/config/config.toml

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$RPC,$RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.stride/config/config.toml

sudo systemctl restart strided

echo
echo -e "Your STRIDE node \e[32minstalled and works\e[39m!"
echo -e "status sync: \e[1m\e[32mstrided status 2>&1 | jq .SyncInfo\e[0m"
echo -e 'logs: \e[1m\e[32msudo journalctl -u strided -f --no-hostname -o cat\e[0m'
