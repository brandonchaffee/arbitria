.. index:: ! basics

.. _basics:


###############
Basic Structure
###############

Necessities
===========
The Arbitria base smart contract is inherited from the OpenZeppelin Standard Token.
This inheritance is needed for both the ``balance`` and ``transfer`` functionality.
As such any contract inheriting from the Arbitria smart contract structure must also
keep the Standard Token functionality for ``balance`` and ``transfer``. All other
functionality associated with the Standard Token is superfluous to the Arbitria
governance structure.

.. note::
    Although Arbitria relies on the underlying balance structure for ERC20
    tokens, this democratic governance structure works with any smart contract
    that has a mapping of ``address`` to ``uint`` representing an that address'
    stake of a whole.


Voting Rights
=============



This smart contract is inherited for the use of the token balance as an address'
balance represents its proportional stake relative to the total token supply. This
token balance is used to represent

Transfer Block & Unblock
========================


Vote Accounting
===============
