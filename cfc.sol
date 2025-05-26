// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract cfc {
    address public owner;
    uint public goal;
    uint public deadline;
    uint public totalRaised;
    bool public fundsWithdrawn;

    mapping(address => uint) public contributions;

    event ContributionReceived(address indexed contributor, uint amount);
    event FundsWithdrawn(uint amount);
    event RefundIssued(address indexed contributor, uint amount);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the campaign creator");
        _;
    }

    modifier campaignActive() {
        require(block.timestamp < deadline, "Campaign ended");
        _;
    }

    modifier campaignEnded() {
        require(block.timestamp >= deadline, "Campaign still active");
        _;
    }

    constructor(uint _goal, uint _durationInDays) {
        owner = msg.sender;
        goal = _goal;
        deadline = block.timestamp + (_durationInDays * 1 days);
    }

    function contribute() external payable campaignActive {
        require(msg.value > 0, "Must send ETH");
        contributions[msg.sender] += msg.value;
        totalRaised += msg.value;
        emit ContributionReceived(msg.sender, msg.value);
    }

    function withdrawFunds() external onlyOwner campaignEnded {
        require(totalRaised >= goal, "Goal not reached");
        require(!fundsWithdrawn, "Funds already withdrawn");

        fundsWithdrawn = true;
        payable(owner).transfer(totalRaised);
        emit FundsWithdrawn(totalRaised);
    }

    function claimRefund() external campaignEnded {
        require(totalRaised < goal, "Goal was reached");
        uint amount = contributions[msg.sender];
        require(amount > 0, "No contribution to refund");

        contributions[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
        emit RefundIssued(msg.sender, amount);
    }

    function getTimeLeft() external view returns (uint) {
        if (block.timestamp >= deadline) return 0;
        return deadline - block.timestamp;
    }
}
