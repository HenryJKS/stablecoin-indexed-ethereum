The HJKStableCoin contract is a stablecoin implementation indexed to the price of ETH using Chainlink's ETH/USD price feed. This stablecoin is pegged to the value of ETH, meaning that 1 ETH will mint a proportional amount of HSC tokens (HJKStableCoin), determined by the current ETH/USD rate.

The contract includes the following features:

- Users can deposit ETH to mint HSC.
- Users can burn HSC to redeem ETH based on the current ETH price.
- A time-locked initial mint is performed for the contract owner.
- Price data is fetched from Chainlink's decentralized oracle network for secure price information.
- Ownership can be transferred but not renounced for security purposes.


## Prerequisites
- **Before** deploying and interacting with this contract, you will need:
- **Truffle** Suite for development and deployment of Ethereum smart contracts.
- **Node.js** and npm to install required dependencies.
- **Ganache** for a local Ethereum blockchain, or access to an Ethereum testnet (like Rinkeby or Goerli).
- **MetaMask** for managing accounts and sending transactions.

