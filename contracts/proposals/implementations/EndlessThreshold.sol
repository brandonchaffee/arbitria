pragma solidity ^0.4.23;

import "./types/Threshold.sol";

contract EndlessThreshold is Threshold {
    // ETf1 (Proposal Appendix)
    function voteOnProposal(uint256 _id, bool _approve)
    public {
        Proposal storage p = proposals[_id];
        accountVotes(_id, _approve);
        p.isValid = p.yesTotal >= approvalThreshold;
        inVote[msg.sender].push(_id);
    }
}
