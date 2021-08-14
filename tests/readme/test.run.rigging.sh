#!/bin/bash --norc
#
# This script is not run this directly, as-is.
# This script is run through the symlinks named "run.test" in the directories below.
# This is the target of the symlinks */run.test
#
# Poetry and Symmetry:
#
#   "test.run.rigging" is rigging.run.test backwards
#   the ".sh" is to remind us that this is a shell script
#
# Usage:
#
#   cd $topdir
#   cd tests/readme/nn.something_something
#   ln -s ../test.run.rigging.sh run.test
#
#   cd $topdir
#   tests/readme/00.universe/run.test .................... for example
#
#
#        /--------------------------- this is $0 from .../tests/readme/*/ltest
#        |
#        v
source ${0%/*}/../rigging.sh || exit ${EX_NORIGGING:-117}
tf roff ${directory?}/example.roff ${directory?}/o.example.roffed
