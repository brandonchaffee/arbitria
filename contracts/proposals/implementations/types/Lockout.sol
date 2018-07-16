/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/
pragma solidity ^0.4.23;

import "../../democratic/GenericProposal.sol";

contract Lockout is GenericProposal {
    uint256 lockoutPeriod;
}
