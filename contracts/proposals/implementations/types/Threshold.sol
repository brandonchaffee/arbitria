/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../democratic/GenericProposal.sol";

contract Threshold is GenericProposal {
    // TGs1 (Modification Appendix)
    uint256 approvalThreshold;
}
