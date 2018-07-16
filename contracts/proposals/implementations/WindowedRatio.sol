/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "./types/Windowed.sol";
import "./types/Ratio.sol";

contract WindowedRatio is Windowed, Ratio {
    // WRf1 (Proposal Appendix)
    function voteOnProposal(uint256 _id, bool _approve)
        inVoteWindow(_id)
    public {
        Proposal storage p = proposals[_id];
        accountVotes(_id, _approve);
        p.isValid = p.yesTotal * ratioDenominator >= p.noTotal * ratioNumerator;
        inVote[msg.sender].push(_id);
    }
}
