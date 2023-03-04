
# Guide Intsallation Node Validator Kyve Network Kaon Testnet

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/222917214-e3b71a57-fff2-49d7-9219-38222085a18e.png">
</p>


# Official Links
### [Official Document](https://github.com/KYVENetwork/networks/tree/main/kaon-1)
### [Planq Official Discord](https://discord.gg/kyve)

# Explorer
### [Explorer](https://explorer.kaon.kyve.network/kaon)

## Minimum Requirements 
- 4 or more physical CPU cores
- At least 500GB of SSD disk storage
- At least 16GB of memory (RAM)
- At least 120mbps network bandwidth


```bash
sudo apt update

sudo apt-get install git curl build-essential make jq gcc snapd chrony lz4 tmux unzip bc -y
```

### Install GO
```bash
rm -rf $HOME/go
rm -rf /usr/local/go
cd ~
curl https://dl.google.com/go/go1.19.4.linux-amd64.tar.gz | sudo tar -C/usr/local -zxvf -
cat <<'EOF' >>$HOME/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF
source $HOME/.profile
go version
```

### Install Node
```bash
cd $HOME

wget https://files.kyve.network/chain/v1.0.0-rc0/kyved_linux_amd64.tar.gz

tar -xvzf kyved_linux_amd64.tar.gz

chmod +x kyved

sudo mv kyved /usr/local/go/bin/

rm kyved_linux_amd64.tar.gz
```

### Update Peers

```bash
PEERS="96dcb3c72e9d60148912be2a466fc3e3308a847b@51.222.248.196:26656,ff10bd7294e3d744b351d65be49fa33ca3578b9a@144.76.176.154:13656,78d76da232b5a9a5648baa20b7bd95d7c7b9d249@142.93.161.118:26656,f796a61306ccd1f446ba052826ae420a8279c2da@173.212.232.24:26656,31262ceb4dc9fbbb9a604a4c200b7442a734cda1@65.108.54.91:26656,b2cd108d5dbf9bb67943bc1adb9a33f39725daae@65.109.8.151:26656"

### Initialize Node

Replace Moniker to Your Node Name
```bash
kyved init Moniker --chain-id=kaon-1
```

### Download Genesis File

```bash
curl https://ss-t.kyve.nodestake.top/genesis.json > $HOME/.kyve/config/genesis.json 
```

### Download Addrbook

```bash
curl https://ss-t.kyve.nodestake.top/Addrbook.json > $HOME/.kyve/config/Addrbook.json

```


### Create services
```bash
sudo tee /etc/systemd/system/kyved.service > /dev/null <<EOF
[Unit]
Description=kyved Daemon
After=network-online.target
[Service]
User=$USER
ExecStart=$(which kyved) start
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```

sudo systemctl daemon-reload
sudo systemctl enable kyved

# Launch Node

``` bash
sudo systemctl restart kyved
journalctl -u kyved -f

```

### Snapshot

```bash
sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1false|" $HOME/.kyved/config/config.toml

sudo systemctl stop kyved

rm -rf $HOME/.kyved/data

kyved tendermint unsafe-reset-all --home $HOME/.kyved/

kyved unsafe-reset-all --home $HOME/.kyved/

SNAP_NAME=$(curl -s https://ss-t.kyve.nodestake.top/ | egrep -o ">20.*\.tar.lz4" | tr -d ">")

curl -o - -L https://ss-t.kyve.nodestake.top/${SNAP_NAME}  | lz4 -c -d - | tar -x -C $HOME/.kyved

sudo systemctl restart kyved

journalctl -f -u kyved
```


### Create wallet, Recomended use wallet from winner kyve testnet

To create new wallet use 
```
kyved keys add wallet
```
Change `wallet` to your wallet name

To recover existing keys use 
```
kyved keys add wallet --recover
```
Change `wallet` to your wallet name

To see current keys 
```
kyved keys list

```

### Create validator
After your node is synced, create validator

To check if your node is synced simply run
`curl http://localhost:14657/status sync_info "catching_up": false`

Creating validator with `10 Planq` change the value as you like

```
kyved tx staking create-validator \
  --amount 10000000000000000000aplanq \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1000000" \
  --pubkey $(kyved tendermint show-validator) \
  --moniker $MONIKER \
  --chain-id kaon-1 \
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
journalctl -fu kyved -o cat
```

Start service
```
sudo systemctl start kyved
```

Stop service
```
sudo systemctl stop kyved
```

Restart service
```
sudo systemctl restart kyved
```

### Node info
Synchronization info
```
kyved status 2>&1 | jq .SyncInfo
```

Validator info
```
kyved status 2>&1 | jq .ValidatorInfo
```

Node info
```
kyved status 2>&1 | jq .NodeInfo
```

Show node id
```
kyved tendermint show-node-id
```

### Wallet operations
List of wallets
```
kyved keys list
```

Recover wallet
```
kyved keys add wallet --recover
```

Delete wallet
```
kyved keys delete wallet
```

Get wallet balance
```
kyved query bank balances <address>
```

Transfer funds
```
kyved tx bank send <FROM ADDRESS> <TO_planq_WALLET_ADDRESS> 10000000aplanq
```

### Voting
```
kyved tx gov vote 1 yes --from wallet --chain-id=kaon-1
```

### Staking, Delegation and Rewards
Delegate stake
```
kyved tx staking delegate <planq valoper> 10000000aplanq --from=wallet --chain-id=kaon-1 --gas=auto
```

Redelegate stake from validator to another validator
```
kyved tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000aplanq --from=wallet --chain-id=kaon-1 --gas=auto
```

Withdraw all rewards
```
kyved tx distribution withdraw-all-rewards --from=wallet --chain-id=kaon-1 --gas=auto
```

Withdraw rewards with commision
```
kyved tx distribution withdraw-rewards <planq valoper> --from=wallet --commission --chain-id=kaon-1
```

### Validator management
Edit validator
```
kyved tx staking edit-validator \
  --moniker=$MONIKER \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=kaon-1 \
  --from=wallet
```

Unjail validator
```
kyved tx slashing unjail \
  --broadcast-mode=block \
  --from=wallet \
  --chain-id=kaon-1 \
  --gas=auto
```

### Delete node
```
sudo systemctl stop kyved && \
sudo systemctl disable kyved && \
rm /etc/systemd/system/kyved.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .kyved && \
rm -rf $(which kyved)
```


