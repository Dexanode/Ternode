
# INERY TESTNET TASK III
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

## Update 
```bash
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y make bzip2 automake libbz2-dev libssl-dev doxygen graphviz libgmp3-dev \
autotools-dev libicu-dev python2.7 python2.7-dev python3 python3-dev \
autoconf libtool curl zlib1g-dev sudo ruby libusb-1.0-0-dev \
libcurl4-gnutls-dev pkg-config patch llvm-7-dev clang-7 vim-common jq libncurses5 git
```

## Unlock your wallet first
```bash
  cline wallet unlock -n YourWalletName
```
use password in ```.txt```

Go to inery setup folder

```bash
cd inery-node/inery.setup
```

change app permission

```bash
chmod +x ine.py
```

export path to local os environment for inery binaries

```bash
./ine.py --export
```
refresh path variable
```bash
cd; source .bashrc; cd -
```

## Get binary inery.cdt tools

```bash
git clone https://github.com/inery-blockchain/inery.cdt
```

Set as env vars
```bash
export PATH=$PATH:$HOME/inery.cdt/bin/
```

or permanents vars
```bash
export PATH=$PATH:$HOME/inery.cdt/bin/ >> $HOME/.bash_profile
source $HOME/.bash_profile
```


## Write and compile contract

Setup compilation

```bash
nano inrcrud.cpp
```

```bash
#include <inery/inery.hpp>
#include <inery/print.hpp>
#include <string>

using namespace inery;

using std::string;

class [[inery::contract]] inrcrud : public inery::contract {
  public:
    using inery::contract::contract;


        [[inery::action]] void create( uint64_t id, name user, string data ) {
            records recordstable( _self, id );
            auto existing = recordstable.find( id );
            check( existing == recordstable.end(), "record with that ID already exists" );
            check( data.size() <= 256, "data has more than 256 bytes" );

            recordstable.emplace( _self, [&]( auto& s ) {
               s.id         = id;
               s.owner      = user;
               s.data       = data;
            });

            print( "Hello, ", name{user} );
            print( "Created with data: ", data );
        }

         [[inery::action]] void read( uint64_t id ) {
            records recordstable( _self, id );
            auto existing = recordstable.find( id );
            check( existing != recordstable.end(), "record with that ID does not exist" );
            const auto& st = *existing;
            print("Data: ", st.data);
        }

        [[inery::action]] void update( uint64_t id, string data ) {
            records recordstable( _self, id );
            auto st = recordstable.find( id );
            check( st != recordstable.end(), "record with that ID does not exist" );


            recordstable.modify( st, get_self(), [&]( auto& s ) {
               s.data = data;
            });

            print("Data: ", data);
        }

            [[inery::action]] void destroy( uint64_t id ) {
            records recordstable( _self, id );
            auto existing = recordstable.find( id );
            check( existing != recordstable.end(), "record with that ID does not exist" );
            const auto& st = *existing;

            recordstable.erase( st );

            print("Record Destroyed: ", id);

        }

  private:
    struct [[inery::table]] record {
       uint64_t        id;
       name     owner;
       string          data;
       uint64_t primary_key()const { return id; }
    };

    typedef inery::multi_index<"records"_n, record> records;
 };

```
Copy and Paste Final Contract, and ```CTRL X enter Y``` done final contract save

Create Directory

```bash
 mkdir inrcrud
 mv inrcrud.cpp inrcrud
 cd inrcrud
 ```

Copy file ```inery-cpp``` to directory inrcrud

```bash
cp -r ~/inery.cdt/bin/inery-cpp ~/inrcrud/
```

Comile It

```bash
 inery-cpp inrcrud.cpp -o inrcrud.wasm
 ```

Set Contract
```bash
cline set contract AccountName $HOME/inrcrud -p AccountName
```

### Make push contract transaction

Create action
```bash
cline push action AccountName create "[1, AccountName, My first Record]" -p AccountName -j
```

Read Action
```bash
cline push action AccountName read [1] -p AccountName -j
```

Update Action
```bash
cline push action AccountName update '[ 1,  "My first Record Modified"]' -p AccountName -j
```

Check the changes
```bash
cline push action AccountName read [1] -p AccountName
```

Delete element from table

```bash
cline push action AccountName destroy [1] -p AccountName
```

Check if element with id = 1 exist

```bash
cline push action AccountName read [1] -p AccountName
```
