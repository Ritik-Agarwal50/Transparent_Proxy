// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "lib/openzeppelin-contracts/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract CounterV2 is UUPSUpgradeable, Initializable {
    uint256 private _value;

    function initialize() public initializer {
        _value = 69;
    }

    function setValue(uint256 newValue) public {
        _value = newValue;
    }

    function getValue() public view returns (uint256) {
        return _value;
    }

    function _authorizeUpgrade(address) internal override {}
}
