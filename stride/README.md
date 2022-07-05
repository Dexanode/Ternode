
# Stride Node

A brief description of what this project does and who it's for


## Recomended Hardware Requirements

 - 4x CPU
 - 8 GB RAM
 - 200 GB SSD or NVME

 ## Set up Node

Installation otomatis
```bash
wget -O stride.sh   https://raw.githubusercontent.com/nadi555/Ternode/main/stride/stride.sh && chmod +x stride.sh && ./stride.sh
```
  ## After Installation
Setelah instalasi selesai load variable di sistem kalian
```bash
  source $HOME/.bash_profile
```
Cek status sync block dengan command dibawah
```bash
strided status 2>&1 | jq .SyncInfo
```
## Setting Firewall 
Cek status
```bash
ufw status
```
Sets the default to allow outgoing connections, deny all incoming except ssh and 26656. Limit SSH login attempts
```bash
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow ${STRIDE_PORT}656,${STRIDE_PORT}660/tcp
sudo ufw enable
```

## Create Wallet
Membuat wallet dengan command dibawah dan jangan lupa di save mnemonic kalian
```bash
strided keys add $WALLET
```
RECOVER Wallet
```bash
strided keys add $WALLET --recover
```
Cek List wallet
```bash
strided keys list
```
### Save Wallet Info
add wallet dan valoper address ke variabels
```bash
STRIDE_WALLET_ADDRESS=$(strided keys show $WALLET -a)
```
```bash
STRIDE_VALOPER_ADDRESS=$(strided keys show $WALLET --bech val -a)
```
Load Variabels kedalam system
```bash
echo 'export STRIDE_WALLET_ADDRESS='${STRIDE_WALLET_ADDRESS} >> $HOME/.bash_profile
echo 'export STRIDE_VALOPER_ADDRESS='${STRIDE_VALOPER_ADDRESS} >> $HOME/.bash_profile
source $HOME/.bash_profile
```
### Fund Wallet
Untuk meminta faucet kalian minta ke [Stride Discord](https://discord.gg/89zVxf29gC)
- ke channel #faucet dengan command
```bash
$request:<YOUR_WALLET_ADDRESS>
```
Cek Balance
```bash
$balance:<YOUR_WALLET_ADDRESS>
```
## Create Validator
Sebelum menjalankan validator di pastiakan node kalian sudah syncron yaa dan equivalent 1 kuji -> 1000000 ustrd
Cek wallet balance
```bash
strided query bank balances $STRIDE_WALLET_ADDRESS
```
Create Validator
```bash
strided tx staking create-validator \
  --amount 10000000ustrd \
  --from $WALLET \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.07" \
  --min-self-delegation "1" \
  --pubkey  $(strided tendermint show-validator) \
  --moniker $NODENAME \
  --chain-id $STRIDE_CHAIN_ID
  ```

## Usefull commands
### Service management
Check logs
```bash
journalctl -fu strided -o cat
```
Start service
```bash
sudo systemctl start strided
```
Stop service
```bash
sudo systemctl stop strided
```
Restart service
```bash
sudo systemctl restart strided
```
#### Node info
Synchronization info
```bash
strided status 2>&1 | jq .SyncInfo
```
Validator info
```bash
strided status 2>&1 | jq .ValidatorInfo
```
Node info
```bash
strided status 2>&1 | jq .NodeInfo
```
Show node id
```bash
strided tendermint show-node-id
```
###Wallet operations
List of wallets
```bash
strided keys list
```
Recover wallet
```bash
strided keys add $WALLET --recover
```
Delete wallet

```bash 
strided keys delete $WALLET
```
Get wallet balance

```bash
strided query bank balances $STRIDE_WALLET_ADDRESS
```
Transfer funds
```bash
strided tx bank send $STRIDE_WALLET_ADDRESS <TO_STRIDE_WALLET_ADDRESS> 10000000ustrd
```
Voting
```bash
strided tx gov vote 1 yes --from $WALLET --chain-id=$STRIDE_CHAIN_ID
```
### Staking, Delegation and Rewards
Delegate stake
```bash
strided tx staking delegate $STRIDE_VALOPER_ADDRESS 10000000ustrd --from=$WALLET --chain-id=$STRIDE_CHAIN_ID --gas=auto
```
Redelegate stake from validator to another validator
```bash
strided tx staking redelegate <srcValidatorAddress> <destValidatorAddress> 10000000ustrd --from=$WALLET --chain-id=$STRIDE_CHAIN_ID --gas=auto
```
Withdraw all rewards
```bash
strided tx distribution withdraw-all-rewards --from=$WALLET --chain-id=$STRIDE_CHAIN_ID --gas=auto
```
Withdraw rewards with commision
```bash
strided tx distribution withdraw-rewards $STRIDE_VALOPER_ADDRESS --from=$WALLET --commission --chain-id=$STRIDE_CHAIN_ID
```
###Validator management
Edit validator
```bash
strided tx staking edit-validator \
  --moniker=$NODENAME \
  --identity=<your_keybase_id> \
  --website="<your_website>" \
  --details="<your_validator_description>" \
  --chain-id=$STRIDE_CHAIN_ID \
  --from=$WALLET
```
Unjail validator
```bash
strided tx slashing unjail \
  --broadcast-mode=block \
  --from=$WALLET \
  --chain-id=$STRIDE_CHAIN_ID \
  --gas=auto
```
### Delete node
This commands will completely remove node from server. Use at your own risk!
```bash
sudo systemctl stop strided
sudo systemctl disable strided
sudo rm /etc/systemd/system/stride* -rf
sudo rm $(which strided) -rf
sudo rm $HOME/.stride* -rf
sudo rm $HOME/stride -rf
```
