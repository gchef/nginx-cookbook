DESCRIPTION
====

Installs nginx from package OR source code and sets up configuration handling similar to Debian's Apache2 scripts.

REQUIREMENTS
====

Cookbooks
----

* build-essential (for nginx::source)
* runit (for nginx::source)

Platform
----

Debian or Ubuntu though may work where 'build-essential' works, but other platforms are untested.
