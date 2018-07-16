.. index:: ! integration

.. _integration:
.. _package: https://www.npmjs.com/package/arbitria

__ package_

###########
Integration
###########

Importing
=========
The Arbitria smart contracts can be cloned locally or through the inclusion of the arbitria npm package.
The Arbitria npm Package details can be found `here`__.


Usage
=====
The main entry point for Arbitria can be any of the smart contracts included in the ``implementations``
directory of either ``proposals`` or ``modifications``. When importing from these implementations it is
important to remember to properly construct these contracts as shown in the contracts within the ``test``
directory.

Alternatively, arbitria smart contracts can be constructed from the generic contracts being either
``GenericModification`` or ``DemocraticUpgrading`` for a modifiable or upgradeable structure respectively.
From this, custom approval criterea and functions can be added.
