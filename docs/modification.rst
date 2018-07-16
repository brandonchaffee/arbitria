.. index:: ! modification

.. _modification:


###################
Modification System
###################

Creation
========
In order to create a modification, a function signature and a function payload must be provided. The function
signature is first four bytes, ``bytes4``, of the Keccack hash of the desired function's ID, being its
name and arguments. The function payload is the specific set of arguments being passed to this function upon
approval. This payload takes the form of a ``bytes32[]`` in which each element within the array is an argument
to be passed to the function itself.

Execution
=========
When a modification is confirmed and called upon, a call is made to the function using the supplied signature
from the modification. Appended to this call is each of the element within the modifications given payload.
These are passed to the function for use as the function's arguments. Once the call is made, the function will
be executed accordingly.

Usage
=====
As the modification confirmation call to the targeted function will be comning from the contract itself, a
modifier, ``fromContract`` is used so that only the contract itself may call the contract. This allows for
these functions to be open public while only exeuctable through the calling of the confirmation function. As
such, any function desired for decrentalized approval calling should included the ``fromContract`` modifier.  
