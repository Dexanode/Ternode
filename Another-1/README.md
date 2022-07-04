## Another -1 Testnet

Install automation sat  set

```bash
wget -q -O another-1-rekap.sh https://raw.githubusercontent.com/nadi555/Ternode/main/Another-1/another-1.sh && chmod +x another-1-rekap.sh && sudo /bin/bash another-1-rekap.sh
```

#### after installation

```bash
source $HOME/.bash_profile
```


#### validator info

```bash
anoned status 2>&1 | jq .ValidatorInfo

anoned status 2>&1 | jq .SyncInfo

anoned status 2>&1 | jq .NodeInfo
```
#### Create your wallet
Add New Wallet

```bash
anoned keys add wallet
```
#### Recover Existing Wallet

```bash
anoned keys add wallet --recover
```
#### List All Wallet

```bash
anoned keys list
```

#### Check Wallet Balance

```bash
anoned q bank balances $(anoned keys show wallet -a)
```
## Validator

Create New Validator

```bash
anoned tx staking create-validator \
--amount=1000000uan1 \
--pubkey=$(anoned tendermint show-validator) \
--moniker="<YOUR NODENAME>" \
--identity=<YOUR IDENTITY> \
--details="<YOUR DETAILS>" \
--chain-id=anone-testnet-1 \
--commission-rate=0.10 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1 \
--from=wallet \
--fees=2000uan1 \
--gas=auto \
-y
```
Edit Existing Validator

```bash
anoned tx staking edit-validator \
--moniker="<YOUR NODENAME>" \
--identity="<YOUR IDENTITY>" \
--details="<YOUR DETAILS>" \
--chain-id=anone-testnet-1 \
--commission-rate=0.1 \
--from=wallet \
--fees=2000uan1 \
--gas=auto \
-y
```

Unjail Validator

```bash
anoned tx slashing unjail --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y
```

Jail Reason

```bash
anoned query slashing signing-info $(anoned tendermint show-validator)
```

Withdraw Commission And Rewards

```bash
anoned tx distribution withdraw-all-rewards --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y 
```

Delegate

```bash
anoned tx staking delegate <YOUR_VALOPER_ADDRESS> 1000000uan1 --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y 
```

Redelegate

```bash
anoned tx staking redelegate <YOUR_VALOPER_ADDRESS> <TO_VALOPER_ADDRESS> 1000000uan1 --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y 
```

Send

```bash
anoned tx bank send wallet <TO_WALLET_ADDRESS> 1000000uan1 --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y 
```

## Governance

Vote proposal

```bash
anoned tx gov vote <proposal id> yes/no --from wallet --chain-id anone-testnet-1 --fees 2000uan1 --gas auto -y 
```
