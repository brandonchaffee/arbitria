/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../GenericModification.sol";

contract Lockout is GenericModification {
    uint256 lockoutPeriod;
}
