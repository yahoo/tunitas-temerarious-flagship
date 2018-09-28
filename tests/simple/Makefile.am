# This is a GNU -*- Makefile -*- which is managed by automake
#
# Following the pattern documented in $(temerarious_flagship_datadir)/am/build.mk

default:
# read by autoreconfigure, as a shell line, not as a Makefile line
# development areas first (they may not exist); installation areas 2nd (they also may not exit
ACLOCAL_AMFLAGS = -I m4
AUTOMAKE_OPTIONS = no-define subdir-objects foreign

include @temerarious_flagship_datadir@/am/build.am
include src/Makefrag.am
include tests/Makefrag.am
bin_PROGRAMS = bin/hello-world
TESTS = $(tests_TESTS)
