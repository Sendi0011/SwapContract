// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import { IERC20 } from"./interfaces/IERC20.sol";

contract TokenB is IERC20 {
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowances;

    uint256 public totalSupply = 2000000;

    constructor() {
        balances[msg.sender] = totalSupply;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[recipient] += amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(balances[sender] >= amount, "Insufficient balance");
        require(allowances[sender][msg.sender] >= amount, "Allowance not set");
        balances[sender] -= amount;
        balances[recipient] += amount;
        allowances[sender][msg.sender] -= amount;
        return true;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        allowances[msg.sender][spender] = amount;
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return allowances[owner][spender];
    }
}