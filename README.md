# Flash Loan Simulation with Aave

A starter project for creating a flash loan simulation with Aave and Tenderly SDK. Included are base contract templates, environment setup guides, and instructions on testing using Tenderly's simulation features.

## Overview

This project is a starter kit for developing decentralized applications using Aave's flashloan feature. Flash loans allow users to borrow and repay a loan within a single transaction, enabling unique use-cases such as arbitrage, collateral swapping, self-liquidation, and more. 

## Prerequisites

Before getting started, make sure you have the following:

1. Node.js and npm installed on your local machine.
2. Hardhat or Truffle installed as your Ethereum development framework.
3. Aave protocol forked and cloned on your local machine. You can fork it [here](https://github.com/aave/aave-protocol).

## Getting Started

1. Clone this repository and navigate into it.
2. Install the necessary dependencies using npm install.
3. Create a new .env file in the root directory of the project and add your environment variables.
4. The starter project includes a simple flashloan contract in Solidity. You can find it at /contracts/MyFlashLoanContract.sol. This contract inherits from Aave's FlashLoanReceiverBase.sol and implements the executeOperation function.
5. Replace "path_to_aave/FlashLoanReceiverBase.sol" and "path_to_aave/ILendingPoolAddressesProvider.sol" in FlashLoan.sol with the actual paths to the appropriate Aave contracts in the repository.
6. Implement your own logic in the executeOperation function. This is the code that will be executed as part of the flash loan.
7. Once your contract is ready, you can deploy it to a testnet or mainnet using a tool like Truffle or Hardhat.

## Creating a Flashloan Contract

The starter project includes a simple flashloan contract in Solidity. You can find it at `/contracts/MyFlashLoanContract.sol`. This contract inherits from Aave's `FlashLoanReceiverBase.sol` and implements the `executeOperation` function. 

In the `executeOperation` section is where you'll place your own logic. In our example it's left largely blank for you to fill according to your needs.

## Deploying the Contract

To deploy your contract onto a testnet, follow these steps:

1. Update `scripts/DeployContract.js` with the address of your Aave LendingPoolAddressesProvider on the network you are deploying to.
2. Run the deploy script with `npx hardhat run scripts/DeployContract.js --network <network-name>`

## Simulating Flashloan Transaction with Tenderly SDK

After deploying your contract, you can simulate the flash loan operation using Tenderly's SDK before executing it on-chain. 

*See the official Tenderly SDK documentation [here](https://docs.tenderly.co/tenderly-sdk/tutorials-and-quickstarts/how-to-simulate-transactions-with-tenderly-sdk).*

To do this:

1. Initialize a new Node.js project and install Tenderly's SDK:

    ```
    mkdir tenderly-simulation
    cd tenderly-simulation
    npm init -y
    npm install @tenderly/sdk
    ```

2. Create a new `index.js` file in your project directory and import the Tenderly SDK:

    ```javascript
    const { Tenderly, Network } = require("@tenderly/sdk");
    
    const tenderly = new Tenderly({
      accountName: "your-account-name",
      projectName: "your-project-name",
      accessKey: "your-access-key",
      network: Network.<network>, // Replace with the appropriate network
    });
    ```
Ensure you replace `"your-account-name"`, `"your-project-name"`, `"your-access-key"` and `<network>` with your actual Tenderly account details and the choose the appropriate [network](https://docs.tenderly.co/web3-actions/references/networks) you want to use for this simulation.

3. Define your transaction parameters:
Paste this into the `index.js` file:

    ```javascript
    const transactionParameters = {
      from: "0xYourAccount",
      to: "0xMyFlashLoanContract",
      input: "0xTheEncodedData",
      value: "1000000000000000000",
      gas: 21000,
      gas_price: "20000000000",
    };
    
    const simulationDetails = {
      transaction: transactionParameters,
      blockNumber: 12000000
      override: {}, // Optional state override
    };
    ```
Replace the `from`, `to`, `input`, `value`, `gas`, and `gas_price` fields with your transaction details. The `override` field is optional and allows you to override the state of specific contracts in the simulation. The `input` field is where you'd put your encoded function call for the executeOperation method of your flash loan contract.


4. Run the transaction simulation:
Add this function inot the index.js file: 

    ```javascript
    (async () => {
      try {
        const simulationResult = await tenderly.simulator.simulateTransaction(simulationDetails);
        console.log("Simulation result:", simulationResult);
      } catch (error) {
        console.error("Error running simulation:", error);
      }
    })();
    ```

5. Execute the script:
Once you save the index.js file with the added code, you can run the script using this command:

    ```
    node index.js
    ```

If the simulation is successful, you will see the simulation result printed in the console.

## Conclusion

This starter project provides you with the basic setup for implementing flash loans using the Aave protocol. For a more detailed guide on integrating simulations using Tenderly SDK, please refer to this [blog post](https://medium.com/@brandon_sanchez_MEV/8d273c4fb6a2) on it.

## Disclaimer

This is just a simple starter project. Flash loans are powerful but come with risks, especially around smart contract vulnerabilities and market risks. Audits are recommeneded before putting this to use in real situations. 
