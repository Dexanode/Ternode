
# EXORDE INCENTIVICED TESTNET
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/65535542/200724874-aeb41a88-61f9-44d1-b6e5-1bb012310329.jpeg">
</p>


## Persyaratan Hardware

- Memory  : 4 GB RAM
- CPU     : 2 or more physical CPU cores
- Disk    : -+ 40 GB SSD Storage
- OS      : Ubuntu 18.04 LTS

## Set Vars

```bash
  WALLET_ADDRESS=<METAMASK WALLET ADDRESS>
```
Change <METAMASK WALLET ADDRESS> To your Metamask Wallet Address

```bash
echo export WALLET_ADDRESS=${WALLET_ADDRESS} >> $HOME/.bash_profile
source ~/.bash_profile
```

## Update Packages and Dependencies
```bash
cd $HOME
sudo apt update && sudo apt upgrade -y
sudo apt install curl build-essential git wget npm jq make gcc tmux -y && apt purge docker docker-engine docker.io containerd docker-compose -y
```

## Intsall Docker
```bash
rm /usr/bin/docker-compose /usr/local/bin/docker-compose
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
systemctl restart docker
curl -SL https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker --version
```
## Clone Repository
```bash
git clone https://github.com/exorde-labs/ExordeModuleCLI.git
cd ExordeModuleCLI
```

```bash
docker build -t exorde-cli .
```

## Run Exorder CLI through Docker
### This runs in the background

```bash
docker run -d -it --name Exorde exorde-cli -m $WALLET_ADDRESS -l 4
```

You can change the logs by changing ``4`` :

0 = no logs
1 = general logs
2 = validation logs
3 = validation + scraping logs
4 = detailed validation + scraping logs (e.g. for troubleshooting)

## Check the logs

To check logs

```bash
docker logs Exorde
```
To check logs constantly

```bash
docker logs --follow Exorde

```

To delete node

```bash
sudo  docker stop Exorde &&  sudo  docker  rm Exorde
sudo  rm -rf ExordeModuleCLI
 ```