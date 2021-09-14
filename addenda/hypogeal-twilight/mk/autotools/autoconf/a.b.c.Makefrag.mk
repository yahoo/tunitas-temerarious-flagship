# This is a -*- Makefile -*-
#
# Usage:
#
#   lib_libautotools_autoconf_la_NAME_a = NAME1
#   lib_libautotools_autoconf_la_NAME_b = NAME2
#   lib_libautotools_autoconf_la_NAME_c = NAME3
#   lib_libautotools_autoconf_la_SOURCE.config.h = <-------------------- optional, defaults to config.h
#   include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/a.b.c.Makefrag.mk
#   lib_libautotools_autoconf_la = lib/libautotools-autoconf.la
#   lib_libautotools_autoconf_la_LIBADD = <----------------------------- computable
#   lib_libautotools_autoconf_la_LDFLAGS = <---------------------------- computable
#   lib_libautotools_autoconf_la_MODULES = <---------------------------- computable
#   lib_libautotools_autoconf_la_SOURCES = <---------------------------- must be literal values
#
#   e.g. 
#     lib_libautotools_autoconf_la_SOURCES = obj/src/autotools/autoconf/Config/abalone/bombast/catcher/CONFIG.cpp
#
# WATCHOUT - the nearby $(lib_libautotools_autoconf_*_la_SOURCES) must be literal names so automake can see them.
#
#   a.Makefrag.mk may be used nearby.
# a.b.Makefrag.mk may be used nearby.
#
$(if $(lib_libautotools_autoconf_la_NAME_a),$(__ok),$(error lib_libautotools_autoconf_la_NAME_a must be declared as a single-word identifier))
$(if $(lib_libautotools_autoconf_la_NAME_b),$(__ok),$(error lib_libautotools_autoconf_la_NAME_b must be declared as a single-word identifier))
$(if $(lib_libautotools_autoconf_la_NAME_c),$(__ok),$(error lib_libautotools_autoconf_la_NAME_c must be declared as a single-word identifier))
include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/definitions.mk

# whereas $(lib_libautotools_autoconf_a_b_c_la_SOURCES) must be literal names, the following *could* be computed values.
#
# Suffix      Separator   Example
# --------------------------------------------------
# NAMEFRAG    ::          NAMEFRAG = a::b::c
# PATHFRAG    /           NATHFRAG = a/b/c
# MODULE      .           NODULE   = a.b.c
#
lib_libautotools_autoconf_a_b_c_la_NAMEFRAG = $(lib_libautotools_autoconf_la_NAME_a)::$(lib_libautotools_autoconf_la_NAME_b)::$(lib_libautotools_autoconf_la_NAME_c)
lib_libautotools_autoconf_a_b_c_la_PATHFRAG = $(lib_libautotools_autoconf_la_NAME_a)/$(lib_libautotools_autoconf_la_NAME_b)/$(lib_libautotools_autoconf_la_NAME_c)
lib_libautotools_autoconf_a_b_c_la_MODULE   = $(lib_libautotools_autoconf_la_NAME_a).$(lib_libautotools_autoconf_la_NAME_b).$(lib_libautotools_autoconf_la_NAME_c)
# yes, CONFIG.xcpp is synthesized into $(scold_cxxdir)
lib_libautotools_autoconf_la_SOURCE.config.h ?= config.h
$(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp : $(lib_libautotools_autoconf_la_SOURCE.config.h)
	$(V_HTmkdir) mkdir -p $(@D)
	$(V_HTGC) $(htGC) --tag=$(lib_libautotools_autoconf_a_b_c_la_NAMEFRAG)::CONFIG --import=$(lib_libautotools_autoconf_a_b_c_la_MODULE) $< $@
$(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk: $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp
# else you will see the error:
#
#   obj/modules/fpp/autotools.autoconf.Config.a.b.c.CONFIG:3:47: fatal error: autotools.autoconf.Config.a.b.c: No such file or directory
#   #include <autotools.autoconf.Config.a.b.c> < -------------- you don't want this, it doesn't exist
#
$(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk: bbDC_OPTIONS+=--no-insert-namespace
# because $(bbDC_OPTIONS) expects .../CONFIG.xcpp to be hand-coded in .../src/... not generated in .../obj/src/...
$(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk: scold_srcdir=$(scold_cxxdir)
$(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk: Makefile
	test -e Makefile
	test -e $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp
	$(AM_V_BB1ST) $(bbDC) $(bbDC_OPTIONS) $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp
	touch $@
#	$(AM_V_BB2ND) $(call bbSCOLD_DEPENDENCIES_COMPILE, $(lib_libautotools_autoconf_a_b_c_la_SOURCES))
# You MUST use the $(scold_cxxdir) variable, otherwise automake will try to process the include itself (GNU make must do that)
include $(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk
$(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.cpp : $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp
	: no-insert-namespace because the generated code supplies its own; \
	: use baleful-ballad, not -- $(aaDC) --no-insert-namespace --srcdir=$(scold_cxxdir) --objdir=$(scold_cxxdir) $< ; \
	: WATCHOUT - bbDC_OPTIONS contains --srcdir=$(scold_srcdir) which is wrong;
	$(bbDC)  --no-insert-namespace $(bbDC_OPTIONS) --srcdir=$(scold_cxxdir) $<; \
	test -e $@
$(scold_cxx_modulesdir)/fpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG : $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.cpp
	echo use baleful-ballad, not -- $(aaMC) $@ $(scold_cxx_modulesdir) $(scold_srcdir); \
	test -e $@
$(scold_cxx_modulesdir)/hpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG : $(scold_cxx_modulesdir)/fpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
$(scold_cxx_modulesdir)/ipp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG : $(scold_cxx_modulesdir)/hpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
$(scold_cxx_modulesdir)/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG : $(scold_cxx_modulesdir)/ipp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
$(scold_cxx_modulesdir)/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG : $(scold_cxx_modulesdir)/$(lib_libautotools_autoconf_a_b_c_la_MODULE)
clean-dependencies::
	rm -f $(scold_cxxdir)/autotools/autoconf/a.b.c.dependencies.mk
clean-local::
	rm -f $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.xcpp
	rm -f $(scold_cxxdir)/autotools/autoconf/Config/$(lib_libautotools_autoconf_a_b_c_la_PATHFRAG)/CONFIG.cpp
	rm -f $(scold_cxx_modulesdir)/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
	rm -f $(scold_cxx_modulesdir)/ipp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
	rm -f $(scold_cxx_modulesdir)/hpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
	rm -f $(scold_cxx_modulesdir)/fpp/autotools.autoconf.Config.$(lib_libautotools_autoconf_a_b_c_la_MODULE).CONFIG
