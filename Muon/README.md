
# Guide Intsallation Node Validator Neutron Quark Tesnet

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/213711680-fd483b03-6635-4f4d-8156-a1a8be79a126.png">
</p>

## Requirements Hardware

- 2vCPU 
- 4GB RAM 
- 20GB SSD
- Port 8000

## Update Package

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git make ncdu docker-compose -y
```

## Open Port

```bash
ufw allow 8000
ufw enable
```

## Install Docker 
```bash
rm /usr/bin/docker-compose /usr/local/bin/docker-compose
```
```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
```
```bash
systemctl restart docker
```
```bash
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
```
```bash
chmod +x /usr/local/bin/docker-compose
```
```bash
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```
```bash
docker --version
```

## Clone Muon

```bash
git clone https://github.com/muon-protocol/muon-node-js.git --recurse-submodules --branch testnet
```

## Build Muon

```bash
cd muon-node-js
docker-compose build
docker-compose up -d
```

## If this is run successfully, the node's status can be viewed by opening the following address in your browser:

```bash
http://<server-ip>:8000/status
```

Result look like
```bash
{"address":"0x06A85356DCb5b307096726FB86A78c59D38e08ee","peerId":"Qma3GsJmB47xYuyahPZPSadh1avvxfyYQwk8R3UnFrQ6aP","managerContract":{"network":"bsctest","address":"0x2efB53c11FC935f6114B3fC37AaFa6a76B263a4E"},"shield":{"enable":false,"apps":[]},"addedToNetwork":false}
```

Visit -> https://alice.muon.net/join 
### Connect Wallet

![muon](https://user-images.githubusercontent.com/65535542/213710107-ee12c47a-692f-4131-a782-8ad295dd87dd.png)

### Mint Faucet Muon

![muon1](https://user-images.githubusercontent.com/65535542/213710401-cb58f64d-5c07-4edf-986e-bef31a6d21d1.png)


### Register add Node

Go to -> http://<server-ip>:8000/status

Save output

example
```bash

{"address":"0x06A85356DCb5b307096726FB86A78c59D38e08ee","peerId":"Qma3GsJmB47xYuyahPZPSadh1avvxfyYQwk8R3UnFrQ6aP","managerContract":{"network":"bsctest","address":"0x2efB53c11FC935f6114B3fC37AaFa6a76B263a4E"},"shield":{"enable":false,"apps":[]},"addedToNetwork":false}
```
  
![muon3](https://user-images.githubusercontent.com/65535542/213770172-54cd5744-506a-4eb8-a666-47e8f74dac3d.png)
  
Enter Address and peerID, and then Add Node

The fields Node Address and Peer Id are obtained from the node's status as explained above in "Running the Node". To test whether or not your node has successfully been added to the network, open the following link in your browser.

Bagian ini emang lama jadi kudu sabar yak
```bash
http://<server-ip>:8000/v1/?app=tss&method=test
```

If it is added correctly, you should receive a json response whose `success` is `true`
```bash
{"success":true,"result":{"confirmed":true, ... }}
```




