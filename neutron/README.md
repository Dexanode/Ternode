
# Guide Intsallation Node Validator Neutron Quark Tesnet

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/204122528-65112f65-3086-4cc5-bcdd-eea7beb34421.jpg">
</p>

## Requirements Hardware

- CPU 4 Cores
- 32 GB RAM
- 2x512 GB SSD



## Update Package

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
```

## Install GO

```bash
ver="1.19" && \
wget "https://golang.org/dl/go$ver.linux-amd64.tar.gz" && \
sudo rm -rf /usr/local/go && \
sudo tar -C /usr/local -xzf "go$ver.linux-amd64.tar.gz" && \
rm "go$ver.linux-amd64.tar.gz" && \
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile && \
source $HOME/.bash_profile && \
go version
```

## Node installation

Build and install neutron binary

```bash
git clone https://github.com/neutron-org/neutron
cd neutron
git checkout v0.0.1
make install
```

## Cek Version

```bash
neutrond version --long
```

If same with this. Done
`
name: neutron
server_name: neutrond
version: 0.1.1
commit: a9e8ba5ebb9230bec97a4f2826d75a4e0e6130d9
`

## Set Moniker

```bash
neutrond init <<node_name>> --chain-id quark-1
```

## Download Genesis
```bash
curl -s https://raw.githubusercontent.com/neutron-org/testnets/main/quark/genesis.json > ~/.neutrond/config/genesis.json
```

## Add Peers
```bash
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0untrn\"/" $HOME/.neutrond/config/app.toml
sed -i -e "s/^filter_peers *=.*/filter_peers = \"true\"/" $HOME/.neutrond/config/config.toml
external_address=$(wget -qO- eth0.me) 
sed -i.bak -e "s/^external_address *=.*/external_address = \"$external_address:26656\"/" $HOME/.neutrond/config/config.toml
peers="fcde59cbba742b86de260730d54daa60467c91a5@23.109.158.180:26656,5bdc67a5d5219aeda3c743e04fdcd72dcb150ba3@65.109.31.114:2480,3e9656706c94ae8b11596e53656c80cf092abe5d@65.21.250.197:46656,9cb73281f6774e42176905e548c134fc45bbe579@162.55.134.54:26656,27b07238cf2ea76acabd5d84d396d447d72aa01b@65.109.54.15:51656,f10c2cb08f82225a7ef2367709e8ac427d61d1b5@57.128.144.247:26656,20b4f9207cdc9d0310399f848f057621f7251846@222.106.187.13:40006,5019864f233cee00f3a6974d9ccaac65caa83807@162.19.31.150:55256,2144ce0e9e08b2a30c132fbde52101b753df788d@194.163.168.99:26656,b37326e3acd60d4e0ea2e3223d00633605fb4f79@nebula.p2p.org:26656"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.neutrond/config/config.toml
seeds="e2c07e8e6e808fb36cca0fc580e31216772841df@seed-1.quark.ntrn.info:26656,c89b8316f006075ad6ae37349220dd56796b92fa@tenderseed.ccvalidators.com:29001"
sed -i.bak -e "s/^seeds =.*/seeds = \"$seeds\"/" $HOME/.neutrond/config/config.toml
sed -i -e "s/^timeout_commit *=.*/timeout_commit = \"2s\"/" $HOME/.neutrond/config/config.toml
sed -i 's/max_num_inbound_peers =.*/max_num_inbound_peers = 100/g' $HOME/.neutrond/config/config.toml
sed -i 's/max_num_outbound_peers =.*/max_num_outbound_peers = 100/g' $HOME/.neutrond/config/config.toml
```

## Prunning

```bash
pruning="custom" && \
pruning_keep_recent="100" && \
pruning_keep_every="0" && \
pruning_interval="10" && \
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" ~/.neutrond/config/app.toml && \
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" ~/.neutrond/config/app.toml && \
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" ~/.neutrond/config/app.toml && \
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" ~/.neutrond/config/app.toml
```

## Download Addressbook
```bash
wget -O $HOME/.neutrond/config/addrbook.json "https://raw.githubusercontent.com/obajay/nodes-Guides/main/Neutron/addrbook.json"
```

## Create Service File

```bash
sudo tee /etc/systemd/system/neutrond.service > /dev/null <<EOF
[Unit]
Description=neutron
After=network-online.target

