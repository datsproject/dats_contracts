# Dats Desktop Contracts

Smart contracts for the Dats Desktop project, built with Solidity and Hardhat. This repository contains on-chain logic for user resource preferences and a wrapped native token (DATS) with mint/burn and native-coin swap support.

---

## Contracts Overview

The `contracts/` directory contains the following Solidity contracts:

| Contract | Description |
|----------|-------------|
| **DatsContract.sol** | Lightweight contract that stores **DDoS** preferences per user. Users can save approval status and traffic scale; the owner can retrieve all users’ DDoS settings. |
| **DatsContractFull.sol** | Full-featured contract that stores multiple resource types per user: **DDoS**, **SuperComputer** (CPU), **CyberSecurity** (web/server security, ransomware/malware research), **Vulnerability** (web/server/SCADA/blockchain/contract penetration), **Blockchain** (attack prevention), and **GPU**. Each resource has save/get/count functions and owner-only “get all users” views; state changes emit events. |
| **DatsNativeMinter.sol** | ERC20 token **DATS** with 18 decimals. Owner can mint and burn. Users can **deposit** native gas coins to receive DATS and **mintdraw** to burn DATS and receive native coins (via the chain’s Native Minter precompile). |
| **IAllowList.sol** | Interface for an allow-list: set admin, set enabled, set none, and read status for an address. |
| **INativeMinter.sol** | Interface extending `IAllowList` that adds `mintNativeCoin(addr, amount)` for the native minter precompile. |

- **DatsContract** vs **DatsContractFull**: Use `DatsContract` when only DDoS settings are needed; use `DatsContractFull` when SuperComputer, CyberSecurity, Vulnerability, Blockchain, and GPU settings are also required.
- **DatsNativeMinter** is intended for chains that provide a Native Minter precompile (e.g. Avalanche C-Chain style); the precompile address is set inside the contract.

---

# Node.js Setup

```bash
node -v
```

If Node.js is not installed on your machine, you can download a suitable version from [here](https://nodejs.org/en/download/), or follow the [Hardhat-recommended](https://hardhat.org/tutorial/setting-up-the-environment.html) setup and update instructions.

<br/>

# Hardhat Development Environment Setup

* [Hardhat Documentation](https://hardhat.org/getting-started/)
* [Ethers Documentation](https://docs.ethers.io/v5/)
* [Waffle Documentation](https://ethereum-waffle.readthedocs.io/en/latest/index.html)

### Initialize Node Project
```bash
npm init --yes
```

### Install Hardhat
```bash
npm install --save-dev hardhat
```

### Run Hardhat and Choose Project Structure
```bash
npx hardhat
```

### Install Required Plugins ([Ethers.js](https://docs.ethers.io/v5/), [Waffle](https://ethereum-waffle.readthedocs.io/en/latest/index.html))
```bash
npm install --save-dev @nomiclabs/hardhat-ethers ethers @nomiclabs/hardhat-waffle ethereum-waffle chai
```

### Prepare `hardhat.config.js`
```javascript
// require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-waffle");

const PRIVATE_KEY = "PRIVATE_KEY";

module.exports = {
  solidity: "0.8.2",
  networks: {
    mainnet: {
      url: `https://api.avax.network/ext/bc/C/rpc`,
      accounts: [`${PRIVATE_KEY}`]
    },
    fuji: {
      url: `https://api.avax-test.network/ext/bc/C/rpc`,
      accounts: [`${PRIVATE_KEY}`]
    }
  }
};
```

### Directory Structure
```
boilerplate/
├── hardhat.config.js
├── package.json
├── package-lock.json
├── node_modules
├── contracts/
├── test/
└── scripts/
```

### Compile
```bash
npx hardhat compile
```

### Using OpenZeppelin Contracts
```bash
npm install @openzeppelin/contracts
```

### Run Tests
```bash
npx hardhat test
```

### Deploy Contracts
```bash
npx hardhat run <deploy-script-path>

npx hardhat run <deploy-script-path> --network <network-name>

npx hardhat run scripts/deploy.js --network fuji
```

<br/>

# Helper Functions

### Chai Helpers

```javascript
await expect(token.transfer(walletTo.address, 1007)).to.be.reverted;

expect('0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B').to.be.properAddress;
expect(token).to.not.be.undefined;

expect(token.balanceOf("0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B")).to.be.equal(0);

expect(token.balanceOf("0xAb5801a7D398351b8bE11C439e05C5B3259aeC9B")).to.be.greaterThan(0);
```

### Ethers Helpers

```javascript
await ethers.getContractFactory("Token");
await ethers.getSigners();
ethers.utils.parseEther("100");
ethers.utils.parseUnits("100", 18);
ethers.utils.formatEther("1000000000000000000");
ethers.utils.formatUnits("100", 2);
ethers.constants.MaxUint256;

const provider = ethers.provider;
block_number = await provider.getBlockNumber();
await provider.getBlock(block_number);
block_timestamp = block.timestamp;
```

Note: [Ethers Playground](https://playground.ethers.org/)
