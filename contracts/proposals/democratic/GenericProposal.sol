/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/

pragma solidity ^0.4.23;

import "./BlockableTransfer.sol";

contract GenericProposal is BlockableTransfer {
    // GPs1 (Proposal Appendix)
    Proposal[] public proposals;
    // GPs2 (Proposal Appendix)
    uint256 public windowSize;

    // GPs2 (Proposal Appendix)
    struct Proposal {
        address target;
        uint256 windowEnd;
        bool isValid;
        uint yesTotal;
        uint noTotal;
        mapping(address => uint) yesVotesOf;
        mapping(address => uint) noVotesOf;
        bool hasBeenConfirmed;
    }

    event ProposalCreated(
        address indexed target,
        uint256 indexed windowEnd,
        uint256 indexed id,
        bytes32 detailsHash
    );

    // GPf1 (Proposal Appendix)
    function createProposal(address _target, bytes32 _hash)
    public returns(uint256){
        uint256 _id = proposals.length++;
        Proposal storage p = proposals[_id];
        p.target = _target;
        p.windowEnd = now + windowSize;
        emit ProposalCreated(_target, p.windowEnd, _id, _hash);
        return _id;
    }

    // GPf2 (Proposal Appendix)
    function accountVotes(uint256 _id, bool _approve) public {
        Proposal storage p = proposals[_id];
        if(_approve){
            p.yesTotal -= p.yesVotesOf[msg.sender];
            p.noTotal -= p.noVotesOf[msg.sender];
            p.noVotesOf[msg.sender] = 0;
            p.yesVotesOf[msg.sender] = balances[msg.sender];
            p.yesTotal += balances[msg.sender];
        } else {
            p.noTotal -= p.noVotesOf[msg.sender];
            p.yesTotal -= p.yesVotesOf[msg.sender];
            p.yesVotesOf[msg.sender] = 0;
            p.noVotesOf[msg.sender] = balances[msg.sender];
            p.noTotal += balances[msg.sender];
        }
    }

    // GPf3 (Proposal Appendix)
    function unblockTransfer() public {
        for(uint i=0; i < inVote[msg.sender].length; i++){
            Proposal storage p = proposals[i];
            p.noTotal -= p.noVotesOf[msg.sender];
            p.noVotesOf[msg.sender] = 0;
            p.yesTotal -= p.yesVotesOf[msg.sender];
            p.yesVotesOf[msg.sender] = 0;
        }
        delete inVote[msg.sender];
    }
}
