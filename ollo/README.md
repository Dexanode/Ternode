<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Ollo](https://https://user-images.githubusercontent.com/65535542/195965347-2ea6fb6d-2cf2-4240-a65b-9ad322415f75.png)

# Ollo Station Incentiviced Testnet

## Minimum hardware requirements
- CPU: 4 CPU
- Memory: 8 GB RAM
- Disk: 50 GB SSD Storage

## Recommended hardware requirements
- CPU: 2 CPU
- Memory: 8 GB RAM
- Disk: 100 GB SSD Storage

## Setting Validator

### Upgrade your dependecies and package

bash```
sudo apt-get upgrade && sudo apt-get update -y
```

Change ``<YOUR MONIKER>`` replace with whatever you like

Save and import variables

```bash
echo "export NODENAME=$NODENAME" >> $HOME/.bash_profile
if [ ! $WALLET ]; then
  echo "export WALLET=wallet" >> $HOME/.bash_profile
fi
echo "export OLLO_CHAIN_ID=ollo-testnet-0" >> $HOME/.bash_profile
source $HOME/.bash_profile
```

### Packages and Dependencies

Install Dependencies
```bash
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt install make clang pkg-config libssl-dev build-essential git jq llvm libudev-dev -y
```

Install GO 1.18+
```bash
if ! [ -x "$(command -v go)" ]; then
  ver="1.18.3"
  cd $HOME
  wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz"
  rm "go$ver.linux-amd64.tar.gz"
  echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> ~/.bash_profile
  source ~/.bash_profile
fi
```
Download Binaries
```bash
cd $HOME
git clone https://github.com/OllO-Station/ollo.git
cd ollo
make install
```

Config
```bash
ollod config chain-id $OLLO_CHAIN_ID
ollod config keyring-backend test
```

Init
```bash
ollod init $NODENAME --chain-id $OLLO_CHAIN_ID
```

Donwload Genesis and Address Book
```bash
wget -qO $HOME/.ollo/config/genesis.json https://github.com/AlexToTheMoon/AM-Solutions/raw/main/ollo-genesis.json
wget -qO $HOME/.ollo/config/addrbook.json https://github.com/AlexToTheMoon/AM-Solutions/raw/main/ollo-addrbook.json
ollod tendermint unsafe-reset-all --home $HOME/.ollo --keep-addr-book
```

Set Peers
```bash
SEEDS=""
PEERS="764988cb3a9de4afa34c666019510ea5b5856c60@65.108.238.61:46656,4dd3f3897ab77c7aa981bf4e928659f867093361@198.244.179.62:25456,1be12d239ca70a906264de0f09e0ffa01c4211ba@138.201.136.49:26656,ffbc66ef617ec910e453bec28d2750951d964f89@154.53.59.87:32656,9316bed278b94c3e8a298b0649d62ca9c57bd210@94.103.93.45:15656,6368702dd71e69035dff6f7830eb45b2bae92d53@65.109.57.161:15656,d24d7968f2377a1488c057c79f39e6c7a0d5698b@95.217.12.175:32656,7735cb5a04ad60437c575ecc5280c43b2df9a038@161.97.99.247:11656,362c9af972fb9bbc058a48786a097c74e2606504@176.9.106.43:36656,3498a07e5e79b269a3e445e8073d58bf42b6a5b8@185.173.37.47:32656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.ollo/config/config.toml
```

Config Prunning (OPTIONAL)
```bash
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.ollo/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.ollo/config/app.toml
```

Set minimum Gas price and Commit
```bash
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0utollo\"/" $HOME/.ollo/config/app.toml
```

Reset Chain Data
```bash
ollod tendermint unsafe-reset-all --home $HOME/.ollo
```

Create Services
```bash
sudo tee /etc/systemd/system/ollod.service > /dev/null <<EOF
[Unit]
Description=ollo
After=network-online.target

[Service]
User=$USER
ExecStart=$(which ollod) start --home $HOME/.ollo
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

Start Services
```bash
sudo systemctl daemon-reload
sudo systemctl enable ollod
sudo systemctl restart ollod && sudo journalctl -u ollod -f -o cat
```

### Create Wallet
Create New Wallet
```bash
ollod keys add $WALLET
```

Recover existing wallet (Optional)
```bash
ollod keys add $WALLET --recover
```

Get current list of wallets

```bash
ollod keys list
```

Save Wallet Info
```bash
OLLO_WALLET_ADDRESS=$(ollod keys show $WALLET -a)
OLLO_VALOPER_ADDRESS=$(ollod keys show $WALLET --bech val -a)
echo 'export OLLO_WALLET_ADDRESS='${OLLO_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export OLLO_VALOPER_ADDRESS='${OLLO_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```

Fund your wallet

Jump to Discord  [Ollo Station Community](https://discord.gg/jQ84Y4JH) and Go To Channel #Testnet-Faucet and type ``!request <address>``


### Create validator
To create validator you need Ollo tokens , to check if you have any :
```bash
ollod query bank balances $OLLO_WALLET_ADDRESS
```

Create your validator with 2 UTOLLO, 1 ollo is equal to 1000000 utollo

```bash
ollod tx staking create-validator \
  --amount 2000000utollo \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(ollod tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id $OLLO_CHAIN_ID
  ```

## Usefull commands

### Service management

Check Logs
```bash
journalctl -fu ollod -o cat
```

Start Services
```bash
sudo systemctl start ollod
```

Stop Services
```bash
sudo systemctl stop ollod
```

Start Services
```bash
sudo systemctl restart ollod
```

### Node Info
Sync Info
```bash
ollod status 2>&1 | jq .SyncInfo
```

Validator Info
```bash
ollod status 2>&1 | jq .ValidatorInfo
```

Node Info
```bash
ollod status 2>&1 | jq .NodeInfo
```

Show Node ID
```bash
ollod tendermint show-node-id
```

### Wallet operations
List of wallets
```bash
ollod keys list
```

Recover Wallet
```bash
ollod keys add $WALLET --recover
```

Delete Wallet
```bash
ollod keys delete $WALLET
```

Get Wallet Balance
```bash
ollod query bank balances $OLLO_WALLET_ADDRESS
```

Transfer Funds
```bash
ollod tx bank send $OLLO_WALLET_ADDRESS <TO_OLLO_WALLET_ADDRESS> 10000000utollo
```

### Voting
```bash
ollod tx gov vote 1 yes --from $WALLET --chain-id=$OLLO_CHAIN_ID
```

### Staking, Delegation and Rewards
Delegate Stake
```bash
ollod tx staking delegate $OLLO_VALOPER_ADDRESS 10000000utollo --from=$WALLET --chain-id=$OLLO_CHAIN_ID --gas=auto
```

Redelegate stake from validator to another validator
```bash
ollod tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000utollo --from=$WALLET --chain-id=$OLLO_CHAIN_ID --gas=auto
```

Withdraw all rewards
```bash
ollod tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$OLLO_CHAIN_ID --gas=auto
```

Withdraw rewards with commision
```bash
ollod tx distribution withdraw-rewards $OLLO_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$OLLO_CHAIN_ID
```

### Validator management
Edit validator
```bash
ollod tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$OLLO_CHAIN_ID \
  --from=$WALLET
```

Unjail Validator

```bash
ollod tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$OLLO_CHAIN_ID \
  --gas=auto
```

### Delete node

This commands will completely remove node from server. Use at your own risk!

```bash
sudo systemctl stop ollod
sudo systemctl disable ollod
sudo rm /etc/systemd/system/ollo* -rf
sudo rm $(which ollod) -rf
sudo rm $HOME/.ollo* -rf
sudo rm $HOME/ollo -rf
sed -i '/OLLO_/d' ~/.bash_profile
```
