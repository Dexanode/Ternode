
# Guide Intsallation Node Validator Empowerchain

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
  
  
<a href="https://0xdexa.com" target="_blank">Visit my Website</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/244278045-aa939243-febb-4f46-9014-7d85b59423d9.jpg">
</p>


# Official Links
### [Official Document](https://docs.empowerchain.io/validators/validator-setup)
### [Empowerchain Official Discord](https://discord.gg/bduXKsu3uk)

# Explorer
### [Explorer]()

# Public Endpoint

API: https://api-empower.dexanode.site

RPC: https://rpc-empower.dexanode.site

GRPC: https://grpc-empower.dexanode.site

# PORT

USE PORT = 12

## Minimum Requirements 
- 4 or more physical CPU cores
- At least 500GB of SSD disk storage
- At least 16GB of memory (RAM)
- At least 120mbps network bandwidth

# Automatic Install 

```
wget -O empower.sh https://raw.githubusercontent.com/Dexanode/Ternode/main/empowerchain/empower.sh && chmod +x empower.sh && ./empower.sh
```

# Manual Install Node Guide

### Set PORT
```
echo "export EMPOWER_PORT="12" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Update Packages and Depencies

```
sudo apt update
sudo apt install -y curl git jq lz4 build-essential unzip

bash <(curl -s "https://raw.githubusercontent.com/nodejumper-org/cosmos-scripts/master/utils/go_install.sh")
source .bash_profile
```

### Install GO
```
cd $HOME
! [ -x "$(command -v go)" ] && {
VER="1.20.3"
wget "https://golang.org/dl/go$VER.linux-amd64.tar.gz"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "go$VER.linux-amd64.tar.gz"
rm "go$VER.linux-amd64.tar.gz"
[ ! -f ~/.bash_profile ] && touch ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
source $HOME/.bash_profile
}
[ ! -d ~/go/bin ] && mkdir -p ~/go/bin
```

### Download binaries
```
cd || return
rm -rf empowerchain
git clone https://github.com/EmpowerPlastic/empowerchain
cd empowerchain/chain || return
git checkout v1.0.0-rc1
make install
empowerd version # 1.0.0-rc1
```

### Initialize

```bash
empowerd config keyring-backend test
empowerd config chain-id circulus-1
empowerd init "MONIKER" --chain-id circulus-1
```
change "MONIKER" to your MONIKER (Name Validator)


### Genenis

```bash
curl -s https://raw.githubusercontent.com/EmpowerPlastic/empowerchain/main/testnets/circulus-1/genesis.json > $HOME/.empowerchain/config/genesis.json
curl -s https://snapshots2-testnet.nodejumper.io/empower-testnet/addrbook.json > $HOME/.empowerchain/config/addrbook.json
```

### Seed 
  
```bash
SEEDS="258f523c96efde50d5fe0a9faeea8a3e83be22ca@seed.circulus-1.empower.aviaone.com:20272,d6a7cd9fa2bafc0087cb606de1d6d71216695c25@51.159.161.174:26656,babc3f3f7804933265ec9c40ad94f4da8e9e0017@testnet-seed.rhinostake.com:17456"
PEERS=""
sed -i 's|^seeds *=.*|seeds = "'$SEEDS'"|; s|^persistent_peers *=.*|persistent_peers = "'$PEERS'"|' $HOME/.empowerchain/config/config.toml
```
### Pruning
```
sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.empowerchain/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.001umpwr"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.empowerchain/config/config.toml
```

### Set Custom Port

Custom PORT on `app.toml`
```
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${EMPOWER_PORT}317\"%;
s%^address = \":8080\"%address = \":${EMPOWER_PORT}080\"%;
s%^address = \"localhost:9090\"%address = \"0.0.0.0:${EMPOWER_PORT}090\"%; 
s%^address = \"localhost:9091\"%address = \"0.0.0.0:${EMPOWER_PORT}091\"%; 
s%^address = \"localhost:8545\"%address = \"0.0.0.0:${EMPOWER_PORT}545\"%; 
s%^ws-address = \"localhost:8546\"%ws-address = \"0.0.0.0:${EMPOWER_PORT}546\"%" $HOME/.empowerchain/config/app.toml
```

Custom PORT on `config.toml`
```
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${EMPOWER_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${EMPOWER_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${EMPOWER_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${EMPOWER_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${EMPOWER_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${EMPOWER_PORT}660\"%" $HOME/.empowerchain/config/config.toml
```

### Create Systemd

```
sudo tee /etc/systemd/system/empowerd.service > /dev/null << EOF
[Unit]
Description=Empower Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which empowerd) start
Restart=on-failure
RestartSec=10
LimitNOFILE=10000
[Install]
WantedBy=multi-user.target
EOF
```

```
empowerd tendermint unsafe-reset-all --home $HOME/.empowerchain --keep-addr-book
```

### Snapshot (By Node Jumper)
```
SNAP_NAME=$(curl -s https://snapshots2-testnet.nodejumper.io/empower-testnet/info.json | jq -r .fileName)
curl "https://snapshots2-testnet.nodejumper.io/empower-testnet/${SNAP_NAME}" | lz4 -dc - | tar -xf - -C "$HOME/.empowerchain"
```

### Start Node

```
sudo systemctl daemon-reload
sudo systemctl enable empowerd
sudo systemctl start empowerd

sudo journalctl -u empowerd -f --no-hostname -o cat
```

### Create wallet
To create new wallet use 
```
empowerd keys add wallet
```
Change `wallet` to your wallet name

To recover existing keys use 
```
empowerd keys add wallet --recover
```
Change `wallet` to your wallet name

To see current keys 
```
empowerd keys list
```


### Create validator
After your node is synced, create validator

```
empowerd tx staking create-validator \
--amount=10000000umpwr \
--pubkey=$(empowerd tendermint show-validator) \
--moniker="MONIKER" \
--website="CHANGE_TO_YOUR_WEBSITE" \
--identity="KEYBASE" \
--details="YOUR_DETAILS"\
--chain-id=circulus-1 \
--commission-rate=0.1 \
--commission-max-rate=0.2 \
--commission-max-change-rate=0.05 \
--min-self-delegation=1 \
--fees=10000umpwr \
--from=wallet \
-y
```
