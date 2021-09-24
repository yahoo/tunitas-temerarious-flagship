# This is a -*- Makefile -*- which will be used by GNU Make
# Copyright Yahoo Inc. 2021.
# Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.
# See the LICENSE file at the top of this repository.
default:
all:
install:
check:
clean:
realclean:
distclean:


# nothing yet
.PHONY: all
all:

.PHONY: install
install: ; echo "[[FIXTHIS]] see temerarious-flagship.spec which open codes the component installation."

.PHONY: check
check: check-ac

TESTS_AC.test = $(wildcard tests/ac/*/run.test)
TESTS_AC.that = $(patsubst %.test, %.that, $(TESTS_AC.test))
.PHONY: check-ac
check-ac: $(TESTS_AC.that)

.PHONY: $(__TESTS_AC.that)
$(TESTS_AC.that) : %.that : %.test
	@tests/ac/driver $<

__TESTS_AC.REQUIRED := $(shell tests/ac/generate-test-list ac/*.m4)
__TESTS_AC.OBSERVED = $(patsubst %/,%, $(dir $(wildcard tests/ac/*/run.test)))
__TESTS_AC.MISSING = $(filter-out $(__TESTS_AC_OBSERVED), $(__TESTS_AC_REQUIRED))
$(if $(__TESTS_AC.MISSING),$(error the following m4 macro AC_DEFUN have no tests $(__TESTS_AC.MISSING)))
debug.required-test-list: ; echo $(__TESTS_AC.REQUIRED)
debug.observed-test-list: ; echo $(__TESTS_AC.OBSERVED)
