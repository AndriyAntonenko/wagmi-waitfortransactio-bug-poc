// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleVault {
    uint256 public constant MIN_DEPOSIT = 5 wei;
    address public owner;
    uint256 public unlockTime;
    uint256 public balance;

    error AmountTooLow();
    error TooEarly();
    error OnlyOwner();

    constructor(address _owner) {
        owner = _owner;
        unlockTime = block.timestamp + 24 hours;
    }

    function withdraw() public {
        if (msg.sender != owner) revert OnlyOwner();
        if (block.timestamp < unlockTime) revert TooEarly();
        payable(msg.sender).transfer(balance);
        balance = 0;
    }

    function deposit() public payable {
        if (msg.value < MIN_DEPOSIT) revert AmountTooLow();
        balance += msg.value;
    }

    receive() external payable {
        revert("no receive");
    }

    fallback() external {
        revert("no fallback");
    }
}
