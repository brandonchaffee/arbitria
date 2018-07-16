/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "./types/Windowed.sol";

contract WindowedMajority is Windowed {
    // WMf1 (Proposal Appendix)
    function voteOnProposal(uint256 _id, bool _approve)
        inVoteWindow(_id)
    public {
        Proposal storage p = proposals[_id];
        accountVotes(_id, _approve);
        p.isValid = p.yesTotal > p.noTotal;
        inVote[msg.sender].push(_id);
    }
}
