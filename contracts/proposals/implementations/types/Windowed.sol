/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../democratic/GenericProposal.sol";

contract Windowed is GenericProposal {
    // WGs1 (Modification Appendix)
    modifier inVoteWindow(uint256 _id) {
        require(now < proposals[_id].windowEnd);
        _;
    }
}
