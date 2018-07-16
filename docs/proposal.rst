.. index:: ! proposal

.. _proposal:


###############
Proposal System
###############

Creation
========
In order to create a proposal, an address must be provided to be used for the ``delegatecall`` target by the
proxy. This address, if approved will serve as the interface for all contract calls that go through the
fallback function. As such, before a proposal is created, the new contract interface must be deployed. Once
deployed, the contract's address can then be appended to a proposal and provided with a detail hash with
an explaination for why such an interfaced should be approved and used.

Execution
=========
Once a proposal has meet all necessary approval criteria, the proposal is then confirmed and the address tied
to the proposal replaces the old implementation address at the given ``implementationPosition``. Once the
``implementationPosition`` has be modified, all future calls to the proxy contract's fallback function will
be delegated to this new address.

Usage
=====
When the fallback function of the proxy contract is called, the ``implementationPosition`` is used to direct
a ``delegatecall`` to the address of the implemented contract. This ``delegatecall`` allows for execution of
functions and storage structure of the newly approved contract address.
