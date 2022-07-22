
# Near - Stakewars III
**In Validators, We Trust.**

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Stakewars](https://user-images.githubusercontent.com/65535542/180388239-aa732905-8c4e-4c14-bfd7-c8eed6b82609.jpg)


## Recommended Hardware Requirements

- 4x CPUs; the faster clock speed the better
- 8GB RAM
- 500GB of storage (SSD or NVME)
- Permanent Internet connection (traffic will be minimal during devnet; 10Mbps will be plenty - for production at least 100Mbps is expected)

## Installation

Update, Download Pacakge and Install Python 
```bash
sudo apt update && sudo apt upgrade -y

sudo apt install -y git binutils-dev libcurl4-openssl-dev zlib1g-dev libdw-dev libiberty-dev cmake gcc g++ python docker protobuf-compiler libssl-dev pkg-config clang llvm cargo clang build-essential make

sudo apt install python3-pip 

USER_BASE_BIN=$(python3 -m site --user-base)/bin export PATH="$USER_BASE_BIN:$PATH"
```

Install Node JS and NPM

```bash
curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash - 
sudo apt install build-essential nodejs 
PATH="$PATH"
```

Install NEAR CLI
``` bash
sudo npm install -g near-cli
```

Setup Environment
```bash
export NEAR_ENV=shardnet 
echo ‘export NEAR_ENV=shardnet’ >> ~/.bashrc 
source ~/.bashrc
```

Install Cargo and Rust (Wait)
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

Donwload Binaries
```bash
git clone https://github.com/near/nearcore 
cd nearcore 
git fetch 
git checkout 8448ad1ebf27731a43397686103aa5277e7f2fcf
cargo build -p neard --release --features shardnet
```

Check Version
```bash
~/nearcore/target/release/neard --version
```

Initialize the working directory, delete old files and download new config file and new genesis.json. Since the network was hard forked recently, there is no need to download the snapshot.
```bash
~/nearcore/target/release/neard --home ~/.near init --chain-id shardnet --download-genesis 
rm ~/.near/config.json ~/.near/genesis.json
```

```bash
wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json 
wget -O ~/.near/genesis.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/genesis.json
```

```bash
mv ~/.near/data ~/.near/data-fork1 && rm ~/.near/config.json && wget -O ~/.near/config.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/config.json && rm ~/.near/genesis.json && wget -O ~/.near/genesis.json https://s3-us-west-1.amazonaws.com/build.nearprotocol.com/nearcore-deploy/shardnet/genesis.json
```

Now you will need to create a wallet https://wallet.shardnet.near.org/ WARNING! If you had a wallet previously to the hard fork, you may need to recreate it! Forget the old mnemonic and do everything from scratch.

After that, write in the CLI
```bash
near login
```
