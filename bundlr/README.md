
# BUNDLR TESTNET
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Bundlr](https://user-images.githubusercontent.com/65535542/179391342-c941e9a8-4fd5-41dd-857c-907b47d863d1.png)

A brief description of what this project does and who it's for


## Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps buat Download/100 Mbps buat Upload

## Sat set installation
```bash
  wget -q -O bundlr.sh https://raw.githubusercontent.com/nadi555/Ternode/main/bundlr/bundlr.sh && chmod +x bundlr.sh && sudo /bin/bash bundlr.sh
```

## After installation
### Create and Fund your wallet address
- Go to https://faucet.arweave.net/ and Create Wallet 
- Download your wallet
- And tweet your verif wallet arweave

### Step Wallet For Azure User
- Open your backup arweave file `arweave-key.....json`
- Copy 

```bash
cd validator-rush 
```

```bash
touch wallet.json
```

```bash
vi wallet.json
```

- ENTER E for Edit File 
- ENTER P or righ click for paste file ``.json``
- Enter ``:wq`` for save and exit

### Step Wallet For Cantabo or SFTP Opened
- Copy File json and Paste on MobaXterm 
- Don't forget rename file become ``wallet.json``

### Create File Services

```bash
tee $HOME/validator-rust/.env > /dev/null <<EOF
PORT=80
BUNDLER_URL="https://testnet1.bundlr.network"
GW_CONTRACT="RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA"
GW_ARWEAVE="https://arweave.testnet1.bundlr.network"
EOF
```

### Install Screen

```bash
apt install screen 
```

**Create New screen**

```bash
screen -R bundlr 
```

**Running Docker**
Wait 5 - 10 Minutes

```bash
cd ~/validator-rust && docker compose up -d
```

**Check Log**

```bash
cd ~/validator-rust && docker compose logs --tail=100 -f
```
- CTRL A+D for save screen

### Verifier Initialization:

```bash
npm i -g @bundlr-network/testnet-cli
```

Add your validator to the network. Edit your `yourip` address:

```bash
cd /root/validator-rust && testnet-cli join RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA -w wallet.json -u "http://yourip:80" -s 25000000000000 
```

### DONE

**Delete Node**

```bash
cd ~/validator-rust && docker-compose down -v
cd $HOME
rm -rf ~/validator-rust
```
