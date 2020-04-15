# This is a -*- Makefile -*- which will be used by GNU Make
# Copyright, Verizon Media.
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

.PHONY: $(TESTS_AC.that)
$(TESTS_AC.that) : %.that : %.test
	@tests/ac/driver $<
