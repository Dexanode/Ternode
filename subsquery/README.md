
# Subsquery Via VPS

Install Docker

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
````
Install Docker-Compose
```
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```
Buat Folder & Install

```
mkdir testnet
cd testnet
curl https://raw.githubusercontent.com/subquery/indexer-services/main/docker-compose.yml -o docker-compose.yml
```
Open `docker-compose.yaml`
```
nano docker-compose.yml
```
Cari pos_8_Tgres ada 2 : Ganti Dengan Password Kalian

![Screenshot 2022-07-05 134721](https://user-images.githubusercontent.com/65535542/177267691-e4262b57-3855-44e4-aeed-0613127364a7.png)

Done and `CTRL + X and Y and Enter`

Starting Index
```
docker-compose up -d
```

Open Your Browse
```
http://IPKALIAN:8000
```
Connect Metamask

Add RPC :

Network Name : Acala Testnet


Network URL : https://tc7-eth.aca-dev.network


Chain ID : 595


Currency Symbol : ACA


Block Explorer URL : https://blockscout.mandala.acala.network/

Claim Faucet in [Discord](https://discord.gg/WW9BsDVS)
```
!drip address_kalian
```
Connect To Metamask and Approve in Metamask

Fill data index


## Fill your data index

**Indexer Name:** Airdrop Sultan Indonesia

**Proxy End Point:** http://IP_KALIAN/

**Staking Amount:** 1000

**Commission Rate (%) :** 30

 Register Index > Approve Metamask

Sync

Manage Control

Add Account

Klik Active > Send Transaction

Klik Project Yang Udah Jadi > Klik Start Indexing

**Jaringan Pengindeksan:** wss://polkadot.api.onfinality.io/public-ws

**Kamus Jaringan:** https://api.subquery.network/sq/subquery/polkadot-dictionary

Confirm > Tunggu 1 Menit

Klik lagi Annunce Indexing

Send Trascation > Approve Metamask

Stop Indexing Project > Restart Indexing

Klik Announce Ready > Approve Metamask

Done

## 🚀 About Me
I`am Dexa From Airdrop Sultan Indonesia

Contact Me : erulbathory@gmail.com

Telegram : @dexa555

Discord : XDexa#5062

Join TG : https://t.me/airdropsultanindonesia