[Service]
User=$USER
ExecStart=$(which neutrond) start
Restart=on-failure
RestartSec=3
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target
EOF
```

## Start Services
```bash
sudo systemctl daemon-reload
sudo systemctl enable neutrond
sudo systemctl restart neutrond && sudo journalctl -u neutrond -f -o cat
```

## State Sycn (Optional)

```bash
SNAP_RPC=http://neutron.rpc.t.stavr.tech:11057
peers="b81828b92f6e58eaa211fbb21c08cf809cdefa94@neutron.rpc.t.stavr.tech:11056"
sed -i.bak -e "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" $HOME/.neutrond/config/config.toml
LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
BLOCK_HEIGHT=$((LATEST_HEIGHT - 500)); \
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

echo $LATEST_HEIGHT $BLOCK_HEIGHT $TRUST_HASH

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"\"|" $HOME/.neutrond/config/config.toml
neutrond tendermint unsafe-reset-all --home /root/.neutrond --keep-addr-book
```

## Check Logs
```bash
neutrond status 2>&1 | jq .SyncInfo
```

## Create Wallet
```bash
neutrond keys add wallet
```

Cek List Wallet
```bash
neutrond keys list
```

Recover Wallet
```bash
neutrond keys add wallet --recover
```

Check Wallet Balance
```bash
neutrond q bank balances $neutron_wallet_address
```

## Create Validator

```bash
neutrond tx staking create-validator \
--amount=1000000untrn \
--pubkey=$(neutrond tendermint show-validator) \
--moniker="Moniker" \
--identity= \
--details= \
--chain-id=quark-1 \
--commission-rate=0.10 \
--commission-max-rate=0.20 \
--commission-max-change-rate=0.01 \
--min-self-delegation=1 \
--from=wallet \
--gas-prices=0.1untrn \
--gas-adjustment=1.5 \
--gas=auto \
-y 
```

## Edit Validator

```bash
neutrond tx staking edit-validator \
--moniker="Moniker" \
--identity= \
--details= \
--chain-id=quark-1 \
--commission-rate=0.1 \
--from=wallet \
--gas-prices=0.1untrn \
--gas-adjustment=1.5 \
--gas=auto \
-y 
```

## Unjail Validator
```bash
neutrond tx slashing unjail --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Check Logs

```bash
journalctl -fu neutrond -o cat
```

Start Services

```bash
sudo systemctl start neutrond
```

Stop Services
```bash
sudo systemctl stop neutrond
```

Restart Services
```bash
sudo systemctl restart neutrond
```

Sync Info
```bash
neutrond status 2>&1 | jq .SyncInfo
```

Validator Info
```bash
neutrond status 2>&1 | jq .ValidatorInfo
```

Node Info
```bash
neutrond status 2>&1 | jq .NodeInfo
```

## Staking & Delegate Stake
```bash
neutrond tx staking delegate $(neutrond keys show wallet --bech val -a) 1000000untrn --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Redelegate stake from validator to another validator
```bash
neutrond tx staking redelegate $(neutrond keys show wallet --bech val -a) <TO_VALOPER_ADDRESS> 1000000untrn --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Withdraw all rewards

```bash
neutrond tx distribution withdraw-all-rewards --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Withdraw rewards with commision

```bash
neutrond tx distribution withdraw-rewards $(neutrond keys show wallet --bech val -a) --commission --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Transfer Balances
```bash
neutrond tx bank send wallet <TO_WALLET_ADDRESS> 1000000untrn --from wallet --chain-id quark-1 --gas-prices 0.1untrn --gas-adjustment 1.5 --gas auto -y 
```

## Delete Node
```bash
sudo systemctl stop neutrond 
sudo systemctl disable neutrond 
sudo rm /etc/systemd/system/neutrond.service 
sudo systemctl daemon-reload 
rm -rf $HOME/.neutrond 
rm $(which neutrond) 
```