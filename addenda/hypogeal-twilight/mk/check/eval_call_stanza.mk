# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
hypogeal_twilight_check_eval_call_stanza_mk_included = 1

#
# Usage:
# 
#     $(eval $(call check_make_stanza, tests/autotools))
#     $(eval $(call check_make_stanza, tests/case-01))
#     $(eval $(call check_make_stanza, tests/case-02))
#
#     $(eval $(call check_driver_stanza, tests/configure, $(CONFIGURE_TESTS)))
#     $(eval $(call check_driver_stanza, tests/unit, $(UNIT_TESTS)))
#

ifeq "undefined" "$(flavor hypogeal_twilight_check_verbosity_mk_included)"
include $(hypogeal_twilight_datarootdir)/mk/check/verbosity.mk
endif

#
# In the Makefile, hook up syntax checking to check-basics
#
#     check-basics: check-PERL check-BASH ... etc
#
.PHONY: check-basics
check-basics:

#
# Usage: 
#  Usage: $(eval $(call check_make_stanza, <directory>, <tests-to-clean>)
#
# e.g.
#     <directory> = tests/something
#     <tests-to-clean> = tests/something/test1.test tests/something/test2.test
#
# Requirement
#     <directory>/Makefile   and generally $(test_Makefile)
#     the Makefile must respond to [default] 'all' 'check' 'clean' 'distclean'
#
# Also
#    to make something happen before the test, declare a dependency upon check-<directory>
#    e.g.
#        check-tests/something: do_this_first
#        do_this_first: ; echo first!
#        $(eval $(call check_driver_stanza, <directory>, <test-list>)
#
define check_make_stanza
check: check-$(strip $1)
check-$(strip $1): check-basics
	$(__check_ecs__MAKE_check)
clean: clean-$(strip $1)
clean-$(strip $1): clean-$(strip $1)_and_also
clean-$(strip $1)_and_also:
	$(call __check_ecs__clean_and_also, $2)
clean-$(strip $1):
	$(_check_ecs__MAKE_generic)
distclean: distclean-$(strip $1)
distclean-$(strip $1): clean-$(strip $1)
endef

#
# Usage: $(eval $(call check_driver_stanza, <directory>, <test-list>)
#
# e.g.
#    <directory> = tests/something
#    <test-list> = test/something/test1.test test/something/test2.test test/something/test3.test
#
# Requirement
#    <directory>/driver exists as an executable, accepting a list of tests to run
#    usage: driver ...tests...
#
# Also
#    to make something happen before the test, declare a dependency upon check-<directory>
#    e.g.
#        check-tests/something: do_this_first
#        do_this_first: ; echo first!
#        $(eval $(call check_driver_stanza, <directory>, <test-list>)
#
define check_driver_stanza
check: check-$(strip $1)
check-$(strip $1): check-basics
	$(V_TEST) $(strip $1)/driver $2
clean: clean-$(strip $1)
clean-$(strip $1): clean-$(strip $1)_and_also
clean-$(strip $1)_and_also:
	$(call __check_ecs__clean_and_also, $2)
distclean: distclean-$(strip $1)
distclean-$(strip $1): clean-$(strip $1)
endef

# Override to use another Makefile; e.g. case-02 uses driver.Makefile
test_Makefile = Makefile 

define __check_ecs__MAKE_check
	$(V_TEST) dir=$$(strip $$(patsubst check-%,%,$$@)); \
	$(MAKE) -C "$$$$dir" -f $$(test_Makefile) check > "$$$$dir.log" 2>&1; \
	e=$$$$?; \
	echo "$$$$dir exit $$$$e" > "$$$$dir.state"; \
	exit $$$$e
endef
define _check_ecs__MAKE_generic
	$(V_TEST) $(MAKE) \
	    -C $$(patsubst \
	          check-%,%, \
	          $$(patsubst \
	             clean-%,%, \
	             $$(patsubst \
	                distclean-%,%, \
	                $$@))) \
	    $$(patsubst \
	       $$(addprefix %-, \
	          $$(patsubst \
	             check-%,%, \
	             $$(patsubst \
	                clean-%,%, \
	                $$(patsubst \
	                   distclean-%,%, \
	                   $$@)))), \
	       %, \
	       $$@) \
	$(end)
endef
define __check_ecs__clean_and_also
	rm -f $$(addsuffix .log, $$(patsubst %.test,%,$1))
	rm -f $$(addsuffix .state, $$(patsubst %.test,%,$1))
endef
