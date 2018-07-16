/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "../../GenericModification.sol";

contract Windowed is GenericModification {
    // WGs1 (Modification Appendix)
    modifier inVoteWindow(uint256 _id) {
        require(now < modifications[_id].windowEnd);
        _;
    }
}
