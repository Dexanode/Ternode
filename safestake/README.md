
# Safestake ncentivized Galileo Testnet Is Now Live


<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Safestake](https://user-images.githubusercontent.com/65535542/184927830-a4868b78-236d-408f-8ff9-ab4cc7dd542c.jpg)


## Recommended Hardware Requirements

- 4x CPUs; the faster clock speed the better
- 8GB RAM
- 200GB of storage (SSD or NVME)

## Installation

** Update **
```bash
sudo apt-get update
```
```bash
sudo apt install git sudo unzip wget -y
```

Install Node JS and NPM

** Clone **

```bash
git clone --recurse-submodules https://github.com/ParaState/SafeStakeOperator
cd SafeStakeOperator
```

** Install Docker **

``` bash
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

** Instal docker-compose **
```bash
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
sudo chown $USER /var/run/docker.sock
```

** Running Docker **
```bash
sudo docker compose -f docker-compose-boot.yml build
```

```bash
sudo docker compose -f docker-compose-boot.yml up -d
```

```bash
docker-compose -f docker-compose-boot.yml logs -f dvf_root_node | grep enr
```

Example Output
```bash
dvf-dvf_root_node-1 | Base64 ENR: enr:-IS4QNa-kpJM1eWfueeEnY2iXlLAL0QY2gAWAhmsb4c8VmrSK9J7N5dfXS_DgSASCDrUTHMqMUlP4OXSYEVh-Z7zFHkBgmlkgnY0gmlwhAMBnbWJc2VjcDI1NmsxoQPKY0yuDUmstAHYpMa2_oxVtw0RW_QAdpzBQA8yWM0xOIN1ZHCCIy0
```
