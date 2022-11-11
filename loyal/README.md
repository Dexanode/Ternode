
# LOYAL INCENTIVICED TESTNET
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/65535542/201281261-47444495-67ec-4b37-8785-4f0b5f51b350.jpg">
</p>


## Minimum Hardware Requirements

- Memory  : 4 GB RAM
- CPU     : 3 or more physical CPU cores
- Disk    : 80 GB SSD Storage

## Sat set installation
```bash
  wget -q -O loyal.sh https://raw.githubusercontent.com/nadi555/Ternode/main/loyal/loyal.sh && chmod +x loyal.sh && sudo /bin/bash loyal.sh
```

## After installation

Cek Node Info 
```bash
loyald status 2>&1 | jq .SyncInfo
```

### Add Wallet

Add new wallet
```bash
loyald keys add $LYL_WALLET
```

Recover Wallet
```bash
loyald keys add $LYL_WALLET --recover
```

List Wallet
```bash
loyald keys list
```

Save Wallet Info
```bash
LYL_WALLET_ADDRESS=$(loyald keys show $LYL_WALLET -a)
```

```bash
echo 'export LYL_WALLET_ADDRESS='${LYL_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export LYL_VALOPER_ADDRESS='${LYL_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```

Claim Faucet go to discord Loyal and tag team to request faucet 
Discord : 

cek balance wallet
```bash
loyald query bank balances $LYL_WALLET_ADDRESS
```

### Crete Validator
```bash
loyald tx staking create-validator \
  --amount 8000000ulyl \
  --from ISI ADDRESS KALIAN \
  --min-self-delegation "1" \
  --commission-max-rate "0.2" \
  --commission-max-change-rate "0.07" \
  --commission-rate "0.07" \
  --pubkey  $(loyald tendermint show-validator) \
  --moniker ISI NAMA NODE KALIAN \
  --chain-id $LYL_ID \
  --gas-prices 1ulyl
  ```

###  Usefull commands

Check Logs
```bash
journalctl -fu loyald -o cat
```

start services
```baash
systemctl start loyald
```

stop services
```bash
systemctl stop loyald
```

restart services
```bash
systemctl restart loyald
```

Node Info
```bash
loyald status 2>&1 | jq .SyncInfo
```

Validator info
```bash
loyald status 2>&1 | jq .ValidatorInfo
```

Node information
```bash
loyald status 2>&1 | jq .NodeInfo
```

Show node ID
```bash
loyald tendermint show-node-id
```

### Wallet operations

List wallet
```bash
loyald keys list
```

Recover wallet with mnemonic
```bash
loyald keys add $LYL_WALLET --recover
```

Delete Wallet
```bash
loyald keys delete $LYL_WALLET
```

Check Balances 
```bash
loyald query bank balances $LYL_WALLET_ADDRESS
```

Transfer funds
```bash
loyald tx bank send $LYL_WALLET_ADDRESS <TO_WALLET_ADDRESS> 10000000ulyl
```

Voting
```bash
loyald tx gov vote 1 yes --from $LYL_WALLET --chain-id=$LYL_ID
```

#### Staking, Delegation and Rewards

Delegate stake
```bash
loyald tx staking delegate $LYL_VALOPER_ADDRESS 10000000ulyl --from=$LYL_WALLET --chain-id=$LYL_ID --gas=auto --fees 250ulyl
```

Redelegate stake from validator to another validator
```bash
loyald tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000ulyl --from=$LYL_WALLET --chain-id=$LYL_ID --gas=auto --fees 250ulyl
```

Withdraw all rewards
```bash
loyald tx distribution withdraw-all-rewards --from=$LYL_WALLET --chain-id=$LYL_ID --gas=auto --fees 250ulyl
```

Withdraw rewards with commision
```bash
loyald tx distribution withdraw-rewards $LYL_VALOPER_ADDRESS --from=$LYL_WALLET --commission --chain-id=$LYL_ID
```

### Validator management

Edit Validator
```bash
loyald tx staking edit-validator \
--moniker=NEWNODENAME \
--chain-id=$LYL_ID \
--from=$LYL_WALLET
```

Unjail
```bash
loyald tx staking edit-validator \
  --new-moniker=ISI NAMA NODE KALIAN \
  --identity="ISI PGP KEY AKUN KEYBASE" \
  --website="https://t.me/bangpateng_group" \
  --chain-id=$LYL_ID \
  --from=ISI ADDRESS KALIAN \
  --fees=250ulyl
  --gas-prices 1ulyl
  ```

### Delete node
This commands will completely remove node from server. Use at your own risk!

```bash
sudo systemctl stop loyald
sudo systemctl disable loyald
sudo rm /etc/systemd/system/loyald* -rf
sudo rm $(which loyald) -rf
sudo rm $HOME/.loyal* -rf
sudo rm $HOME/loyal* -rf
sed -i '/LYL_/d' ~/.bash_profile
```
