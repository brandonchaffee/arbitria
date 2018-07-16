/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "./types/Windowed.sol";

contract WindowedMajority is Windowed {
    // WMf1 (Modification Appendix)
    function voteOnModification(uint256 _id, bool _approve)
        inVoteWindow(_id)
    public {
        Modification storage m = modifications[_id];
        accountVotes(_id, _approve);
        m.isValid = m.yesTotal >= m.noTotal;
        inVote[msg.sender].push(_id);
    }
}
