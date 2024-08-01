//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import {Script} from "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();
        ImplementationV1 impl = new ImplementationV1();
        impl.initialize();

        ProxyAdmin proxyAdmin = new ProxyAdmin();
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(impl),
            address(proxyAdmin),
            ""
        );
    }
}
