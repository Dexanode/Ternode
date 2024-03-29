<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img height="100" height="auto" src="https://user-images.githubusercontent.com/50621007/174559198-c1f612e5-bba2-4817-95a8-8a3c3659a2aa.png">
</p>

# Sui node setup for devnet (not incentived for devnet)

Docs Official :https://github.com/MystenLabs/sui/blob/main/doc/src/build/fullnode.md

Check you node health: https://node.sui.zvalid.com/

## Minimum hardware requirements
- CPU: 2 CPU
- Memory: 4 GB RAM
- Disk: 50 GB SSD Storage

## Recommended hardware requirements
- CPU: 2 CPU
- Memory: 8 GB RAM
- Disk: 50 GB SSD Storage

> Storage requirements will vary based on various factors (age of the chain, transaction rate, etc) although we don't anticipate running a fullnode on devnet will require more than 50 GBs today given it is reset upon each release roughly every two weeks.

## Upgrade your dependecies and package
```
sudo apt-get upgrade && sudo apt-get update -y
```

## (OPTIONAL) Installation takes more than 10 minutes, so we recommend to run in a screen session
To create new screen session named `sui`
```
screen -S sui
```

To attach to existing `sui` screen session
```
screen -Rd sui
```

## Set up your Sui full node
### Option 1 (automatic)

You can setup sui full node in mode sat set in script below
```
wget -q -O sui.sh https://raw.githubusercontent.com/nadi555/Ternode/main/sui/sui.sh && chmod +x sui.sh && sudo /bin/bash sui.sh
```
# Afer Installation
## Check status of your node
```
curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json' -d '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' | jq .result.info
```

You should see something similar in the output:
```
json
{
  "title": "Sui JSON-RPC",
  "description": "Sui JSON-RPC API for interaction with the Sui network gateway.",
  "contact": {
    "name": "Mysten Labs",
    "url": "https://mystenlabs.com",
    "email": "build@mystenlabs.com"
  },
  "license": {
    "name": "Apache-2.0",
    "url": "https://raw.githubusercontent.com/MystenLabs/sui/main/LICENSE"
  },
  "version": "0.1.0"
}
```

## Post installation
After setting up your Sui node you have to register it in the [Sui Discord](https://discord.gg/cNpeyrmq):
1) navigate to `#📋node-ip-application` channel
2) post your node endpoint url
```
http://<NODE_IP>:9000/
```

## Check your node health status
Enter your node IP into https://node.sui.zvalid.com/

Healthy node should look like this:

![image](https://user-images.githubusercontent.com/50621007/175829451-a36d32ff-f30f-4030-8875-7ffa4e999a24.png)

## Update Sui Fullnode version
```
wget -qO update.sh https://raw.githubusercontent.com/nadi555/Ternode/main/sui/update.sh && chmod +x update.sh && ./update.sh
```

## (OPTIONAL) Update configs
```
wget -qO update-configs.sh https://raw.githubusercontent.com/nadi555/Ternode/main/sui/update-config.sh && chmod +x update-configs.sh && ./update-configs.sh
```

## Usefull commands
Check sui node status
```
service suid status
```

Check node logs
```
journalctl -u suid -f -o cat
```

Delete node :
```
sudo systemctl stop suid
sudo systemctl disable suid
sudo rm -rf ~/sui /var/sui/
sudo rm /etc/systemd/system/suid.service
```

