pragma solidity ^0.4.21;

import "./Proxy.sol";

contract InitializedProxy is Proxy {
    // IPs1 (Proposal Appendix)
    bytes32 private constant implementationPosition = keccak256("democratic.proxy.contract.position");

    // IPf1 (Proposal Appendix)
    constructor(address _initialContract) public {
        bytes32 position = implementationPosition;
        assembly {
            sstore(position, _initialContract)
        }
    }

    // IPf2 (Proposal Appendix)
    function implementation() public view returns (address impl) {
        bytes32 position = implementationPosition;
        assembly {
          impl := sload(position)
        }
      }
}
