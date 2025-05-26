
# CrowdfundingCampaign Smart Contract

Tansaction HASH :0xcb73df80e98e5c39086635778da24d294de91028f4a0472b8c4d9cd309472f95

URL: ![image](https://github.com/user-attachments/assets/507743ef-37c8-446e-b4b4-106779db6803)


A simple and secure Ethereum-based crowdfunding smart contract built with Solidity. This contract allows users to contribute ETH to a campaign with a funding goal and deadline. If the goal is met by the deadline, the campaign creator can withdraw the funds. Otherwise, contributors can claim a refund.

## 🚀 Features

* Fundraising with a target goal and time-based deadline
* Secure contribution tracking
* Owner-only fund withdrawal after success
* Refunds for contributors if the goal is not met
* Event logging for all major actions

## 🧾 Contract Details

### State Variables

* `owner`: Address of the campaign creator
* `goal`: Target amount to raise in wei
* `deadline`: Timestamp when the campaign ends
* `totalRaised`: Total ETH raised
* `fundsWithdrawn`: Boolean indicating if the owner has withdrawn funds
* `contributions`: Mapping of contributor address to amount contributed

### Events

* `ContributionReceived(address indexed contributor, uint amount)`
* `FundsWithdrawn(uint amount)`
* `RefundIssued(address indexed contributor, uint amount)`

### Modifiers

* `onlyOwner`: Restricts function to the campaign creator
* `campaignActive`: Only callable before the deadline
* `campaignEnded`: Only callable after the deadline

## 📦 Functions

### `constructor(uint _goal, uint _durationInDays)`

Deploys a new campaign.

* `_goal`: ETH goal in wei
* `_durationInDays`: Number of days until the deadline

### `contribute() payable`

Contribute ETH to the campaign while it is active.

### `withdrawFunds() external onlyOwner`

Allows the campaign owner to withdraw raised funds if the goal is met after the deadline.

### `claimRefund() external`

Allows contributors to reclaim their ETH if the goal was not reached by the deadline.

### `getTimeLeft() external view returns (uint)`

Returns the time left in seconds until the campaign ends.

## 🛠 Deployment

You can deploy this contract using tools like **Remix**, **Hardhat**, or **Foundry**.

Example (in Hardhat):

```bash
npx hardhat compile
npx hardhat run scripts/deploy.js --network <network-name>
```

## ✅ To Do / Ideas for Improvement

* Add campaign metadata: title, description, image
* Limit max/min contribution amounts
* Add unit testing (e.g., with Hardhat)
* Create frontend (React + Ethers.js or Web3.js)
* Integrate with IPFS for campaign descriptions

## 🧠 License

This project is licensed under the [MIT License](LICENSE).

---

Let me know if you want this `README.md` in a downloadable format or if you'd like a frontend added.
