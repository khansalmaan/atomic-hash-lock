
1️⃣ Atomic Cross-Chain Swaps (Interoperability)
🔗 Trade assets between different blockchains without a trusted third party.

Example:
Alice (Ethereum) wants to exchange ETH for Bob’s BTC on Bitcoin.
They both deploy HTLC contracts on Ethereum and Bitcoin.
Alice locks ETH in the Ethereum HTLC using hashLock.
Bob locks BTC in the Bitcoin HTLC using the same hashLock.
Bob reveals the preimage to claim ETH.
Alice uses the same preimage to claim BTC on Bitcoin.
If either party doesn’t complete the swap, they get refunded after expiration.
💡 Benefit: Trustless cross-chain trading, no intermediaries.

🛠 Extended Idea: Modify the contract to support ERC-20 tokens for token-based cross-chain swaps.

# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a Hardhat Ignition module that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js
```

