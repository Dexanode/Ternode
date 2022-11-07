
# OKP4 TESTNET
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/65535542/200253333-931c0c7e-b652-44cd-a743-d9fb66f5be0d.jpeg">
</p>


## Persyaratan Hardware

- Memory:8 GB RAM
- CPU: 4 Core
- Disk: 100 GB SSD Storage
- OS: Ubuntu 18.04 LTS

## Sat set installation
```bash
  wget -q -O okp4.sh https://raw.githubusercontent.com/nadi555/Ternode/main/okp4/okp4.sh && chmod +x okp4.sh && sudo /bin/bash okp4.sh
```

## After installation
### Load Variable
```bash
source $HOME/.bash_profile
```

Next you have to make sure your validator is syncing blocks. You can use command below to check synchronization status

```bash
okp4d status 2>&1 | jq .SyncInfo
```

### State Sync (OPTIONAL)
```bash
SNAP_RPC=https://okp4-testnet-rpc.polkachu.com:443
peers="https://okp4-testnet-rpc.polkachu.com:443"
sed -i.bak -e  "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" ~/.okp4d/config/config.toml
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 500)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.okp4d/config/config.toml

okp4d tendermint unsafe-reset-all --home /root/.okp4d --keep-addr-book
systemctl restart okp4d && journalctl -u okp4d -f -o cat
```

### Create Wallet
To create new wallet you can use command below. Don’t forget to save the mnemonic


```bash
okp4d keys add $WALLET
```

(OPTIONAL) To recover your wallet using seed phrase

```bash
okp4d keys add $WALLET --recover
```

To get current list of wallets

```bash
okp4d keys list
```

### Save wallet info
Add wallet and valoper address into variables

```bash
OKP4D_WALLET_ADDRESS=$(okp4d keys show $WALLET -a)
OKP4D_VALOPER_ADDRESS=$(okp4d keys show $WALLET --bech val -a)
echo 'export OKP4D_WALLET_ADDRESS='${OKP4D_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export OKP4D_VALOPER_ADDRESS='${OKP4D_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```
Fund your wallet
In order to create validator first you need to fund your wallet with testnet tokens here https://faucet.okp4.network/

Create validator
Before creating validator please make sure that you have at least 1 strd (1 strd is equal to 1000000 unois) and your node is synchronized

To check your wallet balance:

```bash
okp4d query bank balances $OKP4D_WALLET_ADDRESS
```

To create your validator run command below

```bash
okp4d tx staking create-validator \
  --amount 100000000uknow \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(okp4d tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id okp4-nemeton
  ```

### Security
To protect you keys please make sure you follow basic security rules

### Set up ssh keys for authentication
Good tutorial on how to set up ssh keys for authentication to your server can be found here

### Basic Firewall security
Start by checking the status of ufw.

```bash
sudo ufw status
```

Sets the default to allow outgoing connections, deny all incoming except ssh and 26656. Limit SSH login attempts

```bash
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow ${OKP4_PORT}656,${OKP4_PORT}660/tcp
sudo ufw enable
```

### Check your validator key
```bash
[[ $(okp4d q staking validator $OKP4D_VALOPER_ADDRESS -oj | jq -r .consensus_pubkey.key) = $(okp4d status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
```

### Get list of validators
```bash
okp4d q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl
```

### Usefull commands
#### Service management

Check logs

```bash
journalctl -fu okp4d -o cat
```

Start Service
```bash
sudo systemctl start okp4d
```

Stop Service
```bash
sudo systemctl stop okp4d
```

Restart Service
```bash
sudo systemctl restart okp4d
```

### Node info
Synchronization info

```bash
okp4d status 2>&1 | jq .SyncInfo
```

Validator Info
```bash
okp4d status 2>&1 | jq .ValidatorInfo
```

Node Info
```bash
okp4d status 2>&1 | jq .NodeInfo
```

Show node id
```bash
okp4d tendermint show-node-id
```

### Wallet operations

List of wallets
```bash
okp4d keys list
```

Recover wallet
```bash
okp4d keys add $WALLET --recover
```

Delete wallet
```bash
okp4d keys delete $WALLET
```

Get wallet balance
```bash
okp4d query bank balances $OKP4D_WALLET_ADDRESS
```

Transfer funds
```bash
okp4d tx bank send $OKP4D_WALLET_ADDRESS <TO_OKP4D_WALLET_ADDRESS> 10000000uknow
```

### Voting
```bash
okp4d tx gov vote 1 yes --from $WALLET --chain-id=$OKP4D_CHAIN_ID
```

#### Staking, Delegation and Rewards

Delegate stake
```bash
okp4d tx staking delegate $OKP4D_VALOPER_ADDRESS 10000000uknow --from=$WALLET --chain-id=$OKP4D_CHAIN_ID --gas=auto
```

Redelegate stake from validator to another validator
```bash
okp4d tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000uknow --from=$WALLET --chain-id=$OKP4D_CHAIN_ID --gas=auto
```

Withdraw all rewards
```bash
okp4d tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$OKP4D_CHAIN_ID --gas=auto
```

Withdraw rewards with commision
```bash

okp4d tx distribution withdraw-rewards $OKP4D_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$OKP4D_CHAIN_ID
```

### Validator management
Edit Validator
```bash
okp4d tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$OKP4D_CHAIN_ID \
  --from=$WALLET
```

Unjail Validator
```bash
okp4d tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$OKP4D_CHAIN_ID \
  --gas=auto
```

### Delete node
This commands will completely remove node from server. Use at your own risk!

```bash
sudo systemctl stop okp4d && \
sudo systemctl disable okp4d && \
rm /etc/systemd/system/okp4d.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf okp4d && \
rm -rf .okp4d && \
rm -rf $(which okp4d)
```
