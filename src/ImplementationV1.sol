// SPDX-License-Ientifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";

contract ImplementationV1 is Initializable {
    uint256 public number;

    function Initialize() public initializer {
        number = 1;
    }

    function setNumber(uint256 _number) public {
        number = _number;
    }
}
