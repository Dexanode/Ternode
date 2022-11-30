
# INERY TESTNET TASK I
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Inery](https://user-images.githubusercontent.com/65535542/191928956-e06ca9cd-a640-4553-aeb4-ac9706a3b810.png#/)


A brief description of what this project does and who it's for


## Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps buat Download/100 Mbps buat Upload

## Update Package
```bash
  sudo apt-get update && sudo apt install git && sudo apt install screen
```

## Edit Firewall Port
```
ufw allow 22 && ufw allow 8888 && ufw allow 9010 && ufw enable -y
```

# Installing Node
## Cloning Inery Node from github
```
git clone https://github.com/inery-blockchain/inery-node
```

## Go to inery setup folder
```
cd inery-node/inery.setup
```

## change app permission
```
chmod +x ine.py
```

## export path to local os environment for inery binaries
```
./ine.py --export
```

## refresh path variable
```
cd; source .bashrc; cd -
```

## Edit the configuration
```
sudo nano tools/config.json
```

``` "MASTER_ACCOUNT":
{
    "NAME": "AccountName",
    "PUBLIC_KEY": "PublicKey",
    "PRIVATE_KEY": "PrivateKey",
    "PEER_ADDRESS": "IP:9010",
    "HTTP_ADDRESS": "0.0.0.0:8888",
    "HOST_ADDRESS": "0.0.0.0:9010"
}
```

AccountName ganti Account Name kalian di dashboard
Public Key dan Private Key juga kalian replace yang di dashboard
IP di PEER_ADDRESS ganti pake IP Private kalo yang pake azure kalau yang pake cantabo masukin IP Public

## Screen Master Node
```
screen -S master
```

```
./ine.py --master
```
Cek Logs

```bash
cd /root/inery-node/inery.setup/master.node/blockchain/
```

```bash
tail -f nodine.log
```

## Create Wallet

```
cd;  cline wallet create --file defaultWallet.txt
```

## If your wallet has password, you need to unlock it first
```
cline wallet unlock --password YOUR_WALLET_PASSWORD
```

## Import Key
```
cline wallet import --private-key MASTER_PRIVATE_KEY
 ```
 change MASTER_PRIVATE_KEY dengan private kalian
 
 ## Register as producer by executing command
```
cline system regproducer ACCOUNT_NAME ACCOUNT_PUBLIC_KEY 0.0.0.0:9010
```

## Approve your account as producer by executing command
```
cline system makeprod approve ACCOUNT_NAME ACCOUNT_NAME
```

Cek Node kalian di sini - > https://explorer.inery.io/

# Tambahan
### Buat hapus node (uninstall) go to 
```
inery.setup/inery.node/ and execute ./stop.sh script
```

### Untuk melanjutkan protokol blockchain, jalankan 
```
start.sh script
```

### Untuk menghapus blockchain dengan semua data dari mesin lokal, buka 
```
inery.setup/inery.node/ and execute ./clean.sh script
```

### Kalau Node pas running node masternya ga jalan

```
pkill nodine
```

Lanjut Hapus dulu driectory master-node

```
cd inery-testnet/inery.setup
```

Hapus Directory

```
rm -rf master.node
```
