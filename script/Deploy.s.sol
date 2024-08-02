// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "../src/CounterV1.sol";
import "../src/CounterV2.sol";
import "forge-std/Script.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();
        address deployer = vm.envAddress("DEPLOYER_ADDRESS");
        // Deploy ProxyAdmin
        ProxyAdmin proxyAdmin = new ProxyAdmin(deployer);

        // Deploy CounterV1
        address counterV1 = address(new CounterV1());

        // Deploy TransparentUpgradeableProxy
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            counterV1,
            address(proxyAdmin),
            ""
        );

        // Deploy CounterV2
        address counterV2 = address(new CounterV2());

        // Encode data for initialization
        bytes memory data = abi.encodeWithSignature("setValue(uint256)", 123);

        // Upgrade Proxy and initialize CounterV2
        proxyAdmin.upgradeAndCall{value: 0}(
            ITransparentUpgradeableProxy(address(proxy)),
            counterV2,
            data
        );
        vm.stopBroadcast();
    }
}
// Upgrade Proxy and initialize CounterV2
