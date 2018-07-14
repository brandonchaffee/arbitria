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


Governance Types
================
Ammendments voting, either through a proposal or modication, can take various forms under Arbitria. These
forms vary in terms on approval methods and timing structures. Further variations can be added, but the
current list of governance types used to vote and approve amendment are as follows:

Windowed
~~~~~~~~
Within windowed-type implementation, amendment must meet their necessary approval criteria within a given time
frame. This entails only allowing voting to occur from the start of the amendment creation to the end of the
windowed voting timeframe. Once this voting window expires, if the amendment reaches the necessary approval
criteria the amendment can then be confirmed as the new implementation address for the proxy. Windowed-type
implementation can be used with virtually any approval criteria as it provides a reliable method for allow
sufficient voting to occur.


Endless
~~~~~~~
With endless-type implementation, amendments are not provided with a window an as such can be voted upon and
approved indefinitely. This form can be readily used with threshold, where majority and ratio approval
criteria must include a sufficient lockout period in which the amendment cannot be confirmed until expiration.
This is to avoid any malicious amendment confirmation amd execution.


Ratio
~~~~~
With ratio-type implementation, amendments must meet or exceed a given ratio of yes to no votes in order to be
approved. This ratio is determined using a pre-defined numerator and denominator representing then
necessary yes vote to total vote ratio for approval. With endless-ratio-type implementation (including a
lockout), once the lockout has expired the amendment can be confirmed once this ratio has been met or exceeded.
With windowed-ratio-type implementation, the amendment must reach the necessary ratio within the given voting
window in order to be confirmed.


Majority
~~~~~~~~
With majority-type implementation, amendment become valid if the total yes votes exceeds the total no votes.
This type can be readility used within a windowed-type implementation or an endless-type implementation with
a lockout.

Threshold
~~~~~~~~~
With threshold-type implementation, amendment become valid if the total yes votes exceeds a predefined voted
count threshold. This allows for amendment to only be approved should a given number of total available votes
approve the amendment, where ratio-type and majority-types can be approved with any number of votes occuring
so long as the proper requirements are met. Threshold-type implementation can be readility used within a
windowed-type implementation or an endless-type implementation with a lockout.
