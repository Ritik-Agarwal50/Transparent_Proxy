// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { TransparentUpgradeableProxy } from "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

interface ProxyAdminInterface {
    function upgradeAndCall(
        TransparentUpgradeableProxy proxy,
        address newImplementation,
        bytes memory data
    ) external payable;
}
