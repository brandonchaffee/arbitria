.. index:: ! mod-appendix

.. _mod-appendix:


#####################
Modification Appendix
#####################

Functions
~~~~~~~~~

================    ====================================================
ID                  BTf1
================    ====================================================
Name                ``transfer``

Description         | Balance transfer function equivalent to StandardToken's ``transfer`` with the addition
                    | of the requirement that the sender cannot be currently in a vote so as to maintain the
                    | proper amount voting rights.


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
                    - Sender allowance must have sufficient to amount being transfered

Returns             ``bool`` success of transfer
================    ====================================================



================    ====================================================
ID                  GMf1
================    ====================================================
Name                ``createModification``

Contract            ``GenericModifcation.sol``

Description         | Initializes modification with the speific function signature and relative payload that
                    | will be executed should the modification receive the necessary approval.


Emits               ``ModificationCreated`` event

Parameters          | ``bytes4`` **_sig** -- contract function signature targeted for execution
                    | ``bytes32[]`` **_payload** -- arguments to be passed to targeted function
                    | ``bytes32`` **_hash** -- details hash containing rationale for execution


Requirements        *None*

Returns             ``uint256`` modification ID
================    ====================================================



================    ====================================================
ID                  GMf2
================    ====================================================
Name                ``unblockTransfer``

Contract            ``GenericModifcation.sol``

Description         | Removes all outstanding votes for each modification the sender has voted on. This
                    | allow the sender once again execute ``transfer`` and approved spenders to execute
                    | ``transferFrom``. Execution of this function decrements the sender votes from the
                    | modifications themselves. As such, this function would only be executed on expired
                    | modifications or modification which the sender was no longer compelled to vote on.


Emits               *None*

Parameters          *None*

Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  GMf3
================    ====================================================
Name                ``accountVotes``

Contract            ``GenericModifcation.sol``

Description         | Internal function for accounting the sender vote count on a specific modification.
                    | If the sender is voting to approve the modification, the total yes votes of the sender
                    | will be set to the sender balance and the total yes votes of the modification will
                    | increase by the difference between the sender past yes votes and the senders current
                    | balance. This process is mirrored for a sender vote to not approve with the senders no
                    | votes and the total no votes for th modification.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the modification
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  GMf4
================    ====================================================
Name                ``confirmModification``

Contract            ``GenericModifcation.sol``

Description         | Confirms the calling of an approved modfication and delegate the execution of the
                    | modification to GMf5. Once a modification has been confirmed, it can no longer be
                    | called upon, so as to avoid duplicate or malicious execution.


Emits               ``ModificationCalled``

Parameters          | ``uint256`` **_id** -- ID of the modification


Requirements        - Current time must exceed end of window set for voting on the modfication
                    - The modifcation must be valid
                    - The modification must not have been previosuly called

Returns             *None*
================    ====================================================



================    ====================================================
ID                  GMf5
================    ====================================================
Name                ``callModification``

Contract            ``GenericModifcation.sol``

Description         | Internal function used for exeuction of modification functions and their respective
                    | payloads. This function uses assembly to execute the targeted function from the
                    | modification's given signature and appends the modification's payload as arguments
                    | to targeted function. The targeted function executes from the contract itself.


Emits               ``ModificationCalled``

Parameters          | ``bytes4`` **sig** -- contract function signature targeted for execution
                    | ``bytes32[]`` **payload** -- arguments to be passed to targeted function


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  ETf1
================    ====================================================
Name                ``voteOnModification``

Contract            ``EndlessThreshold.sol``

Description         | Accounts sender's votes on a modification, through delegation to **GMf3**, and assess
                    | validity (meeting threshold) of modification with new vote totals. Then, the
                    | modification ID is appended to the ``inVote`` set of the sender so as to block
                    | transfer until this modification has been resolved as deemed by the sender, using
                    | **GMf2**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the modification
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        *None*

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WMf1
================    ====================================================
Name                ``voteOnModification``

Contract            ``WindowedMajority.sol``

