
# INERY TESTNET TASK I
<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

![Inery](https://user-images.githubusercontent.com/65535542/191928956-e06ca9cd-a640-4553-aeb4-ac9706a3b810.png#/)


A brief description of what this project does and who it's for


## Persyaratan Hardware

- Memory: 8 GB RAM
- CPU: 4 Core
- Disk: 250 GB SSD Storage
- Bandwidth: 1 Gbps buat Download/100 Mbps buat Upload

## Unlock your wallet first
```bash
  cline wallet unlock -n YourWalletName
```
change YourWalletName to your wallet name (it may default or wallet or something like that), and than YourAccountName on below with your account name

## Getting token abi and wasm file
```
cline get code inery.token -c token.wasm -a token.abi --wasm
```
this generate 2 file on /root folder, token.wasm and token.abi


## Set wasm code to your account
```
cline set code -j YourAccountName token.wasm
```

## Set abi code to your account
```
cline set abi YourAccountName token.abi
```

## Create New Token
```
cline push action inery.token create '["YourAccountName", "50000.0000 TEST" , "creating my first tokens"]' -p YourAccountName
```

## Issue Your New Token
```
cline push action inery.token issue '["YourAccountName", "5000.0000 TEST", "Issuing some TEST token"]' -p YourAccountName
```

## Transfer to another account
```
cline push action inery.token transfer '["YourAccountName", "DestinationWalletName", "Amount CurrencyCode", "Here you go 1 TEST for free :) "]' -p YourWalletName
```

## -------- example: send some tokens to 10 different accounts.
```
cline push action inery.token transfer '["YourAccountName", "jisoo", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "alfonova", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "dexa", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "jambul.inery", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "riandwiyandi", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "armz", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "asphxwzrd", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "away", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "bintangnl", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountName
cline push action inery.token transfer '["YourAccountName", "blacktokyoo", "1.0000 TEST", "Here Is 1 TEST for you bro "]' -p YourAccountNam
```