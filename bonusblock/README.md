
# Guide Intsallation Node Validator BonusBlock 

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/226438691-a9abb0cb-4eb0-439b-a434-5e1eb87bc4a0.png">
</p>


# Official Links
### [Official Document](https://docs.bonus.network/validators/overview.html)

# Explorer
### [Explorer](https://explorer.dexanode.site/bonusblock/staking)

## Minimum Requirements 
- 4 or more physical CPU cores
- At least 500GB of SSD disk storage
- At least 16GB of memory (RAM)
- At least 120mbps network bandwidth

# Automatic Install Node Guide
```bash
wget -O bonus.sh https://raw.githubusercontent.com/nadi555/Ternode/main/bonusblock/bonus.sh && chmod +x bonus.sh && ./bonus.sh
```

## Snapshoot

```bash
Soon
```


## Cheatsheet

### Create wallet
To create new wallet use 
```
bonus-blockd keys add wallet
```
Change `wallet` to your wallet name

To recover existing keys use 
```
bonus-blockd keys add wallet --recover
```
Change `wallet` to your wallet name

To see current keys 
```
bonus-blockd keys list
```


```bash

### Create validator
After your node is synced, create validator

To check if your node is synced simply run
`curl http://localhost:111657/status sync_info "catching_up": false`

Creating validator with `1 bonus` change the value as you like

```
```bash
bonus-blockd tx staking create-validator \
  --amount 100000ubonus \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --identity= "" \
  --website= ""\
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(bonus-blockd tendermint show-validator) \
  --moniker $NODENAME \
  --gas=auto \
  --gas-adjustment=1.2 \
  --gas-prices=0.025ubonus \
  --chain-id $BONUS_CHAIN_ID \
  --node tcp://127.0.0.1:17657 \
  -- yes
```

## Usefull commands
### Service management
Check logs
```
journalctl -fu bonus-blockd -o cat
```

Start service
```
sudo systemctl start bonus-blockd
```

Stop service
```
sudo systemctl stop bonus-blockd
```

Restart service
```
sudo systemctl restart bonus-blockd
```

### Node info
Synchronization info
```
bonus-blockd status 2>&1 | jq .SyncInfo
```

Validator info
```
bonus-blockd status 2>&1 | jq .ValidatorInfo
```

Node info
```
bonus-blockd status 2>&1 | jq .NodeInfo
```

Show node id
```
bonus-blockd tendermint show-node-id
```

### Wallet operations
List of wallets
```
bonus-blockd keys list
```

Recover wallet
```
bonus-blockd keys add wallet --recover
```

Delete wallet
```
bonus-blockd keys delete wallet
```

Get wallet balance
```
bonus-blockd query bank balances <address>
```

Transfer funds
```
bonus-blockd tx bank send <FROM ADDRESS> <TO_bonus_WALLET_ADDRESS> 10000000abonus
```

### Voting
```
bonus-blockd tx gov vote 1 yes --from wallet --chain-id=blocktopia-1
```

### Staking, Delegation and Rewards
Delegate stake
```
bonus-blockd tx staking delegate <bonus valoper> 10000000abonus --from=wallet --chain-id=blocktopia-1 --gas=auto
```

Redelegate stake from validator to another validator
```
bonus-blockd tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000abonus --from=wallet --chain-id=blocktopia-1 --gas=auto
```

Withdraw all rewards
```
bonus-blockd tx distribution withdraw-all-rewards --from=wallet --chain-id=blocktopia-1 --gas=auto
```

Withdraw rewards with commision
```
bonus-blockd tx distribution withdraw-rewards <bonus valoper> --from=wallet --commission --chain-id=blocktopia-1
```

### Validator management
Edit validator
```
bonus-blockd tx staking edit-validator \
  --moniker=$MONIKER \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=blocktopia-1 \
  --from=wallet
```

Unjail validator
```
bonus-blockd tx slashing unjail \
  --broadcast-mode=block \
  --from=wallet \
  --chain-id=blocktopia-1 \
  --gas=auto
```

### Delete node
```
sudo systemctl stop bonus-blockd && \
sudo systemctl disable bonus-blockd && \
rm /etc/systemd/system/bonus-blockd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .bonusblock && \
rm -rf $(which bonus-blockd)
```

