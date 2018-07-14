pragma solidity ^0.4.23;

import "./BlockableTransfer.sol";

contract GenericModification is BlockableTransfer {

    // GMs1 (Modification Appendix)
    Modification[] public modifications;

    // GMs2 (Modification Appendix)
    uint256 public windowSize;

    // GMs3 (Modification Appendix)
    struct Modification {
        bytes4 signature;
        bytes32[] payload;
        uint256 windowEnd;
        bool isValid;
        uint yesTotal;
        uint noTotal;
        mapping(address => uint) yesVotesOf;
        mapping(address => uint) noVotesOf;
        bool hasBeenConfirmed;
    }

    // GMs4 (Modification Appendix)
    modifier fromContract() {
        require(msg.sender == address(this));
        _;
    }

    event ModificationCreated(
        bytes4 indexed signature,
        bytes32[] payload,
        uint256 indexed windowEnd,
        uint256 indexed id,
        bytes32 detailsHash
    );

    // GMf1 (Modification Appendix)
    function createModification(bytes4 _sig, bytes32[] _payload, bytes32 _hash)
    public returns(uint256){
        uint256 _id = modifications.length++;
        Modification storage m = modifications[_id];
        m.signature = _sig;
        m.payload = _payload;
        m.windowEnd = now + windowSize;
        emit ModificationCreated(_sig, _payload, m.windowEnd, _id, _hash);
        return _id;
    }

    // GMf2 (Modification Appendix)
    function unblockTransfer() public {
        for(uint i=0; i < inVote[msg.sender].length; i++){
            Modification storage m = modifications[i];
            m.noTotal -= m.noVotesOf[msg.sender];
            m.noVotesOf[msg.sender] = 0;
            m.yesTotal -= m.yesVotesOf[msg.sender];
            m.yesVotesOf[msg.sender] = 0;
        }
        delete inVote[msg.sender];
    }

    // GMf3 (Modification Appendix)
    function accountVotes(uint256 _id, bool _approve) internal {
        Modification storage m = modifications[_id];
        if(_approve){
            m.yesTotal -= m.yesVotesOf[msg.sender];
            m.noTotal -= m.noVotesOf[msg.sender];
            m.noVotesOf[msg.sender] = 0;
            m.yesVotesOf[msg.sender] = balances[msg.sender];
            m.yesTotal += balances[msg.sender];
        } else {
            m.noTotal -= m.noVotesOf[msg.sender];
            m.yesTotal -= m.yesVotesOf[msg.sender];
            m.yesVotesOf[msg.sender] = 0;
            m.noVotesOf[msg.sender] = balances[msg.sender];
            m.noTotal += balances[msg.sender];
        }
    }

    event ModificationCalled(uint256 _id, uint256 _time);

    // GMf4 (Modification Appendix)
    function confirmModification(uint256 _id) public {
        Modification storage m = modifications[_id];
        require(now >= m.windowEnd);
        require(m.isValid);
        require(!m.hasBeenConfirmed);
        m.hasBeenConfirmed = true;
        emit ModificationCalled(_id, now);
        callModification(m.signature, m.payload);
    }

    // GMf5 (Modification Appendix)
    function callModification(bytes4 sig, bytes32[] payload) internal {
        assembly {
            let offset := 0x04
            let len := add(offset, mul(mload(payload), 0x20))
            let data := add(payload, 0x20)

            let x := mload(0x40)
            mstore(x,sig)

            for {} lt(offset, len) {
                offset := add(offset, 0x20)
                data := add(data, 0x20)
            }{
                mstore(add(x,offset),mload(data))
            }

            let success := call(gas, address, 0, x, msize, x, 0x20)
            mstore(0x40,add(x,msize))
        }
    }
}
