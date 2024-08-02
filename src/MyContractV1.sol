// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyContractV1 is Initializable {
    uint256 private _value;

    function initialize(uint256 value) public initializer {
        _value = value;
    }

    function setValue(uint256 value) public {
        _value = value;
    }

    function getValue() public view returns (uint256) {
        return _value;
    }
}
