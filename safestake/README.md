
# Safestake ncentivized Galileo Testnet Is Now Live


<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Safestake](https://user-images.githubusercontent.com/65535542/184927830-a4868b78-236d-408f-8ff9-ab4cc7dd542c.jpg)


## Recommended Hardware Requirements

- 4x CPUs; the faster clock speed the better
- 8GB RAM
- 200GB of storage (SSD or NVME)

## Installation Running Node Operator

**Update**
```bash
sudo apt-get update && sudo apt-get upgrade -y
```
```bash
sudo apt install git sudo unzip wget -y
```

**Set Firewall Rules**
```bash
sudo ufw allow 25000:25003/tcp
sudo ufw allow 9000/tcp
sudo ufw allow 8545:8547/tcp
sudo ufw allow 25004/udp
sudo ufw allow 22/tcp
sudo ufw allow 3000:3001/tcp
sudo ufw allow 80/tcp
sudo ufw allow 30303/tcp
sudo ufw allow 9000/udp
sudo ufw enable
```

**Install Docker**

``` bash
sudo apt-get install ca-certificates curl gnupg lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
```

**Instal docker-compose**
```bash
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
sudo chown $USER /var/run/docker.sock
```

**Create Local Directory**
```bash
sudo mkdir -p /data/geth
sudo mkdir -p /data/lighthouse
sudo mkdir -p /data/jwt
sudo mkdir -p /data/operator
```
**Generate your JWT secret to JWT dirctory**
```bash
openssl rand -hex 32 | tr -d "\n" | sudo tee /data/jwt/jwtsecret
```

**Clone**
```bash
git clone --recurse-submodules https://github.com/ParaState/SafeStakeOperator.git dvf
```

**Configuration**
```bash
cd dvf
vim .env
```
Type ```ESC``` and ```:wq``` and ```ENTER```

**Build Operator**
```bash
sudo docker compose -f docker-compose-operator.yml build
```

**Run Operator**
```bash
sudo docker compose -f docker-compose-operator.yml up -d
```

**Get Node Public Key**
```bash
sudo docker compose -f docker-compose-operator.yml logs -f operator | grep "node public key"
```

Save your Public Key

**Back Up Operator Key**
```bash
cd /data/operator/ropsten/
nano node_key.json
```

## Register Node Operator

- Open link -> https://testnet.safestake.xyz/
- Connet Wallet with Metamask 
- Change network to Ropsten (Must have 32 rETH for joining Operator)
- Join As Operator
![Safestake](https://user-images.githubusercontent.com/65535542/185357274-9d052234-922d-4ba2-835c-f502f2fc6db8.png)
- Register Operator
    -> Owner Address (Address Metamask)
    
    -> Display Name
    
    -> Operator Key (Enter the key you saved earlier)
    
    -> Done
    
    ![Safestake](https://user-images.githubusercontent.com/65535542/185357496-bf0f2e94-4839-4888-8e4d-c88bdec3497d.png)
    
- Approve with Metamask 
- Done
