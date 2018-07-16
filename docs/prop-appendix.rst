.. index:: ! prop-appendix

.. _prop-appendix:


#################
Proposal Appendix
#################

Functions
~~~~~~~~~

================    ====================================================
ID                  BTf1
================    ====================================================
Name                ``transfer``

Description         | Balance transfer function equivalent to StandardToken's ``transfer`` with the addition
                    | of the requirement that the sender cannot be currently in a vote so as to maintain the
                    | proper amount of voting rights.


Contract            ``BlockableTransfer.sol``

Emits               ``Transfer`` event

Parameters          | ``address`` **_to** -- where transfer is going to
                    | ``uint256`` **_value** -- amount being transfered


Requirements        - Sender must not be currently in a vote
                    - Recipient must not be from zero ``address``
                    - Sender must have sufficient balance

Returns             ``bool`` success of transfer
================    ====================================================



================    ====================================================
ID                  BTf2
================    ====================================================
Name                ``transferFrom``

Contract            ``BlockableTransfer.sol``

Description         | Balance transfer from approved spender, equivalent to StandardToken's ``transferFrom``
                    | with the addition of the requirement that the sender cannot be currently in a vote so
                    | as to maintain the proper amount of voting rights


Emits               ``Transfer`` event

Parameters          | ``address`` **_from** -- where transfer is coming from
                    | ``address`` **_to** -- where transfer is going to
                    | ``uint256`` **_value** -- amount being transfered


Requirements        - Spender must not be currently in a vote
                    - Recipient must not be from zero ``address``
                    - Spender must have sufficient balance
                    - Sender allowance must have sufficient to amount being transferred

Returns             ``bool`` success of transfer
================    ====================================================



================    ====================================================
ID                  GPf1
================    ====================================================
Name                ``createProposal``

Contract            ``GenericProposal.sol``

Description         | Initializes a proposal with the address of the deployed contract to which the
                    | current implementation will be set to and call upon if approved


Emits               ``ProposalCreated`` event

Parameters          | ``address`` **_target** -- address of the deployed contract subject for approval
                    | ``bytes32`` **_hash** -- details hash containing rationale for using the new contract


Requirements        *None*

Returns             ``uint256`` proposal ID
================    ====================================================



================    ====================================================
ID                  GPf2
================    ====================================================
Name                ``accountVotes``

Contract            ``GenericProposal.sol``

Description         | Internal function for accounting the sender vote count on a specific proposal.
                    | If the sender is voting to approve the proposal, the total yes votes of the sender
                    | will be set to the sender balance and the total yes votes of the proposal will
                    | increase by the difference between the sender past yes votes and the senders current
                    | balance. This process is mirrored for a sender vote to not approve with the senders no
                    | votes and the total no votes for the proposal.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  GPf3
================    ====================================================
Name                ``unblockTransfer``

Contract            ``GenericProposal.sol``

Description         | Removes all outstanding votes for each proposal the sender has voted on. This
                    | allow the sender once again execute ``transfer`` and approved spenders to execute
                    | ``transferFrom``. Execution of this function decrements the sender votes from the
                    | proposals themselves. As such, this function would only be executed on expired
                    | proposals or proposal which the sender was no longer compelled to vote on.


Emits               *None*

Parameters          *None*

Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  DUf1
================    ====================================================
Name                ``confirmProposal``

Contract            ``DemocraticUpgrading.sol``

Description         | Confirms an approved proposal with the calling of **DUf2** to set the proposals
                    | address as the new target to be delegated to by the proxy contract. Once a proposals
                    | has been confirmed, it can no longer be called upon, so as to avoid duplicate or
                    | malicious execution.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal


Requirements        - Current time must exceed end of the window set for voting on the proposal
                    - The proposal must be valid
                    - The proposal must not have been previously called

Returns             *None*
================    ====================================================



================    ====================================================
ID                  DUf2
================    ====================================================
Name                ``upgradeImplementation``

Contract            ``DemocraticUpgrading.sol``

Description         | Internal function for setting the implementation position with the new contract
                    | address for the proxy to delegate calls to. This function is used by **DUf1**.


Emits               ``Upgraded``

Parameters          | ``bytes32`` **position** -- storage position for the address of the delegated contract
                    | ``address`` **implementation** -- address of the contract being set for implementation


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  IPf1
================    ====================================================
Name                ``constructor``

Contract            ``InitializedProxy.sol``

Description         | Initializes the proxy contract with the address of the initial contract to be
                    | delegated to. This address is stored in **IPs1**.


Emits               *None*

Parameters          | ``address`` **_initialContract** -- address of initial fallback contract


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  IPf2
================    ====================================================
Name                ``implementation``

Contract            ``InitializedProxy.sol``

Description         | Getter function to retrieve the address of the current implementation. This function
                    | is used by the proxy as the target for the fallback functions delegate call.


