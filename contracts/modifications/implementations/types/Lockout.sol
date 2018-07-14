pragma solidity ^0.4.23;

import "../../GenericModification.sol";

contract Lockout is GenericModification {
    uint256 lockoutPeriod;
}
