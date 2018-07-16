/*
    Documentation: https://arbitria.readthedocs.io
    Author: Brandon Chaffee
    License: MIT
*/



pragma solidity ^0.4.23;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";

contract BlockableTransfer is StandardToken {
    // BTs1 (Modification Appendix)
    mapping(address => uint256[]) public inVote;

    // BTf1 (Modification Appendix)
    function transfer(address _to, uint256 _value)
    public returns (bool) {
        require(inVote[msg.sender].length == 0);
        require(_to != address(0));
        require(_value <= balances[msg.sender]);

        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // BTf2 (Modification Appendix)
    function transferFrom(address _from, address _to, uint256 _value)
    public returns (bool) {
        require(inVote[_from].length == 0);
        require(_to != address(0));
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);

        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }
}
