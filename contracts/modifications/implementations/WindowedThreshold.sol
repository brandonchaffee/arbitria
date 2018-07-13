pragma solidity ^0.4.23;

import "./types/Windowed.sol";
import "./types/Threshold.sol";

contract WindowedThreshold is Windowed, Threshold {
    // WTf1 (Modification Appendix)
    function voteOnModification(uint256 _id, bool _approve)
        inVoteWindow(_id)
    public {
        Modification storage m = modifications[_id];
        accountVotes(_id, _approve);
        m.isValid = m.yesTotal >= approvalThreshold;
        inVote[msg.sender].push(_id);
    }
}
