======
tomcat
======

Install Apache Tomcat from binaries tarball.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``tomcat.user``
--------------

It creates the system user/group for Tomcat.

``tomcat.install``
------------------

It installs Apache Tomcat from tarball.

``tomcat.configure``
--------------------

In configures Apache Tomcat by creating the ``setenv.sh`` file.

``tomcat.daemon``
-----------------

It installs the systemd unit for Apache Tomcat.

``tomcat.purge``
----------------

It purges the environment created with this formula. In particular, it
disables and removes the ``systemd`` unit. Then, it removes all the created
directories. Finally, it remove the system user and group.

References
==========

-  `Apace Tomcat <http://tomcat.apache.org>`__
-  `Salt Formulas <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`__
