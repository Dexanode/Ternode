
# Guide Intsallation Node Validator Planq Network Mainnet

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/215237851-8227d207-0033-4322-bd0e-4a14f43782e5.png">
</p>


# Official Links
### [Official Document](https://docs.planq.network/validators/overview.html)
### [Planq Official Discord](https://discord.gg/cwmR8jNrNp)

# Explorer
### [Explorer](https://explorer.planq.network/planq_7070-2/staking)

## Minimum Requirements 
- 4 or more physical CPU cores
- At least 500GB of SSD disk storage
- At least 16GB of memory (RAM)
- At least 120mbps network bandwidth

## Update Package

# Automatic Installation
```
wget -O planq.sh https://raw.githubusercontent.com/Dexanode/Ternode/main/planq/planq.sh && chmod +x planq.sh && ./planq.sh
```

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
sudo apt update && sudo apt upgrade -y
```

Install Depencies
```
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git make ncdu -y
```

### Install GO
```
sudo rm -rf /usr/local/go
curl -Ls https://go.dev/dl/go1.19.5.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
eval $(echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/golang.sh)
eval $(echo 'export PATH=$PATH:$HOME/go/bin' | tee -a $HOME/.profile)
```

### Download binaries
```
cd $HOME
rm -rf planq
git clone https://github.com/planq-network/planq.git
cd planq
git fetch
```
Build Binaries
```
git checkout v1.0.3
make install
```
  
### Config
```
planqd config chain-id planq_7070-2
planqd config keyring-backend file
planqd config node tcp://localhost:14657
```

### Init 
```
planqd init $MONIKER --chain-id planq_7070-2
```

### Set minimum gas price , seeds , and peers
```
SEEDS="dd2f0ceaa0b21491ecae17413b242d69916550ae@135.125.247.70:26656,0525de7e7640008d2a2e01d1a7f6456f28f3324c@51.79.142.6:26656,21432722b67540f6b366806dff295849738d7865@139.99.223.241:26656" 
PEERS=""
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.planqd/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.025aplanq\"|" $HOME/.planqd/config/app.toml
sed -i -e "s/^timeout_commit *=.*/timeout_commit = \"5s\"/" $HOME/.planqd/config/config.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 120/g' $HOME/.planqd/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 60/g' $HOME/.planqd/config/config.toml
```

### Pruning (Optional)
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.planqd/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.planqd/config/app.toml
```

### Indexer (Optional)
```
indexer="null" && \
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.planqd/config/config.toml
```

### Custom Port 
```
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:14658\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:14657\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:14060\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:14656\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \"14660\"%" $HOME/.planqd/config/config.toml
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:1417\"%; s%^address = \":8080\"%address = \":1480\"%; s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:1490\"%; s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:1491\"%; s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:1445\"%; s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:1446\"%" $HOME/.planqd/config/app.toml
```

### Create service file and start the node
```
sudo tee /etc/systemd/system/planqd.service > /dev/null <<EOF
[Unit]
Description=planqd
After=network-online.target

[Service]
User=$USER
ExecStart=$(which planqd)
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
    
sudo systemctl daemon-reload
sudo systemctl enable planqd
```
Start Planq
```
sudo systemctl restart planqd && sudo journalctl -u planqd -f -o cat
```

### Create wallet
To create new wallet use 
```
planqd keys add wallet
```
Change `wallet` to your wallet name

To recover existing keys use 
```
planqd keys add wallet --recover
```
Change `wallet` to your wallet name

To see current keys 
```
planqd keys list
```

### Snapshot
```
cp $HOME/.planqd/data/priv_validator_state.json $HOME/.planqd/priv_validator_state.json.backup
planqd tendermint unsafe-reset-all --home $HOME/.planq --keep-addr-book

SNAP_NAME=$(curl -s https://snapshot.planq.dexa.space/planq/planq-snapshot-20230128.tar.lz4 | egrep -o ">planq-testnet-1.*\.tar.lz4" | tr -d ">")
curl https://snapshot.planq.dexa.space/planq/planq-snapshot-20230127.tar.lz4${SNAP_NAME} | lz4 -dc - | tar -xf - -C $HOME/.planq

mv $HOME/.planqd/priv_validator_state.json.backup $HOME/.planqd/data/priv_validator_state.json

sudo systemctl restart planqd
sudo journalctl -u planqd -f --no-hostname -o cat

```

### Create validator
After your node is synced, create validator

To check if your node is synced simply run
`curl http://localhost:14657/status sync_info "catching_up": false`

Creating validator with `10 Planq` change the value as you like

```
planqd tx staking create-validator \
  --amount 10000000000000000000aplanq \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1000000" \
  --pubkey $(planqd tendermint show-validator) \
  --moniker $MONIKER \
  --chain-id planq_7070-2 \
  --identity=  \
  --website="" \
  --details=" " \
  --gas="1000000" \
  --gas-prices="30000000000aplanq" \
  --gas-adjustment="1.15" \
  -y
```

## Usefull commands
### Service management
Check logs
```
journalctl -fu planqd -o cat
```

Start service
```
sudo systemctl start planqd
```

Stop service
```
sudo systemctl stop planqd
```

Restart service
```
sudo systemctl restart planqd
```

### Node info
Synchronization info
```
planqd status 2>&1 | jq .SyncInfo
```

Validator info
```
planqd status 2>&1 | jq .ValidatorInfo
```

Node info
```
planqd status 2>&1 | jq .NodeInfo
```

Show node id
```
planqd tendermint show-node-id
```

### Wallet operations
List of wallets
```
planqd keys list
```

Recover wallet
```
planqd keys add wallet --recover
```

Delete wallet
```
planqd keys delete wallet
```

Get wallet balance
```
planqd query bank balances <address>
```

Transfer funds
```
planqd tx bank send <FROM ADDRESS> <TO_planq_WALLET_ADDRESS> 10000000aplanq
```

### Voting
```
planqd tx gov vote 1 yes --from wallet --chain-id=planq_7070-2
```

### Staking, Delegation and Rewards
Delegate stake
```
planqd tx staking delegate <planq valoper> 10000000aplanq --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Redelegate stake from validator to another validator
```
planqd tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000aplanq --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Withdraw all rewards
```
planqd tx distribution withdraw-all-rewards --from=wallet --chain-id=planq_7070-2 --gas=auto
```

Withdraw rewards with commision
```
planqd tx distribution withdraw-rewards <planq valoper> --from=wallet --commission --chain-id=planq_7070-2
```

### Validator management
Edit validator
```
planqd tx staking edit-validator \
  --moniker=$MONIKER \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=planq_7070-2 \
  --from=wallet
```

Unjail validator
```
planqd tx slashing unjail \
  --broadcast-mode=block \
  --from=wallet \
  --chain-id=planq_7070-2 \
  --gas=auto
```

### Delete node
```
sudo systemctl stop planqd && \
sudo systemctl disable planqd && \
rm /etc/systemd/system/planqd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .planqd && \
rm -rf $(which planqd)
```

