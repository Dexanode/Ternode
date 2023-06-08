
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

API: 
RPC: 
GRPC: 

## Minimum Requirements 
- 4 or more physical CPU cores
- At least 500GB of SSD disk storage
- At least 16GB of memory (RAM)
- At least 120mbps network bandwidth

## Update Package

# Manual Install Node Guide

### Set vars and port
```
MONIKER=<NAME_MONIKER>
```
Change `NAME_MONIKER` to your moniker
```
echo export MONIKER=${MONIKER} >> $HOME/.bash_profile
source ~/.bash_profile
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
empowerd init "$NODE_MONIKER" --chain-id circulus-1
```

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

sed -i 's|^pruning *=.*|pruning = "custom"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^pruning-keep-recent  *=.*|pruning-keep-recent = "100"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^pruning-interval *=.*|pruning-interval = "10"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^snapshot-interval *=.*|snapshot-interval = 0|g' $HOME/.empowerchain/config/app.toml

sed -i 's|^minimum-gas-prices *=.*|minimum-gas-prices = "0.001umpwr"|g' $HOME/.empowerchain/config/app.toml
sed -i 's|^prometheus *=.*|prometheus = true|' $HOME/.empowerchain/config/config.toml
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
--moniker="$NODE_MONIKER" \
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

## Usefull commands


### Get PEERS

```
echo $(empowerd tendermint show-node-id)'@'$(curl -s ifconfig.me)':'$(cat $HOME/.empowerchain/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//') 
```

### Service management
Check logs
```
journalctl -fu empowerd -o cat
```

Start service
```
sudo systemctl start empowerd
```

Stop service
```
sudo systemctl stop empowerd
```

Restart service
```
sudo systemctl restart empowerd
```

### Node info
Synchronization info
```
empowerd status 2>&1 | jq .SyncInfo
```

Validator info
```
empowerd status 2>&1 | jq .ValidatorInfo
```

Node info
```
empowerd status 2>&1 | jq .NodeInfo
```

Show node id
```
empowerd tendermint show-node-id
```

### Wallet operations
List of wallets
```
empowerd keys list
```

Recover wallet
```
empowerd keys add wallet --recover
```

Delete wallet
```
empowerd keys delete wallet
```

Get wallet balance
```
empowerd query bank balances <address>
```

Transfer funds
```
empowerd tx bank send <FROM ADDRESS> <TO_planq_WALLET_ADDRESS> 10000000aplanq
```

### Voting
```
empowerd tx gov vote 1 yes --from wallet --chain-id=circulus-1
```

### Staking, Delegation and Rewards
Delegate stake
```
empowerd tx staking delegate $(empowerd keys show wallet --bech val -a) 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

Redelegate stake from validator to another validator
```
empowerd tx staking delegate YOUR_TO_VALOPER_ADDRESS 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

Withdraw all rewards
```
empowerd tx distribution withdraw-all-rewards --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

Withdraw rewards with commision
```
empowerd tx distribution withdraw-rewards $(empowerd keys show wallet --bech val -a) --commission --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

Send to another Wallet Address

```
empowerd tx bank send wallet YOUR_TO_WALLET_ADDRESS 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y 
```

### Validator management
Edit validator
```
empowerd tx staking edit-validator \
  --moniker=$MONIKER \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=circulus-1 \
  --from=wallet
```

Unjail validator
```
empowerd tx slashing unjail \
  --broadcast-mode=block \
  --from=wallet \
  --chain-id=circulus-1 \
  --gas=auto
```

### Delete node
```
sudo systemctl stop empowerd && sudo systemctl disable empowerd && sudo rm /etc/systemd/system/empowerd.service && sudo systemctl daemon-reload && rm -rf $HOME/.empowerchain  && sudo rm -rf $(which empowerd) 
```

