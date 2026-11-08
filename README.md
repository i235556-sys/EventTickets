# EventTickets dApp

**Okasha Saeed | 23i-5556**
MG3012 Blockchain Technology for Business, Assignment 2 (Fall 2026)

EventTickets is a small ticket booking dApp for an event called FinTech Night 2026. A user connects MetaMask, pays the ticket price in SepoliaETH and gets a seat number that is stored in the smart contract. Seats are limited to 50, each wallet can book only one ticket, and only the organiser (the wallet that deployed the contract) can withdraw the money collected.

## Contract address

**Sepolia:** `0x0C801b6FdD5124A49A27B8D83134e13b567ee06b`

Etherscan: https://sepolia.etherscan.io/address/0x0C801b6FdD5124A49A27B8D83134e13b567ee06b

## Files

| File | What it is |
|---|---|
| SmartContract.sol | The Solidity contract (EventTickets) |
| index.html | Frontend page, uses ethers.js v6 to talk to the contract |
| style.css | Styling for the page |
| screenshots/ | Deployment and MetaMask interaction screenshots |

## Smart contract functions

| Function | Type | What it does |
|---|---|---|
| buyTicket() | write, payable | Books a seat. You must send exactly 0.001 ETH, the event must not be sold out and you can't book twice |
| withdrawFunds() | write | Sends the collected ETH to the organiser. Only the owner can call it |
| getEventDetails() | read | Returns event name, venue, date, ticket price, tickets sold and total seats |
| getTicket(address) | read | Returns the seat number of a wallet (0 means no ticket) |
| getAttendees() | read | Returns the list of wallets that booked |

There are also two events, `TicketBought` and `FundsWithdrawn`, so every booking and withdrawal shows up in the transaction logs on Etherscan.

## How to run it

1. Install MetaMask and switch to the **Sepolia** test network. Get free SepoliaETH from a faucet, for example https://cloud.google.com/application/web3/faucet/ethereum/sepolia
2. Open https://remix.ethereum.org, make a file called `SmartContract.sol` and paste the contract.
3. Go to the **Solidity Compiler** tab, pick version 0.8.20 or newer and click **Compile**.
4. Go to **Deploy & Run Transactions**, set the environment to **Injected Provider (MetaMask)**, select `EventTickets` and click **Deploy**. Confirm in MetaMask.
5. Copy the deployed contract address from Remix and paste it in `index.html` here:
   `const CONTRACT_ADDRESS = "0x0C801b6FdD5124A49A27B8D83134e13b567ee06b";`
6. Open `index.html` with a local server (I used Live Server in VS Code). MetaMask does not always inject into pages opened directly as a file.
7. Click **Connect MetaMask**, then **Buy ticket** and confirm the payment. Your ticket with its seat number appears under My ticket.

## Frontend features

* Connect MetaMask and automatic switch to Sepolia if you are on another network
* Event card with venue, date, price, seats left and a progress bar
* Buy ticket button that sends the exact price with the transaction
* A ticket card with your seat number once you have booked
* Live attendee list
* Organiser panel (only visible to the owner wallet) that shows the money collected and a withdraw button
* Transaction status with block number, gas used and a link to the transaction on Etherscan
* Page reloads when you change account or network in MetaMask

## Screenshots

1. `screenshots/1_deployment.png` contract deployed from Remix
2. `screenshots/2_connected.png` MetaMask connected to the page
3. `screenshots/3_transaction.png` ticket bought and transaction confirmed

## Tools used

Solidity, Remix IDE, MetaMask, Sepolia testnet, ethers.js v6, HTML, CSS and JavaScript.
