
# Mina ZkSpark Testnet Installation Guide Oracle

<p style="font-size:14px" align="left">
<a href="https://t.me/airdropsultanindonesia" target="_blank">Join to Channel Airdrop Sultan Indonesia</a>
</p>

<p align="center">
  <img style="margin: auto; height: 100px; border-radius: 50%;" src="https://user-images.githubusercontent.com/65535542/204086832-c698476d-870f-4540-98ca-ac12b2379548.png">
</p>

## Create Project

```bash
zk project oracle
```

Create repo di github kalian namain oracle harus sama dengan di project zk


```bash
cd oracle
```

```bash
  git remote add origin <your-repo-url>
```

```bash
 git push -u origin main
 ```


Delete  Files
```bash
rm src/Add.ts
rm src/Add.test.ts
rm src/interact.ts
```

```bash
cd src
```

```bash
nano index.ts
```

```bash
import { OracleExample } from './OracleExample.js';

export { OracleExample };
```

Build CreditScoreOracle

```bash
zk file CreditScoreOracle
```

```bash
nano CreditScoreOracle.ts
```

Paste Command ini 

```bash
import {
    Field,
    SmartContract,
    state,
    State,
    method,
    DeployArgs,
    Permissions,
    PublicKey,
    Signature,
    PrivateKey,
  } from 'snarkyjs';
  
  // The public key of our trusted data provider
  const ORACLE_PUBLIC_KEY =
    'B62qoAE4rBRuTgC42vqvEyUqCGhaZsW58SKVW4Ht8aYqP9UTvxFWBgy';
  
  export class OracleExample extends SmartContract {
    // Define contract state
    @state(PublicKey) oraclePublicKey = State<PublicKey>();
  
    // Define contract events
    events = {
        verified: Field,
      };
  
    deploy(args: DeployArgs) {
      super.deploy(args);
      this.setPermissions({
        ...Permissions.default(),
        editState: Permissions.proofOrSignature(),
      });
    }
  
    @method init(zkappKey: PrivateKey) {
      super.init(zkappKey);
      // Initialize contract state
      this.oraclePublicKey.set(PublicKey.fromBase58(ORACLE_PUBLIC_KEY));
  
      // Specify that caller should include signature with tx instead of proof
      this.requireSignature();
    }
  
    @method verify(id: Field, creditScore: Field, signature: Signature) {
      // Get the oracle public key from the contract state
      const oraclePublicKey = this.oraclePublicKey.get();
      this.oraclePublicKey.assertEquals(oraclePublicKey);
  
      // Evaluate whether the signature is valid for the provided data
      const validSignature = signature.verify(oraclePublicKey, [id, creditScore]);
  
      // Check that the signature is valid
      validSignature.assertTrue();
  
      // Check that the provided credit score is greater than 700
      creditScore.assertGte(Field(700));
  
      // Emit an event containing the verified users id
      this.emitEvent('verified', id);
  
    }
  }
  ```

  Save `CTRL X+Y`

Create File OracleExampleScaffold

```bash
zk file OracleExampleScaffold
```

```bash
nano OracleExampleScaffold.ts
```

Paste command dibawah ke OracleExampleScaffold.ts

```bash
import {
Field,
SmartContract,
state,
State,
method,
DeployArgs,
Permissions,
PublicKey,
Signature,
PrivateKey,
} from 'snarkyjs';

// The public key of our trusted data provider
const ORACLE_PUBLIC_KEY =
'B62qoAE4rBRuTgC42vqvEyUqCGhaZsW58SKVW4Ht8aYqP9UTvxFWBgy';

export class OracleExample extends SmartContract {
// Define contract state

// Define contract events

deploy(args: DeployArgs) {
  super.deploy(args);
  this.setPermissions({
    ...Permissions.default(),
    editState: Permissions.proofOrSignature(),
  });
}

@method init(zkappKey: PrivateKey) {
  super.init(zkappKey);
  // Initialize contract state

  // Specify that caller should include signature with tx instead of proof
  this.requireSignature();
}

@method verify(id: Field, creditScore: Field, signature: Signature) {
  // Get the oracle public key from the contract state

  // Evaluate whether the signature is valid for the provided data

  // Check that the signature is valid

  // Check that the provided credit score is greater than 700

  // Emit an event containing the verified users id
  
}
}
```

Create OracleExample


```bash
zk file OracleExample
```

```bash
nano OracleExample.ts
```

Paste command dibawah masukan ke OracleExample.ts

```bash
import {
  Field,
  SmartContract,
  state,
  State,
  method,
  DeployArgs,
  Permissions,
  PublicKey,
  Signature,
  PrivateKey,
} from 'snarkyjs';

// The public key of our trusted data provider
const ORACLE_PUBLIC_KEY =
  'B62qoAE4rBRuTgC42vqvEyUqCGhaZsW58SKVW4Ht8aYqP9UTvxFWBgy';

export class OracleExample extends SmartContract {
  // Define contract state
  @state(PublicKey) oraclePublicKey = State<PublicKey>();

  // Define contract events
  events = {
    verified: Field,
  };

  deploy(args: DeployArgs) {
    super.deploy(args);
    this.setPermissions({
      ...Permissions.default(),
      editState: Permissions.proofOrSignature(),
    });
  }

  @method init(zkappKey: PrivateKey) {
    super.init(zkappKey);
    // Initialize contract state
    this.oraclePublicKey.set(PublicKey.fromBase58(ORACLE_PUBLIC_KEY));
    // Specify that caller should include signature with tx instead of proof
    this.requireSignature();
  }

  @method verify(id: Field, creditScore: Field, signature: Signature) {
    // Get the oracle public key from the contract state
    const oraclePublicKey = this.oraclePublicKey.get();
    this.oraclePublicKey.assertEquals(oraclePublicKey);
    // Evaluate whether the signature is valid for the provided data
    const validSignature = signature.verify(oraclePublicKey, [id, creditScore]);
    // Check that the signature is valid
    validSignature.assertTrue();
    // Check that the provided credit score is greater than 700
    creditScore.assertGte(Field(700));
    // Emit an event containing the verified users id
    this.emitEvent('verified', id);
  }
}
```

Terus isi form yang Oracle => https://fisz9c4vvzj.typeform.com/zkSpark#discordid=xxxxx
