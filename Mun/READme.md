
# MUN Incentiviced Testnet Phase I
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Mun](https://user-images.githubusercontent.com/65535542/194721789-b6a65d1a-fdb7-47db-b17d-d7a6f958ed32.jpg#/)

## Source Mun Testnet Incentiviced :

<p style="font-size:14px" align="left">
<a href="https://medium.com/@munblockchain/mun-public-testnet-phase-1-ignition-is-now-live-e90fba027a42#/
a" target="_blank">Source Mun Testnet Phase I</a>
</p>

## Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 160 GB SSD Storage

## Open Port
```bash
sudo ufw allow ssh
sudo ufw allow 26657
sudo ufw allow 26656
sudo ufw enable
```

### Untuk user azure open portnya di panel ya

Set Moniker
```bash
NODENAME=<YOUR_MONIKER>
```

**NOTE : YOUR_MONIKER wajib kaya gini ``x-dexa-x``**

## Save and import variable to system

```bash
echo "export NODENAME=$NODENAME" >> $HOME/.bash_profile
if [ ! $WALLET ]; then
  echo "export WALLET=wallet" >> $HOME/.bash_profile
fi
echo "export MUN_CHAIN_ID=testmun" >> $HOME/.bash_profile
source $HOME/.bash_profile
```

## Installation
### Install Dependencies

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install curl build-essential git wget jq make gcc tmux chrony -y
```

### Install Binaries
```bash
git clone https://github.com/munblockchain/mun
cd mun
sudo rm -rf ~/.mun
go mod tidy
make install
```

### Download Genenis
```bash
curl --tlsv1 https://node1.mun.money/genesis? | jq ".result.genesis" > ~/.mun/config/genesis.json
```

### Update Seed
```bash
SEEDS="9240277fca3bfa0c3b94efa60215ca10cf54f249@45.76.68.116:26656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.mun/config/config.toml
```

Kalau Seed ga work!

seed1 = "b4eeaf7ca17e5186b181885714cedc6a78d20c9b@167.99.6.48:26656"
seed2 = "6a08f2f76baed249d3e3c666aaef5884e4b1005c@167.71.0.38:26656"
seed3 = "9240277fca3bfa0c3b94efa60215ca10cf54f249@45.76.68.116:26656"


### Replace Token Format
```bash
sed -i 's/stake/utmun/g' ~/.mun/config/genesis.json
```

### Create Services
```bash
sudo tee /etc/systemd/system/mund.service > /dev/null <<EOF
[Unit]
Description=mun
After=network-online.target

[Service]
User=$USER
ExecStart=$(which mund) start --home $HOME/.mun --pruning="nothing" --rpc.laddr "tcp://0.0.0.0:26657"
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

### Register and Start Services
```bash
sudo systemctl daemon-reload
sudo systemctl enable mund
sudo systemctl restart mund && sudo journalctl -u mund -f -o cat
```

### Create Wallet

Create New Wallet
```bash
mund keys add $WALLET
```

Recover Wallet
```bash
mund keys add $WALLET --recover
```

Check list wallet
```bash
mund keys list
```

### Create Validator
```bash
mund tx staking create-validator \
  --from $WALLET \
  --moniker $NODENAME \
  --pubkey $(mund tendermint show-validator) \
  --chain-id MUN_CHAIN_ID \
  --amount 50000000000utmun \
  --commission-max-change-rate 0.01 \
  --commission-max-rate 0.2 \
  --commission-rate 0.1 \
  --min-self-delegation 1 \
  --fees 200000utmun \
  --gas auto \
  --gas-adjustment=1.5 -y
  ```

  ### Voting
  ```bash
  mund tx gov vote 1 yes --from $WALLET --chain-id=$MUN_CHAIN_ID
  ```

  ### Staking, Delegating and Rewards

Delegate Stake
```bash
mund tx staking delegate $MUN_VALOPER_ADDRESS 10000000utmun --from=$WALLET --chain-id=$MUN_CHAIN_ID --gas=auto
```

Redelegate stake from validator to another validator

```bash
mund tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000utmun --from=$WALLET --chain-id=$MUN_CHAIN_ID --gas=auto
```

Withdraw All Reward
```bash
mund tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$MUN_CHAIN_ID --gas=auto
```

Withdraw reward with commision
```bash
mund tx distribution withdraw-rewards $MUN_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$MUN_CHAIN_ID
```

### Validator management

Edit Validator
```bash
mund tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$MUN_CHAIN_ID \
  --from=$WALLET
  ```

  Unjail Validator
  ```bash
  mund tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$MUN_CHAIN_ID \
  --gas=auto
  ```

### Another Usefull Command

#### Service Management
Check Logs
```bash
journalctl -fu mund -o cat
```

Start Services
```bash
sudo systemctl start mund
```

Stop Services
```bash
sudo systemctl stop mund
```

Restart Services
```bash
sudo systemctl restart mund
```

#### Node Info
Synchronize Info
```bash
mund status 2>&1 | jq .SyncInfo
```

Validator Info
```bash
mund status 2>&1 | jq .ValidatorInfo
```

Node Info
```bash
mund status 2>&1 | jq .NodeInfo
```

Show Node ID
```bash
mund tendermint show-node-id
```

#### Wallet Information
List Wallet
```bash
mund keys list
```

Recover Wallet 
```bash
mund keys add $WALLET --recover
```

Delete Wallet
```bash 
mund keys delete $WALLET
```

Get Wallet Balannce
```bash
mund query bank balances $MUN_WALLET_ADDRESS
```

Transfer Funds
```bash
mund tx bank send $MUN_WALLET_ADDRESS <TO_MUN_WALLET_ADDRESS> 10000000utmun
```

#### Delete Node
This commands will completely remove node from server

```bash
sudo systemctl stop mund
sudo systemctl disable mund
sudo rm /etc/systemd/system/mun* -rf
sudo rm $(which mund) -rf
sudo rm $HOME/.mun* -rf
sudo rm $HOME/mun -rf
sed -i '/MUN_/d' ~/.bash_profile
```
