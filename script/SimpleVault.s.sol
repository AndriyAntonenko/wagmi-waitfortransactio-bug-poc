// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {SimpleVault} from "../src/SimpleVault.sol";

contract SimpleVaultScript is Script {
    SimpleVault public vault;

    function run() public {
        vm.startBroadcast();

        vault = new SimpleVault(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266);

        vm.stopBroadcast();
    }
}
