// SPDX-License-Ientifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";

contract ImplementationV2 is Initializable {
    uint256 public number;

    function initialize() public initializer {
        number = 1;
    }

    function setNumber(uint256 _number) public {
        number = _number * 2;
    }
}
