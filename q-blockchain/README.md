
# Guide Q Blockchain Incentiviced Nodes

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/204122528-65112f65-3086-4cc5-bcdd-eea7beb34421.jpg">
</p>

## Requirements Hardware

-

## Set Vars

```bash
PASSWORD=YOUR_PASSWORD
```
change to your password

## Export the variable


```bash
echo "export PASSWORD=$PASSWORD" $HOME/.bash_profile
source $HOME/.bash_profile
```

## Update

Update your package

```bash
sudo apt update && \
sudo apt upgrade && \
apt-install docker-compose
```

## Install Docker

```bash
sudo apt-get update && sudo apt install jq && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin && sudo apt-get install docker-compose-plugin
```

## Download Binaries and set password file

```bash
git clone https://gitlab.com/q-dev/testnet-public-tools.git
cd testnet-public-tools/testnet-validator/
```


```bash
mkdir keystore
cd keystore/
echo "$PASSWORD" >> pwd.txt
```
## Download Genesis
```bash
curl -s https://raw.githubusercontent.com/neutron-org/testnets/main/quark/genesis.json > ~/.neutrond/config/genesis.json
```

## Generate Wallet
```bash
cd ..
docker run --entrypoint="" --rm -v $PWD:/data -it qblockchain/q-client:testnet geth account new --datadir=/data --password=/data/keystore/pwd.txt
```
Backup OUTPUT

## FUND Your Wallet

Fund your wallet [ Q Faucet ](https://faucet.qtestnet.org/)

## Download Addressbook### Configure
```
cp .env.example .env
nano .env
```

Add Address without `0x` and your Public IP and save settings `CTRL+X` `y` and `ENTER`

Example : 

 <img height="400" height="auto" src="https://user-images.githubusercontent.com/65535542/206829826-85c08d3f-1063-443a-8276-2e951dad646a.png">

Configure `config.json`
```
nano config.json
```
Add Address without `0x` and your Password from the beginning and save `CTRL+X` `y` and `ENTER`

<img height="400" height="auto" src="https://user-images.githubusercontent.com/65535542/206828971-9dc57454-7f0f-42f1-9f87-abee788adb1a.png">

### Stake to the contract
```
docker run --rm -v $PWD:/data -v $PWD/config.json:/build/config.json qblockchain/js-interface:testnet validators.js
```

### Export your private key to Metamask 
```
cd testnet-public-tools
chmod +x run-js-tools-in-docker.sh
./run-js-tools-in-docker.sh
npm install
```
```
chmod +x extract-geth-private-key.js
node extract-geth-private-key <WALLET_ADDRESS> ../testnet-validator/ $PASSWORD
```
Change `<WALLET_ADDRESS>` To your Wallet address

After saving your private key exit the container `exit`

# Registering Validator

In order to register your node you have to register in the Form : [Register Form](https://itn.qdev.li/)

Register your validator according to your validator info

After successfully register your validator you will receive your validator name 

<img height="400" height="auto" src="https://user-images.githubusercontent.com/34649601/206744494-8418897e-226c-49be-a073-4ed939084384.png">

### Configure docker-compose.yaml
```
cd testnet-validator
nano docker-compose.yaml
```
Then add `--ethstats=ITN-testname-ecd07:qstats-testnet@stats.qtestnet.org` 

Example : 

<img height="450" height="auto" src="https://user-images.githubusercontent.com/34649601/206747640-e29e7f73-a549-416a-b52f-6a138f402212.png">


Then Run the Validator : 
```
docker-compose up -d
```

Check logs ( You have to be in the compose directory! )
```
docker-compose logs -f
```
CTRL+C to exit logs

## Check your validator 

### [Q Explorer](https://stats.qtestnet.org/)

# Run OmniBride (OPTIONAL) For learning purposes

### Configure Omnibride Oracle
```
cd $HOME
cd testnet-public-tools/omnibridge-oracle
cp .env.testnet .env
nano .env
```

Change this 3 Value 

<img height="450" height="auto" src="https://user-images.githubusercontent.com/34649601/206751937-40a418fc-c60d-4d3c-bebc-c7814b065b86.png">


`ORACLE_VALIDATOR_ADDRESS` :	`Provide your Q validator address. Example: 0xac8e5047d122f801...`

`ORACLE_VALIDATOR_ADDRESS_PRIVATE_KEY` :	`Provide your Q validator private key. Example: a385db8296ceb9a....`

`COMMON_HOME_RPC_URL` :	`You can keep the default, use https://rpc.qtestnet.org or use the RPC endpoint of our own full node if you are operating one.`

`COMMON_FOREIGN_RPC_URL` :	`Provide an RPC endpoint of a client of the blockchain on the other side of the bridge. Q testnet bridged to the Ethereum Rinkeby network. You can use your own ethereum client, a public endpoint or create an infura account for free to get a personal Ethereum Rinkeby access point (e.g. https://rinkeby.infura.io/v3/1673abc....).`

### Run your docker-compose
```
docker-compose up -d
docker-compose logs -f
```
To check logs You have to be in the compose directory!

`CTRL+C` to exit logs
