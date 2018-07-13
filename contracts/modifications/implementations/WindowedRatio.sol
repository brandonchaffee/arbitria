pragma solidity ^0.4.23;

import "./types/Windowed.sol";
import "./types/Ratio.sol";

contract WindowedRatio is Windowed, Ratio {
    // WRf1 (Modification Appendix)
    function voteOnModification(uint256 _id, bool _approve)
        inVoteWindow(_id)
    public {
        Modification storage m = modifications[_id];
        accountVotes(_id, _approve);
        m.isValid = m.yesTotal * ratioDenominator >= m.noTotal * ratioNumerator;
        inVote[msg.sender].push(_id);
    }
}
