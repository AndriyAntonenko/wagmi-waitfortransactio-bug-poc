// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SimpleVault} from "../src/SimpleVault.sol";

contract SimpleVaultTest is Test {
    address public immutable OWNER = makeAddr("OWNER");
    SimpleVault public vault;

    function setUp() public {
        vault = new SimpleVault(OWNER);
    }

    function test_deposit() public {
        vm.deal(OWNER, 1 ether);
        vm.prank(OWNER);
        vault.deposit{value: 1 ether}();

        assertEq(vault.balance(), 1 ether);
        assertEq(address(vault).balance, 1 ether);
    }

    function test_withdraw() public {
        vm.deal(msg.sender, 1 ether);
        vault.deposit{value: 1 ether}();

        vm.warp(block.timestamp + 24 hours);
        vm.prank(OWNER);
        vault.withdraw();

        assertEq(vault.balance(), 0);
        assertEq(address(vault).balance, 0);
        assertEq(OWNER.balance, 1 ether);
    }
}
