## Cheatsheet

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
empowerd tx bank send <FROM ADDRESS> <TO_empower_WALLET_ADDRESS> 100000umpwr
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
