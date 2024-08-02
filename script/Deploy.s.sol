// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "lib/openzeppelin-contracts/contracts/proxy/transparent/ProxyAdmin.sol";
import "lib/openzeppelin-contracts/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import "../src/MyContractV1.sol";

contract DeployProxyScript is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address initialAddress = 0xa76B88B26Ab5682B8559e7b9689B14Ef602fA08F;
        string memory sepoliaRpcUrl = vm.envString("SEPOLIA_RPC_URL");
        vm.startBroadcast(deployerPrivateKey);

        vm.setEnv("SEPOLIA_RPC_URL", sepoliaRpcUrl);

        // Deploy the ProxyAdmin
        ProxyAdmin proxyAdmin = new ProxyAdmin(initialAddress);

        // Deploy the implementation contract (V1)
        MyContractV1 myContractV1 = new MyContractV1();

        // Deploy the TransparentUpgradeableProxy
        TransparentUpgradeableProxy proxy = new TransparentUpgradeableProxy(
            address(myContractV1),
            address(proxyAdmin),
            abi.encodeWithSignature("initialize(uint256)", 42)
        );

        // Save the proxy and admin addresses for later use
        console.log("Proxy deployed at:", address(proxy));
        console.log("ProxyAdmin deployed at:", address(proxyAdmin));

        vm.stopBroadcast();
    }
}
