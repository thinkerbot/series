Series
==============================

Generate series data.

Description
---------------

The series gem provides tools to generate series data from the command line or
in a script using a pluggable architecture (meaning you can add your own
series generators easily).

Usage
---------------

Call the series executable:

    $ series geometric 1 2
    1
    2
    4
    8
    16
    32
    ...

To list the available series, or to get help on an individual series:

    $ series --list
    $ series --help
    $ series geometric --help

Installation
---------------

Series is available as a gem.

    $ gem install series
