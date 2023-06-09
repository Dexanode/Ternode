# Guide For Task CLI Testing Empower Incentiviced Testnet

### Before doing the task must run validator first

Explorer For Check HASH and your TX : https://empowerchain.exploreme.pro/

## empowerx tx authz grant
```
empowerd tx authz grant new_wallet send --spend-limit=1000umpwr --from wallet_validator -y
```

## empowerx tx authz revoke
```
empowerd tx authz revoke new_wallet /cosmos.bank.v1beta1.MsgSend --from wallet_validator
```

## empowerx tx bank send
```
empowerd tx bank send wallet YOUR_TO_WALLET_ADDRESS 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerx tx bank multi-send
```
empowerd tx bank multi-send wallet wallet-1 wallet-2 1000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerx tx staking delegate
```
empowerd tx staking delegate YOUR_TO_VALOPER_ADDRESS 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerx tx staking redelegate
```
empowerd tx staking redelegate $(empowerd keys show wallet --bech val -a) YOUR_TO_VALOPER_ADDRESS 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```


## empowerx tx staking unbond
``` 
empowerd tx staking unbond $(empowerd keys show wallet --bech val -a) 1000000umpwr --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerx tx cancel-unbound
```
empowerd tx staking cancel-unbond valoperaddress 100umpwr blockpasundelegate --from wallet -y
```

## empowerd tx distribution withdraw-all-rewards
```
empowerd tx distribution withdraw-all-rewards --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerd tx distribution withdraw-rewards**
```
empowerd tx distribution withdraw-rewards $(empowerd keys show wallet --bech val -a) --commission --from wallet --chain-id circulus-1 --gas-prices 0.1umpwr --gas-adjustment 1.5 --gas auto -y
```

## empowerx tx auth exect

Untuk task ini bikin wallet kedua di command line atau bisa import dari keplr

### first command

```
empowerd tx bank send wallet_address_pertama wallet_address_kedua 1000umpwr --generate-only > tx.json
```

### second command

```
empowerd tx authz exec tx.json --from wallet --fees 200umpwr
```

Copy Hash Second Command
