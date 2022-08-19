
# Safestake incentivized Galileo Testnet Is Now Live

# Create Validator


<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Safestake](https://user-images.githubusercontent.com/65535542/184927830-a4868b78-236d-408f-8ff9-ab4cc7dd542c.jpg)


**Install Prerequisites**

```bash
sudo apt -y update
sudo apt -y upgrade
```

**Install the commonly available prerequisites**

```bash
sudo apt -y install software-properties-common wget curl ccze
```

**Install Geth**
```bash
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt -y install get
```

**Install Lighthouse**
```bash
cd ~
wget https://github.com/sigp/lighthouse/releases/download/v2.4.0/lighthouse-v2.4.0-x86_64-unknown-linux-gnu.tar.gz
tar xvf lighthouse-v2.4.0-x86_64-unknown-linux-gnu.tar.gz
rm lighthouse-v2.4.0-x86_64-unknown-linux-gnu.tar.gz
```

```bash
sudo cp ~/lighthouse /usr/local/bin
rm ~/lighthouse
```

*Create File Token JWT**
Create a JWT token file in a neutral location and make it readable by everyone. We will use the /var/lib/ethereum/jwttoken location to store the JWT token file

```bash
sudo mkdir -p /var/lib/ethereum
openssl rand -hex 32 | tr -d "\n" | sudo tee /var/lib/ethereum/jwttoken
sudo chmod +r /var/lib/ethereum/jwttoken
```

**Configuring your Geth node**
Create a custom user to run Geth, create a directory to store the data and set the appropriate permissions.

```bash
sudo useradd --no-create-home --shell /bin/false goeth
sudo mkdir -p /var/lib/goethereum
sudo chown -R goeth:goeth /var/lib/goethereum
```

Create a systemd service configuration file to configure the Geth node service.

```bash
sudo nano /etc/systemd/system/geth.service
```

Copy and Enter the Command Below

```bash
[Unit]
Description=Go Ethereum Client - Geth (Ropsten)
After=network.target
Wants=network.target

[Service]
User=goeth
Group=goeth
Type=simple
Restart=always
RestartSec=5
TimeoutStopSec=180
ExecStart=geth \
    --ropsten \
    --http \
    --datadir /var/lib/goethereum \
    --metrics \
    --metrics.expensive \
    --pprof \
    --authrpc.jwtsecret=/var/lib/ethereum/jwttoken

[Install]
WantedBy=default.target
```

Save after done ```( Ctrl+ X, Y, Enter)```

Reload systemd to reflect the changes and start the service. Check the status to make sure it's running properly.

```bash
sudo systemctl daemon-reload
sudo systemctl start geth.service
sudo systemctl status geth.service
```

```bash
sudo systemctl enable geth.service
```

**Check Log Geth**

```bash
sudo journalctl -f -u geth.service -o cat | ccze -A
```


Press ```Ctrl C``` To stop showing those messages

**Configuring your Lighthouse beacon node**

Create a custom user to run the Lighthouse beacon node, create a directory to store the data, copy the testnet files, and set the appropriate permissions.

```bash
sudo useradd --no-create-home --shell /bin/false lighthousebeacon
sudo mkdir -p /var/lib/lighthouse
sudo chown -R lighthousebeacon:lighthousebeacon /var/lib/lighthouse
```

Create a systemd service configuration file to configure the Lighthouse beacon node service.

```bash
sudo nano /etc/systemd/system/lighthousebeacon.service
```

Copy and Enter the Command Below

```bash
[Unit]
Description=Lighthouse Ethereum Client Beacon Node (Ropsten)
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=lighthousebeacon
Group=lighthousebeacon
Restart=always
RestartSec=5
ExecStart=/usr/local/bin/lighthouse bn \
    --network ropsten \
    --datadir /var/lib/lighthouse \
    --staking \
    --execution-endpoints http://127.0.0.1:8551 \
    --metrics \
    --validator-monitor-auto \
    --checkpoint-sync-url=https://ropsten.checkpoint-sync.ethdevops.io \
    --jwt-secrets=/var/lib/ethereum/jwttoken

[Install]
WantedBy=multi-user.target
```
save when done ```( Ctrl X, Y, Enter)```

```bash
sudo systemctl daemon-reload
sudo systemctl start lighthousebeacon.service
sudo systemctl status lighthousebeacon.service
```

**Check Log lighthouse**

```bash
sudo journalctl -f -u lighthousebeacon.service -o cat | ccze -A
```

Press ```Ctrl C``` To stop showing those messages

**Setup Ropsten in Luanchpad**

- Make sure your address have 32eth or more
- if you have faucet go to -> https://faucet.egorfine.com/

