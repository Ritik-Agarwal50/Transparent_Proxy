// script/Upgrade.s.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import "lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from "lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "../src/ImplementaionV2.sol";
import {console} from "forge-std/console.sol";

contract UpgradeScript is Script {
    function run() external {
        // Load environment variables
        string memory proxyAddressEnv = vm.envString("PROXY_ADDRESS");
        string memory proxyAdminAddressEnv = vm.envString(
            "PROXY_ADMIN_ADDRESS"
        );
        address proxyAddress = vm.parseAddress(proxyAddressEnv);
        address proxyAdminAddress = vm.parseAddress(proxyAdminAddressEnv);

        vm.startBroadcast();

        // Cast to the actual ProxyAdmin contract
        ProxyAdmin proxyAdmin = ProxyAdmin(proxyAdminAddress);
        ITransparentUpgradeableProxy proxy = ITransparentUpgradeableProxy(
            payable(proxyAddress)
        );

        // Deploy the new implementation contract
        ImplementationV2 newImplementation = new ImplementationV2();
        newImplementation.initialize();

        // Upgrade the proxy to the new implementation.
        bytes memory data = abi.encodeWithSignature("initialize()");
        proxyAdmin.upgradeAndCall(proxy, address(newImplementation), data);

        vm.stopBroadcast();

        console.log(
            "Proxy upgraded to new implementation at:",
            address(newImplementation)
        );
    }
}
