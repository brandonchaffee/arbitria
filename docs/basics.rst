.. index:: ! basics

.. _basics:


###############
Basic Structure
###############

Necessities
===========
The Arbitria base smart contract is inherited from the OpenZeppelin Standard Token. This inheritance is needed
for both the ``balance`` and ``transfer`` functionality. As such any contract inheriting from the Arbitria
smart contract structure must also keep the Standard Token functionality for ``balance`` and ``transfer``.
All other functionality associated with the Standard Token is superfluous to the Arbitria governance
structure.

.. note::
    Although Arbitria relies on the underlying balance structure for ERC20 tokens, this democratic governance
    the structure works with any smart contract that has a mapping of ``address`` to ``uint`` representing an
    that address' stake of a whole.

Voting Rights
=============
Voting rights within Arbitria are tied to the ``balance`` defined by the StandardToken. These balances
represent an address proportion of the whole of the ``totalSupply`` and can be used to accurately represent
an address stake to the underlying smart contract associated with the token. As such, an address' specific
balance equates to the amount of voting that address receives. When an amendment, being either a proposal or
modification, is voted upon, the total votes either for or against are incremented by an amount equal to the
balance of the address of the sender.

Transfer Block & Unblock
========================
To provide a fair and equitable process by which total votes are assessed, balances during voting must remain
constant. This must be implemented in order to avoid vote churning in which an individual proceeds to vote
and transfer their balance to new accounts, thus providing the individual with virtually limitless voting
rights. As such, once an amendment has been voted upon by an address, that address will be ineligible to use
either ``transfer`` or ``transferFrom``. This keeps the total supply and voting rights equivalent. Once an
amendment has terminated, either through expiration, execution, or the loss of the sender's desire to vote,
the ability to ``transfer`` or ``transferFrom`` become eligible again.

.. note::
    An alternative to transfer blocking and unblocking would be the inclusion of vote decrementing upon the
    calling of ``transfer`` or ``transferFrom``. While this would be less constricting, the gas costs
    associated with this decrementing action would be considerably high. The implementation of vote
    decrementing will be included in future version of Arbitria but its use is not advised.

Vote Switching
==============
Votes on amendments, either a proposal or modification, can be reversed should the sender so choose. This
allows the sender to determine their voting preference at the given current circumstance and allows the sender
to actively change the direction in which they are voting should they so choose.


Governance Types
================
Amendments voting, either through a proposal or modification, can take various forms under Arbitria. These
forms vary in terms on approval methods and timing structures. Further variations can be added, but the
current list of governance types used to vote and approve amendment are as follows:

Windowed
~~~~~~~~
Within windowed-type implementation, amendments must meet their necessary approval criteria within a given
time frame. This entails only allowing voting to occur from the start of the amendment creation to the end of
the windowed voting timeframe. Once this voting window expires, if the amendment reaches the necessary
approval criteria the amendment can then be confirmed as the new implementation address for the proxy.
Windowed-type implementation can be used with virtually any approval criteria as it provides a reliable
method for allowing sufficient voting to occur.


Endless
~~~~~~~
With endless-type implementation, amendments are not provided with a window and as such can be voted upon and
approved indefinitely. This form can be readily used with a threshold, where majority and ratio approval
criteria must include a sufficient lockout period in which the amendment cannot be confirmed until expiration.
This is to avoid any malicious amendment confirmation and execution.


Ratio
~~~~~
With ratio-type implementation, amendments must meet or exceed a given ratio of yes to no votes in order to be
approved. This ratio is determined using a pre-defined numerator and denominator representing then
necessary yes vote to total vote ratio for approval. With endless-ratio-type implementation (including a
lockout), once the lockout has expired the amendment can be confirmed once this ratio has been met or
exceeded. With windowed-ratio-type implementation, the amendment must reach the necessary ratio within the
given voting window in order to be confirmed.


Majority
~~~~~~~~
With majority-type implementation, amendments become valid if the total yes votes exceed the total no votes.
This type can be readily used within a windowed-type implementation or an endless-type implementation with
a lockout.

Threshold
~~~~~~~~~
With threshold-type implementation, amendments become valid if the total yes votes exceed a predefined voted
count threshold. This allows for an amendment to only be approved should a given number of total available
votes approve the amendment, where ratio-type and majority-types can be approved with any number of votes
occurring so long as the proper requirements are met. Threshold-type implementation can be readily used within
a windowed-type implementation or an endless-type implementation with a lockout.
