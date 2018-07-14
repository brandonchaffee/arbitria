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


Usage
=====