Description         | Accounts sender's votes on a modification, through delegation to **GMf3**, and assess
                    | validity (majority) of modification with new vote totals.Then, appends modification
                    | ID to the ``inVote`` set of the sender so as to block transfer until this modification
                    | has been resolved as deemed by the sender, using **GMf2**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the modification
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the modification's voting window, from **WGs1**

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WRf1
================    ====================================================
Name                ``voteOnModification``

Contract            ``WindowedRatio.sol``

Description         | Accounts sender's votes on a modification, through delegation to **GMf3**, and assess
                    | validity (proptional votes) of modification with new vote totals. Then, appends
                    | modification  ID to the ``inVote`` set of the sender so as to block transfer until
                    | this modification has been resolved as deemed by the sender, using **GMf2**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the modification
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the modification's voting window, from **WGs1**

Returns             *None*
================    ====================================================



================    ====================================================
ID                  WTf1
================    ====================================================
Name                ``voteOnModification``

Contract            ``WindowedThreshold.sol``

Description         | Accounts sender's votes on a modification, through delegation to **GMf3**, and assess
                    | validity (meeting threshold) of modification with new vote totals. Then, appends
                    | modification  ID to the ``inVote`` set of the sender so as to block transfer until
                    | this modification has been resolved as deemed by the sender, using **GMf2**.


Emits               *None*

Parameters          | ``uint256`` **_id** -- ID of the modification
                    | ``bool`` **_approve** -- true if voting to approve, false if not voting to approve


Requirements        Current time must within the modification's voting window, from **WGs1**

Returns             *None*
================    ====================================================



Structures
~~~~~~~~~~
================    ====================================================
ID                  BTs1
================    ====================================================
Name                ``inVote``

Contract            ``BlockableTransfer.sol``

Description         | Maps an ``address`` to an array of ``uint256`` used for storage of the modification ID
                    | which the ``address`` in question is currently voting on. If the length of this array
                    | is not equal to 0, than ``transfer`` and ``tranferFrom`` wil be block as the sender
                    | currently has outstanding votes.

Type                mapping of ``address`` to ``uint256[]``
================    ====================================================



================    ====================================================
ID                  GMs1
================    ====================================================
Name                ``modifications``

Contract            ``GenericModifcation.sol``

Description         | Array of ``GMs3`` used to store all modifications created. A modification is
                    | referenced by ID which corresponds to its position in ``modifications``. These IDs
                    | increment with the creation of modifiction as they get appended to ``modifications``.

Type                ``Modification[]``, from **GMs3**
================    ====================================================



================    ====================================================
ID                  GMs2
================    ====================================================
Name                ``windowSize``

Contract            ``GenericModifcation.sol``

Description         | Time in seconds from when a modification is created to when voting expires. This is
                    | used by windowed type implementations.

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  GMs3
================    ====================================================
Name                ``Modification``

Contract            ``GenericModifcation.sol``

Description         | Structure for a modification entailing the modifications signature, payload, end of
                    | voting window, validity, vote accounting (both totals and individual), and call status.

Type                ``struct``
================    ====================================================



================    ====================================================
ID                  GMs4
================    ====================================================
Name                ``fromContract``

Contract            ``GenericModifcation.sol``

Description         | Modifier function for requiring that the caller of a contract function be the
                    | contract itself. This is used as opposed to ``private`` or ``internal`` to provide
                    | a usable signature for modifications to call upon execution while maintaining the
                    | permission structure of a non-external function.

Type                ``modifier``
================    ====================================================



================    ====================================================
ID                  RGs1
================    ====================================================
Name                ``ratioNumerator``

Contract            ``Ratio.sol``

Description         | Ratio numerator for determining the proportional value of yes to no votes in order
                    | for a mdification to be approved

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

Description         | Minimum amount of votes necessary for a modification to be approved. This is used by
                    | threshold type implementations.

Type                ``uint256``
================    ====================================================



================    ====================================================
ID                  WGs1
================    ====================================================
Name                ``inVoteWindow``

Contract            ``Window.sol``

Description         | Modifier function for require that the voting window has not expired in order to
                    | proceed with a vote on a specific modification. This is used by windowed type
                    | implementations.

Type                ``modifier``
================    ====================================================
