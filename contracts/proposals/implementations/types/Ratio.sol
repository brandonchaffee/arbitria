/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../democratic/GenericProposal.sol";

contract Ratio is GenericProposal {
    // RGs1 (Modification Appendix)
    uint256 ratioNumerator;
    // RGs2 (Modification Appendix)
    uint256 ratioDenominator;
}
