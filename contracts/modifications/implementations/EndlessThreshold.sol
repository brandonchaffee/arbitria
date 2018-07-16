/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "./types/Threshold.sol";

contract EndlessThreshold is Threshold {
    // ETf1 (Modification Appendix)
    function voteOnModification(uint256 _id, bool _approve)
    public {
        Modification storage m = modifications[_id];
        accountVotes(_id, _approve);
        m.isValid = m.yesTotal >= approvalThreshold;
        inVote[msg.sender].push(_id);
    }
}