Emits               *None*

Parameters          | ``address`` **_initialContract** -- address of initial fallback contract


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  ETf1
================    ====================================================
Name                ``voteOnproposal``

Contract            ``EndlessThreshold.sol``

Description         | Accounts sender's votes on a proposal, through delegation to **GPf2**, and assess
                    | validity (meeting threshold) of the proposal with new vote totals. Then, the
                    | proposal ID is appended to the ``inVote`` set of the sender so as to block
                    | transfer until this proposal has been resolved as deemed by the sender, using
                    | **GPf3**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WMf1
================    ====================================================
Name                ``voteOnproposal``

Contract            ``WindowedMajority.sol``

Description         | Accounts sender's votes on a proposal, through delegation to **GPf2**, and assess
                    | validity (majority) of the proposal with new vote totals. Then, appends proposal
                    | ID to the ``inVote`` set of the sender so as to block transfer until this proposal
                    | has been resolved as deemed by the sender, using **GPf3**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the proposal's voting window, from **WGs1**

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WRf1
================    ====================================================
Name                ``voteOnproposal``

Contract            ``WindowedRatio.sol``

Description         | Accounts sender's votes on a proposal, through delegation to **GPf2**, and assess
                    | validity (proportional votes) of the proposal with new vote totals. Then, appends
                    | proposal  ID to the ``inVote`` set of the sender so as to block transfer until
                    | this proposal has been resolved as deemed by the sender, using **GPf3**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the proposal's voting window, from **WGs1**

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WTf1
================    ====================================================
Name                ``voteOnproposal``

Contract            ``WindowedThreshold.sol``

Description         | Accounts sender's votes on a proposal, through delegation to **GPf2**, and assess
                    | validity (meeting threshold) of the proposal with new vote totals. Then, appends
                    | proposal  ID to the ``inVote`` set of the sender so as to block transfer until
                    | this proposal has been resolved as deemed by the sender, using **GPf3**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the proposal
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the proposal's voting window, from **WGs1**

Returns             *None*
================    ====================================================



Structures
~~~~~~~~~~
================    ====================================================
ID                  BTs1
================    ====================================================
Name                ``inVote``

Contract            ``BlockableTransfer.sol``

Description         | Maps an ``address`` to an array of ``uint256`` used for storage of the proposal ID
                    | which the ``address`` in question is currently voting on. If the length of this array
                    | is not equal to 0, then ``transfer`` and ``transferFrom`` will be blocked as the sender
                    | currently has outstanding votes.

Type                mapping of ``address`` to ``uint256[]``
================    ====================================================



================    ====================================================
ID                  GPs1
================    ====================================================
Name                ``proposals``

Contract            ``GenericProposal.sol``

Description         | Array of ``GPs3`` used to store all proposals created. A proposal is
                    | referenced by ID which corresponds to its position in ``proposals``. These IDs
                    | increment with the creation of proposal as they get appended to ``proposals``.

Type                ``proposal[]``, from **GPs3**
================    ====================================================



================    ====================================================
ID                  GPs2
================    ====================================================
Name                ``windowSize``

Contract            ``GenericProposal.sol``

Description         | Time in seconds from when a proposal is created to when voting expires. This is
                    | used by windowed type implementations.

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  GPs3
================    ====================================================
Name                ``proposal``

Contract            ``GenericProposal.sol``

Description         | Structure for a proposal entailing the proposal's implementation address, end of
                    | voting window, validity, vote accounting (both totals and individual), and call status.

Type                ``struct``
================    ====================================================



================    ====================================================
ID                  DUs1 & IPs1
================    ====================================================
Name                ``implementationPosition``

Contract            ``DemocraticUpgrading.sol``

Description         | Keccack-256 of an initialization string used to define the position of the
                    | implementation for the proxy fallback function to delegate calls to.

Type                ``bytes32``
================    ====================================================



================    ====================================================
ID                  RGs1
================    ====================================================
Name                ``ratioNumerator``

Contract            ``Ratio.sol``

Description         | Ratio numerator for determining the proportional value of yes to no votes in order
                    | for a proposal to be approved

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  RGs2
================    ====================================================
Name                ``ratioDenominator``

Contract            ``Ratio.sol``

Description         | Ratio denominator for determining the proportional value of yes to no votes in order
                    | for a mdification to be approved

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  TGs1
================    ====================================================
Name                ``approvalThreshold``

Contract            ``Threshold.sol``

Description         | Minimum amount of votes necessary for a proposal to be approved. This is used by
                    | threshold type implementations.

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  WGs1
================    ====================================================
Name                ``inVoteWindow``

Contract            ``Window.sol``

Description         | Modifier function for requiring that the voting window has not expired in order to
                    | proceed with a vote on a specific proposal. This is used by windowed type
                    | implementations.

Type                ``modifier``
================    ====================================================
