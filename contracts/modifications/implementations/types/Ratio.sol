/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../GenericModification.sol";

contract Ratio is GenericModification {
    // RGs1 (Modification Appendix)
    uint256 ratioNumerator;
    // RGs2 (Modification Appendix)
    uint256 ratioDenominator;
}
