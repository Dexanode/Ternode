
# Guide Deploy Light Node (Celesita ITN The Blockspace Race)  

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Bundlr](https://user-images.githubusercontent.com/65535542/228904748-bbfc4fd8-7c12-4d37-9e03-022d516f4a4e.jpeg)


# Official Links
### [Official Document](https://docs.celestia.org/nodes/blockspace-race/#phase-2-staging)
### [Celestia Official Discord](https://discord.gg/celestiacommunity)

# Explorer
### [Explorer](https://tiascan.com/light-nodes)

## Minimum Requirements 
- Single CPU cores
- At least 5GB of SSD disk storage
- At least 2GB of memory (RAM)
- At least 156 Kbps for Download/56 Kbps for Upload network bandwidth


# Update Package

```bash
sudo apt update && sudo apt upgrade -y

sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential git make ncdu -y
```

# Install Golang

```bash
ver="1.19.1" 
cd $HOME 
wget "https://golang.org/dl/go$ver.darwin-amd64.tar.gz" 
sudo rm -rf /usr/local/go 
sudo tar -C /usr/local -xzf "go$ver.darwin-amd64.tar.gz" 
rm "go$ver.darwin-amd64.tar.gz"
```

# Set Bash Profile

```bash
echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bash_profile

source $HOME/.bash_profile

```

# Check Go Version

```bash
go version go1.19.4 linux/amd64
```

# Install Celestia Blockspace Race

```bash
cd $HOME 
rm -rf celestia-node 
git clone https://github.com/celestiaorg/celestia-node.git 
cd celestia-node/ 
git checkout tags/v0.8.0 
make build 
make install 
make cel-key
```

# Check Celestia Version

```bash
celestia version
```

# Inittialize Light Node

```bash
celestia light init --p2p.network blockspacerace

```

# Save Mnemonic sama addressnya, terus ambil faucet di discordnya Celestia pake command $request walletklean

```bash
./cel-key list --node.type light --p2p.network blockspacerace
```

# Create Services 

```bash
sudo tee <<EOF >/dev/null /etc/systemd/system/celestia-lightd.service
[Unit]
Description=celestia-lightd Light Node
After=network-online.target

[Service]
User=$USER
ExecStart=/usr/local/bin/celestia light start --core.ip https://rpc-blockspacerace.pops.one --core.rpc.port 26657 --core.grpc.port 9090 --keyring.accname my_celes_key --metrics.tls=false --metrics --metrics.endpoint otel.celestia.tools:4318 --gateway --gateway.addr localhost --gateway.port 26659 --p2p.network blockspacerace
Restart=on-failure
RestartSec=3
LimitNOFILE=4096

[Install]
WantedBy=multi-user.target
EOF
```

# Start Services Celestia

```bash
systemctl enable celestia-lightd
systemctl start celestia-lightd
```

# Check Logs

```bash
journalctl -u celestia-lightd.service -f
```


# Ambil Node ID buat di submit di task

```bash
curl -X POST \
     -H "Authorization: Bearer $AUTH_TOKEN" \
     -H 'Content-Type: application/json' \
     -d '{"jsonrpc":"2.0","id":0,"method":"p2p.Info","params":[]}' \
     http://localhost:26658
     ```

# Input Metric Flags on Node

## Opened Services Celestia

```bash
nano /etc/systemd/system/celestia-lightd.service
```

## Copy this command

```bash
--metrics.tls=false --metrics --metrics.endpoint otel.celestia.tools:4318
```

Pastekan Command Di atas di samping blockspacerace, lihat gambar di bawah

![Bundlr](https://user-images.githubusercontent.com/65535542/228909380-f6303c5e-5319-4aa7-9f78-730807584c49.png)

## Reload and Restart Your Node

```bash
systemctl daemon-reload
systemctl restart celestia-lightd
```

## And Check Your Logs

```bash
journalctl -u celestia-lightd.service -f
```

# Cheatseet

## Restart Node

```bash
systemctl restart celestia-lightd
```

## Stop Node

```bash
systemctl stop celestia-lightd
```

## Check Balance

```bash
curl -X GET http://127.0.0.1:26658/balance

```

## Check Block

```bash
curl -X GET http://127.0.0.1:26658/header/1
```

# Delete Node
```bash
systemctl stop celestia-lightd
rm -rf /etc/systemd/system/celestia-lightd.service
rm -rf celestia-node
rm -rf .celestia-app
rm -rf .celestia-light-blockspacerace-0
rm -f $(which celestia-lightd)
rm -rf $HOME/.celestia-lightd
rm -rf $HOME/celestia-lightd
```
