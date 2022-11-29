
# Manta The Manta Network Trusted Setup Is Now Open for Contributions

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/204483961-992f1e39-ae50-4c03-b528-ee32a2563640.jpg">
</p>

## Installation and Register

```bash
source ~/.profile
```

```bash
curl --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/Manta-Network/manta-rs/main/tools/install.sh | sh
```

```bash
manta-trusted-setup register
```
<p align="center">
  <img src="[https://user-images.githubusercontent.com/65535542/204483961-992f1e39-ae50-4c03-b528-ee32a2563640.jpg](https://user-images.githubusercontent.com/65535542/204484297-ba3881a3-7af9-40fe-89c4-ba44c0af7119.png
)">
</p>


![manta2](https://user-images.githubusercontent.com/65535542/204484297-ba3881a3-7af9-40fe-89c4-ba44c0af7119.png)

Save Pharse kalian dan juga isi formnya jangan lupa buat dapetin rewardnya

- Cara dapetin address Calamari
- Pergi ke https://polkadot.js.org/apps/#/settings/metadata
- Ganti chainnya yang di menu drop-down sebelah kiri, cari Calamari chain terus switch
- Ke menu setting terus update metadata
- Balik ke wallet polkadot, klik yang titik 3 terus ganti chain ke Calamari Parachain
- Done dapet address Calamary depannya 'dmw'

## Run Contributor

```bash
 sudo apt update
```

```bash
sudo apt install pkg-config build-essential libssl-dev curl jq
```

Install Rust

```bash
curl https://sh.rustup.rs/ -sSf | sh -s -- -y
```

## Setting Path
```bash
source $HOME/.cargo/env
```

## Install Manta-RS

```bash
git clone https://github.com/Manta-Network/manta-rs.git
```

## Screen

```bash
screen -S manta
```
```bash
cd manta-rs

```bash
cargo run --release --all-features --bin groth16_phase2_client contribute
```

- Masukan Pharse pas saat registrasi
- Tunggui sampe beres running
- Done

## Other Command 

Masuk Ke Screen
```bash
screen -Rd manta
```

Hapus Directory
```bash
rm -rf manta-rs
```



