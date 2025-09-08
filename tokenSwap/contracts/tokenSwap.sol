//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { IERC20 } from"./interfaces/IERC20.sol";

contract TokenSwap {
    IERC20 public tokenA;
    IERC20 public tokenB;

    event Swap(address indexed sender, uint256 amountA, uint256 amountB);

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }

    function swap(uint256 _amount) public {
        require(tokenA.balanceOf(msg.sender) >= _amount, "Insufficient Token A balance");
        require(tokenA.allowance(msg.sender, address(this)) >= _amount, "Allowance not set for Token A");
        require(tokenB.balanceOf(address(this)) >= _amount * 3, "Insufficient Token B balance in contract");

        tokenA.transferFrom(msg.sender, address(this), _amount);
        tokenB.transfer(msg.sender, _amount * 3);

        emit Swap(msg.sender, _amount, _amount * 3);
    }
}