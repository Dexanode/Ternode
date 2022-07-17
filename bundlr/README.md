
# BUNDLR TESTNET

A brief description of what this project does and who it's for


## Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps buat Download/100 Mbps buat Upload

## Sat set installation
```
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
cd validator-rush ```

```bash
nano wallet.json 
```

- Paste your json
- CTRL X and Y For Save json file

### Step Wallet For Cantabo or SFTP Opened
- Copy File json and Paste on MobaXterm 
- Don't forget rename file become ``wallet.json``

### Create File Services

```
tee $HOME/validator-rust/.env > /dev/null <<EOF
PORT=80
BUNDLER_URL="https://testnet1.bundlr.network"
GW_CONTRACT="RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA"
GW_ARWEAVE="https://arweave.testnet1.bundlr.network"
EOF
```

### Install Screen

``` apt install screen ```

**Create New screen**

``` screen -R bundlr ```

**Running Docker**

```cd ~/validator-rust && docker compose up -d```

**Check Log**

```
cd ~/validator-rust && docker compose logs --tail=100 -f
```

### Verifier Initialization:

```
npm i -g @bundlr-network/testnet-cli
```

Add your validator to the network. Edit your `yourip` address:

```
cd /root/validator-rust && testnet-cli join RkinCLBlY4L5GZFv8gCFcrygTyd5Xm91CzKlR6qxhKA -w wallet.json -u "http://ipkowe:80" -s 25000000000000 
```

### DONE

**Delete Node**

```
cd ~/validator-rust && docker-compose down -v
cd $HOME
rm -rf ~/validator-rust
```
