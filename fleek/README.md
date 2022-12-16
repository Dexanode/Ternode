
# Guide Installation Fleek Node

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/208038501-fa6a8c6b-3702-468d-af7f-55c8f26f827a.png">
</p>

## Requirements Hardware

| Component | Recomendation Spec |
|----------|---------------------|
|CPU|32 Cores|
|RAM|32 GB DDR4 RAM|
|Storage|2 x 1 TB NVMe SSD|
|Connection|1 Gbit/s port|
|OS|Ubuntu 20.04|

## Setup

Install `screen` dan `wget`
  ```bash
  apt-get install screen wget
  ```

Download script `run.sh`
  ```bash
  rm run.sh
  wget -q https://raw.githubusercontent.com/nadi555/Ternode/main/fleek/run.sh
  ```

Change `run.sh` to executable
  ```bash
  chmod +x run.sh
  ```

Open a new terminal using `screen`
  ```bash
  screen -Rd fleek
  ```

After new terminal is open, run the script
Running script
 
```bash
  ./run.sh
  ```

### Setup Manual

Update apt
  ```bash
  sudo apt-get update
  sudo apt-get upgrade
  ```

Instal `rust`
  ```bash
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  ```

  > If there is a prompt, just press Enter
Load environment variable `rust`
  ```bash
  source "$HOME/.cargo/env"
  ```

Check is rust already installed
  ```bash
  cargo --version
  ```

  If `rust` is installed then the following output will appear in the terminal
  
```bash
  cargo 1.65.0 (4bc8f24d3 2022-10-20)
  ```
(OPTIONAL) Instal `scchace`
  ```bash
  cargo install sccache
  ```

Instal dependensi Linux
  ```bash
  sudo apt-get install build-essential git curl screen cmake clang pkg-config libssl-dev protobuf-compiler
  ```

Instal `Docker`
  ```bash
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
  ```

Open Terminal using `screen`
  ```bash
  screen -Rd fleek
  ```
  > After the new terminal is open, proceed to the next step

Download `Ursa-cli`
  ```bash
  git clone https://github.com/fleek-network/ursa.git
  ```

Go to folder `ursa`
  ```bash
  cd ursa
  ```

Update Makefile
  ```bash
  rm Makefile
  wget -q https://raw.githubusercontent.com/nadi555/Ternode/main/fleek/makefile
  ```

Instal `Ursa-cli`
  ```bash
  make install
  ```

Cek apakah `Ursa-cli` sudah terinstal
  ```bash
  ursa-cli --help
  ```

Build container `Docker`
  ```bash
  make docker-build
  ```

Running container `Docker`
  ```bash
  make docker-run
  ```
