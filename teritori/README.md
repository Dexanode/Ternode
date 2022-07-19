
# BUNDLR TESTNET
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Teritori](https://user-images.githubusercontent.com/65535542/179707485-f5321544-1b43-4514-bbf8-a76059765463.png)

Before running node you must open Port **26656** & **26657**


## Persyaratan Hardware

- Memory:2 GB RAM
- CPU: 2 Core
- Disk: 80 GB SSD Storage
- OS: Ubuntu 18.04 LTS

## Sat set installation
```bash
  wget -q -O teritori.sh https://raw.githubusercontent.com/nadi555/Ternode/main/teritori/teritori.sh && chmod +x teritori.sh && sudo /bin/bash teritori.sh
```

## After installation
### Load Variable
```bash
source $HOME/.bash_profile
```

### Cek Logs before you create validator and your node must ***FALSE****
```bash
teritorid status 2>&1 | jq .SyncInfo
```

### Create Wallet
Add New Wallet
```bash
 teritorid keys add $WALLET
```

Recover Wallet
```bash
teritorid keys add $WALLET --recover
```

Get your wallet list
```bash
teritorid keys list
```

### Save Wallet Info
```bash
TERITORI_WALLET_ADDRESS=$(teritorid keys show $WALLET -a)
TERITORI_VALOPER_ADDRESS=$(teritorid keys show $WALLET --bech val -a)
echo 'export TERITORI_WALLET_ADDRESS='${TERITORI_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export TERITORI_VALOPER_ADDRESS='${TERITORI_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```

## GET Faucet
### Open to discord [Teritori Discord](https://discord.gg/89zVxf29gC)

Use command for req funds
```bash
$request <YOUR_WALLET_ADDRESS>
```

Check Balance
```bash
$balance <YOUR_WALLET_ADDRESS>
```
## Create Validator
```bash
teritorid tx staking create-validator \
  --amount 1000000utori \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(teritorid tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id $TERITORI_CHAIN_ID
```

##Another command
###Check logs

```bash
journalctl -fu teritorid -o cat
```

Start service

```bash
sudo systemctl start teritorid
```

Stop service

```bash
sudo systemctl stop teritorid
```

Restart service

```bash
sudo systemctl restart teritorid
```

Synchronization info

```bash
teritorid status 2>&1 | jq .SyncInfo
```

Validator info

```bash
teritorid status 2>&1 | jq .ValidatorInfo
```

Node info

```bash
teritorid status 2>&1 | jq .NodeInfo
```

Show node id

```bash 
teritorid tendermint show-node-id
```

###Wallet operations
Get wallet balance

```bash
teritorid query bank balances $TERITORI_WALLET_ADDRESS
```

Transfer funds

```bash
teritorid tx bank send $TERITORI_WALLET_ADDRESS <TO_TERITORI_WALLET_ADDRESS> 10000000utori
```

Voting

```bash
teritorid tx gov vote 1 yes --from $WALLET --chain-id=$TERITORI_CHAIN_ID
```

###Staking, Delegation and Rewards
Delegate stake

```bash
teritorid tx staking delegate $TERITORI_VALOPER_ADDRESS 10000000utori --from=$WALLET --chain-id=$TERITORI_CHAIN_ID --gas=auto
```

Redelegate stake from validator to another validator

```bash 
teritorid tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000utori --from=$WALLET --chain-id=$TERITORI_CHAIN_ID --gas=auto
```

Withdraw all rewards

```bash 
teritorid tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$TERITORI_CHAIN_ID --gas=auto
```

Withdraw rewards with commision

```bash
teritorid tx distribution withdraw-rewards $TERITORI_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$TERITORI_CHAIN_ID
```

### Validator management
Edit validator

```bash
teritorid tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$TERITORI_CHAIN_ID \
  --from=$WALLET
```

###Unjail validator

```bash
teritorid tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$TERITORI_CHAIN_ID \
  --gas=auto
```


Delete node

```bash
sudo systemctl stop teritorid
sudo systemctl disable teritorid
sudo rm /etc/systemd/system/teritori* -rf
sudo rm $(which teritorid) -rf
sudo rm $HOME/.teritorid* -rf
sudo rm $HOME/teritori -rf
sed -i '/TERITORI_/d' ~/.bash_profile
```
