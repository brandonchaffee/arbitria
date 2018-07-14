pragma solidity ^0.4.23;

import "./GenericProposal.sol";

contract DemocraticUpgrading is GenericProposal {

    // DUs1 (Proposal Appendix)
    bytes32 private constant implementationPosition = keccak256("democratic.proxy.contract.position");

    // DUf1 (Proposal Appendix)
    function confirmProposal(uint256 _id) public {
        Proposal storage p = proposals[_id];
        require(now >= p.windowEnd);
        require(p.isValid);
        require(!p.hasBeenConfirmed);
        p.hasBeenConfirmed = true;
        upgradeImplementation(implementationPosition, p.target);
    }

    event Upgraded(uint256 indexed time, address indexed newImplmentation);

    // DUf2 (Proposal Appendix)
    function upgradeImplementation(bytes32 position, address implementation)
    internal {
        assembly {
            sstore(position, implementation)
        }
        emit Upgraded(now, implementation);
    }
}
