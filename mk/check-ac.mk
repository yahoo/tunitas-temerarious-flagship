# This is a GNU -*- Makefile -*- fragment, included by automake from the top-level Makefile.am
# Copyright Yahoo Inc, 2021.
# Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.
# See the LICENSE file at the top of this repository.

# make check SLOW=1
#
# These are very very slow tests.  They run the autotools buildconf-configure-make process for each and every known m4 macro
# to "prove" that it compiles and (uh) works for some basic definition of "works"   You want to run these at least at release signoff.
#
# WATCHOUT - be sure to run these tests ONLY afer the "all" part of the build system has stabilized.  That's quirky to do in automake.
#
#   check: check-am
#   check-am: all-am
# 	$(MAKE) $(AM_MAKEFLAGS) $(check_PROGRAMS) $(check_LTLIBRARIES)
# 	$(MAKE) $(AM_MAKEFLAGS) check-TESTS
#
# Solution:
#                                 <------ pointless (incorrect) ------>
#   $(TESTS_AC.fast) : check-am # $(check_PROGRAMS) $(check_LTLIBRARIES)
#   $(TESTS_AC.slow) : check-am # $(check_PROGRAMS) $(check_LTLIBRARIES)
#
# WATCHOUT - whereas the 'install' rule is known to automake and can't be appended into, 'check' has no such behavior
# n.b. we thus CAN depend upon augmantations of 'make check'
check: check-ac-$(if $(SLOW),slow,fast)

TESTS_AC.test = $(wildcard tests/ac/*/run.test)
TESTS_AC.fast = $(patsubst %.test, %.fast, $(TESTS_AC.test))
TESTS_AC.slow = $(patsubst %.test, %.slow, $(TESTS_AC.test))

# align the prettiness
# witness
#  "  CXX      obj/src/tests/unit/variable.Fixture.o"

.PHONY: check-ac-fast
check-ac-fast: $(TESTS_AC.fast)
$(TESTS_AC.fast) : check-am # $(check_PROGRAMS) $(check_LTLIBRARIES)
.PHONY: $(__TESTS_AC.fast)
$(TESTS_AC.fast) : %.fast : %.test
	@echo "FAST: (skipped) $<"

.PHONY: check-ac-slow
check-ac-slow: $(TESTS_AC.slow)
$(TESTS_AC.slow) : check-am # $(check_PROGRAMS) $(check_LTLIBRARIES)
.PHONY: $(__TESTS_AC.slow)
$(TESTS_AC.slow) : %.slow : %.test
	@tests/ac/driver $<

__TESTS_AC.REQUIRED := $(shell tests/ac/generate-test-list ac/*.m4)
__TESTS_AC.OBSERVED = $(patsubst %/,%, $(dir $(wildcard tests/ac/*/run.test)))
__TESTS_AC.MISSING = $(filter-out $(__TESTS_AC_OBSERVED), $(__TESTS_AC_REQUIRED))
$(if $(__TESTS_AC.MISSING),$(error the following m4 macro AC_DEFUN have no tests $(__TESTS_AC.MISSING)))
debug.required-test-list: ; echo $(__TESTS_AC.REQUIRED)
debug.observed-test-list: ; echo $(__TESTS_AC.OBSERVED)
