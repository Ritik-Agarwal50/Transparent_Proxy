// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
// Import the UUPSUpgradeable library

contract CounterV1 is UUPSUpgradeable, Initializable {
    uint256 private _value;

    function initialize() public initializer {
        _value = 0;
    }

    function increment() public {
        _value += 1;
    }

    function getValue() public view returns (uint256) {
        return _value;
    }

    function _authorizeUpgrade(address) internal override {}
}
