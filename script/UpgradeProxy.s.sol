// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import "lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "../src/MyContractV2.sol";

contract UpgradeProxyScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Get the addresses of the deployed contracts
        address proxyAddress = vm.envAddress("PROXY_ADDRESS");
        address proxyAdminAddress = vm.envAddress("PROXY_ADMIN_ADDRESS");

        ITransparentUpgradeableProxy proxy = ITransparentUpgradeableProxy(
            payable(proxyAddress)
        );
        ProxyAdmin proxyAdmin = ProxyAdmin(proxyAdminAddress);

        // Deploy the new implementation (V2)
        MyContractV2 myContractV2 = new MyContractV2();

        // Upgrade the proxy to use the new implementation
        proxyAdmin.upgradeAndCall(
            proxy,
            address(myContractV2),
            abi.encodeWithSignature("initializeNewValue(uint256)", 100)
        );

        console.log(
            "Proxy upgraded to new implementation at:",
            address(myContractV2)
        );

        vm.stopBroadcast();
    }
}
