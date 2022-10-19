# Update PEERS INERY

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![ineryyy](https://user-images.githubusercontent.com/65535542/191928956-e06ca9cd-a640-4553-aeb4-ac9706a3b810.png#/)



## Stop Your Node First

```bahs
cd inery-node/inery.setup/master.node/
```

## Edit max number of clients

```bash
cd inery-node/inery.setup/master.node/blockchain/config/
```

```bash
nano config.ini
```
change 25 client to 100 ```CTRL X and Y``` ENTER

![editmax](https://user-images.githubusercontent.com/65535542/196740276-9bfa21db-6c6b-4075-9fe0-a081f14fbb52.png/)

## Add Peer Address With Command

```bash
nano start.sh
```

![copastpeers](https://user-images.githubusercontent.com/65535542/196742424-7e6b5180-6a94-4120-92c5-a4002c4798c0.png/)
Copy paste new peers under last peers

```bash
--p2p-peer-address 193.111.198.52:9010 \
--p2p-peer-address 62.210.245.223:9010 \
--p2p-peer-address 185.144.99.30:9010 \
--p2p-peer-address 38.242.153.15:9010 \
--p2p-peer-address 75.119.150.78:9010 \
--p2p-peer-address 192.46.226.189:9010 \
--p2p-peer-address 167.235.151.209:9010 \
--p2p-peer-address 65.109.31.7:9010 \
--p2p-peer-address 176.57.184.191:9010 \
--p2p-peer-address 144.91.99.67:9010 \
--p2p-peer-address 167.235.3.147:9010 \
--p2p-peer-address 194.163.168.237:9010 \
--p2p-peer-address 65.109.31.7:9010 \
--p2p-peer-address  45.84.138.118:9010 \
--p2p-peer-address 185.249.225.183:9010 \
--p2p-peer-address 38.242.235.150:9010 \
--p2p-peer-address 20.213.8.11:9010 \
--p2p-peer-address  161.97.153.16:9010::9010 \
--p2p-peer-address   45.84.138.209:9010 \
--p2p-peer-address  38.242.248.157:9010 \
--p2p-peer-address 45.88.188.199:9010 \
--p2p-peer-address 185.170.113.8:9010 \
--p2p-peer-address 5.189.138.167:9010 \
--p2p-peer-address 38.242.234.139:9010 \
--p2p-peer-address 86.48.0.180:9010 \
--p2p-peer-address 185.169.252.86:9010 \
--p2p-peer-address 185.207.250.86:9010 \
--p2p-peer-address 38.242.130.28:9010 \
--p2p-peer-address 95.217.134.209:9010 \
--p2p-peer-address 78.46.123.82:9010 \
--p2p-peer-address 161.97.153.16:9010 \
--p2p-peer-address 38.242.154.67:9010 \
--p2p-peer-address 45.10.154.235:9010 \
--p2p-peer-address 45.84.138.8:9010 \
--p2p-peer-address 45.84.138.118:9010 \
--p2p-peer-address 38.242.248.157:9010 \
--p2p-peer-address 45.84.138.209:9010 \
--p2p-peer-address 95.217.236.223:9010 \
--p2p-peer-address 86.48.2.195:9010 \
--p2p-peer-address 135.181.254.255:9010 \
--p2p-peer-address 5.161.118.114:9010 \
--p2p-peer-address 78.47.159.172:9010 \
--p2p-peer-address 45.10.154.239:9010 \
--p2p-peer-address 45.84.138.9:9010 \
--p2p-peer-address 194.163.172.119:9010 \
--p2p-peer-address 45.84.138.119:9010 \
--p2p-peer-address 45.84.138.153:9010 \
--p2p-peer-address 130.185.118.73:9010 \
--p2p-peer-address 45.84.138.247:9010 \
--p2p-peer-address 185.202.238.240:9010 \
--p2p-peer-address 194.163.161.151:9010 \
--p2p-peer-address 65.109.15.147:9010 \
--p2p-peer-address 80.65.211.208:9010 \
--p2p-peer-address 149.102.140.38:9010 \
--p2p-peer-address 38.242.149.97:9010 \
--p2p-peer-address 38.242.156.49:9010 \
--p2p-peer-address 78.187.25.69:9010 \
--p2p-peer-address 212.68.44.36:9010 \
--p2p-peer-address 38.242.159.125:9010 \
--p2p-peer-address 77.92.132.67:9010 \
--p2p-peer-address 20.213.8.11:9010 \
--p2p-peer-address 74.208.142.87:9010 \
--p2p-peer-address 38.242.235.150:9010 \
--p2p-peer-address 65.108.82.31:9010 \
--p2p-peer-address 10.182.0.15:9010 \
--p2p-peer-address 185.249.225.183:9010 \
--p2p-peer-address 167.235.141.121:9010 \
--p2p-peer-address 194.163.162.47:9010 \
--p2p-peer-address 88.198.164.163:9010 \
--p2p-peer-address 193.46.243.16:9010 \
--p2p-peer-address 38.242.159.140:9010 \
--p2p-peer-address 149.102.143.144:9010 \
--p2p-peer-address 161.97.169.27:9010 \
--p2p-peer-address 38.242.219.100:9010 \
--p2p-peer-address bis.blockchain-servers.world \
--p2p-peer-address 193.111.198.52 \
--p2p-peer-address 62.210.245.223 \
--p2p-peer-address 185.144.99.30 \
--p2p-peer-address 38.242.153.15 \
--p2p-peer-address 192.46.226.189 \
--p2p-peer-address 194.5.152.187 \
```
## Run your nodes again


```bash
./hard_replay.sh
```

```bash
screen -Rd inery
```
or your own screen name

![recover](https://user-images.githubusercontent.com/65535542/196742424-7e6b5180-6a94-4120-92c5-a4002c4798c0.png/)
Succer Recover Wait for receiving blocks

![donerecobver](https://user-images.githubusercontent.com/65535542/196742424-7e6b5180-6a94-4120-92c5-a4002c4798c0.png/)
This is when it has recovered
