//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import {TransparentUpgradeableProxy} from "lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyAdmin} from "lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {ImplementationV1} from "../src/ImplementationV1.sol";

contract Deploy is Script {
    function run() external {
        address initialOwner = 0xa76B88B26Ab5682B8559e7b9689B14Ef602fA08F;
        string memory rpc_url = vm.envString("SEPOLIA_RPC_URL");
        vm.createFork(rpc_url);
        string memory private_key = vm.envString("PRIVATE_KEY");
        vm.startBroadcast();
        ImplementationV1 impl = new ImplementationV1();
        impl.initialize();

        ProxyAdmin proxyAdmin = new ProxyAdmin(initialOwner);
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(impl),
            address(proxyAdmin),
            abi.encodeWithSelector(impl.initialize.selector)
        );
        vm.stopBroadcast();

        console.log("Proxy deployed to:", address(proxy));
        console.log("ProxyAdmin deployed to:", address(proxyAdmin));
        console.log("ProxyAdmin owner set to:", initialOwner);
    }
}
