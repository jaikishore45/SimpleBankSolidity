// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.9;

contract SimpleBank {
    // Mapping to store balances of each account
    mapping(address => uint256) private balances;

    // Event to log deposits
    event Deposit(address indexed account, uint256 amount);

    // Event to log withdrawals
    event Withdrawal(address indexed account, uint256 amount);

    // Function to deposit ether into the bank
    function deposit(uint256 _userAmount) public payable {
        require(_userAmount > 0, "Deposit amount must be greater than zero");

        if (balances[msg.sender] == 0) {
            balances[msg.sender] = _userAmount; // Initial amount for new accounts
        }else{
            balances[msg.sender] += _userAmount;
        }


    }

    // Function to withdraw ether from the bank
    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        
    }

    // Function to check the balance of the sender's account
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Function to check the balance of a specific account (only accessible by the owner)
    address private owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function getBalanceOf(address account) public view onlyOwner returns (uint256) {
        return balances[account];
    }
}
