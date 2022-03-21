# This GNU -*- Makefile -*- fragment may be included directly by automake
# Copyright Oath Inc.
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE
#
# The magic rules to ensure that the "modules" ending in ".o" do not get rebuilt as object files.
# and make (GNU make) really really wants to interpret *.o files as object files.
#
# The trickery here is to be able to find these prophylactic rules either in the development area
# or in the installed area with or without an establishment of module-sys as a development area.
#
# Whereas:
#
#   prefix will always exist and will always point to an installation tree
#   module_sys_prefix may or may not exist
#   module_sys_prefix may or may not point to an installation tree or to a development tree
#   let $(root) be some prefix variable
#     the installation tree prefers $(root)/share/module-sys/mk
#     the development tree prefers $(root)/mk
#
# Usage:
#
#   module_sys_datadir = $(dir $(word 1, $(wildcard $(addsuffix /mk /share/module-sys/mk,$(module_sys_prefix) $(std_scold_prefix) $(prefix)))))
#   include $(module_sys_datadir)/mk/sys.o.DUMMIES.mk
#
# WATCHOUT - the following is needed to prevent make from trying to rebuild sys.o
#
#   gcc   /build/scold/module-sys/obj/modules/sys.o   -o /build/scold/module-sys/obj/modules/sys
#   /usr/bin/ld:/build/scold/module-sys/obj/modules/sys.o: file format not recognized; treating as linker script
#   /usr/bin/ld:/build/scold/module-sys/obj/modules/sys.o:1: syntax error
#
sys_DUMMIES_prefix = $(if $(module_sys_prefix), $(module_sys_prefix), $(prefix))
sys_DUMMIES = \
  $(foreach module, $1, \
	    $(foreach obj, \
		      / /obj/, \
		      $(foreach ppp, \
				/ /ipp/ /hpp/ /fpp/, \
                                $(addprefix $(sys_DUMMIES_prefix), \
					    $(obj)modules$(ppp)$(module)))))
sys_DUMMIES_MODULES = $(call sys_DUMMIES, sys)
$(sys_DUMMIES_MODULES): ; @exit 0
sys_o_DUMMIES_MODULES = $(call sys_DUMMIES, sys.o)
$(sys_o_DUMMIES_MODULES): ; @exit 0
$(if $(DEBUGGING_CONDITION),\
$(info DEBUG sys_DUMMIES_MODULES=[$(sys_DUMMIES_MODULES)])\
$(info DEBUG sys_o_DUMMIES_MODULES=[$(sys_o_DUMMIES_MODULES)]))
