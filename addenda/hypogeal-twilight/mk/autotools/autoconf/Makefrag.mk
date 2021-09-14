# This is a -*- Makefile -*- containing GNU make constructs, but may be included in by automake
# construct the lib/libautotools-autoconf.la library containing the configuration TAG thingy.
#
# The TAG (CONFIG) is a qualified C++ name to an enum constant
#
# WATCHOUT - the library name and the SOURCES must be seen by automake (they cannot be defined in here, seen only by GNU make)
#
# Usage:
#   
#   lib_libautotools_autoconf_la_IMPORT = something.something.dark_side
#   lib_libautotools_autoconf_la_TAG    = something::something::dark_side::CONFIG ............................ optional, tag is enum $(...)::CONFIG
#   lib_libautotools_autoconf_la_SOURCE.config.h = config.h .................................................. optional defaults to config.h
#   include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/Makefrag.mk
#
#   Example #1 (the TAG is specified explicitly
#    
#       namespace mod::resting { enum class TAG { } };
#       lib_libautotools_autoconf_la_IMPORT = mod.resting
#       lib_libautotools_autoconf_la_TAG    = mod::resting::TAG
#       lib_libautotools_autoconf_la = lib/libautotools-autoconf.la # ........................................ WATCHOUT ... must be visible to automake
#       lib_libautotools_autoconf_la_SOURCES = obj/src/$(lib_libautotools_autoconf_la_SOURCE).cpp # .......... WATCHOUT ... ibidem.
#       lib_libautotools_autoconf_la_SOURCE.config.h = ... as above .......................................... optional defaults to config.h
#       include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/Makefrag.mk
#    
#   Example #2 (the TAG is computed)
#
#       namespace anthropocene::inveigle::enforcer { enum class CONFIG { } };
#       lib_libautotools_autoconf_la_IMPORT = anthropocene.inveigle.enforcer
#       lib_libautotools_autoconf_la = lib/libautotools-autoconf.la # ........................................ WATCHOUT ... must be visible to automake
#       lib_libautotools_autoconf_la_SOURCES = obj/src/$(lib_libautotools_autoconf_la_SOURCE).cpp # .......... WATCHOUT ... ibidem.
#       lib_libautotools_autoconf_la_SOURCE.config.h = ... as above .......................................... optional defaults to config.h
#       include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/Makefrag.mk
#
include $(hypogeal_twilight_datadir)/mk/autotools/autoconf/definitions.mk

lib_libautotools_autoconf_la_LIBADD = $(nothing)
lib_libautotools_autoconf_la_LDFLAGS = $(PACKAGE_LDFLAGS_SET)
lib_libautotools_autoconf_la_MODULES = $(call SCOLD_SOURCEStoMODULES, $(lib_libautotools_autoconf_la_SOURCES))

lib_libautotools_autoconf_la_CONFIGasDOTS = autotools.autoconf.Config.$(lib_libautotools_autoconf_la_IMPORT).CONFIG
lib_libautotools_autoconf_la_CONFIGasSLASHES = $(subst .,/,$(lib_libautotools_autoconf_la_CONFIGasDOTS))
#
lib_libautotools_autoconf_la_SOURCE.fpp = $(scold_modulesir)/fpp/$(lib_libautotools_autoconf_la_CONFIGasDOTS)
lib_libautotools_autoconf_la_SOURCE.hpp = $(scold_modulesir)/hpp/$(lib_libautotools_autoconf_la_CONFIGasDOTS)
lib_libautotools_autoconf_la_SOURCE.ipp = $(scold_modulesir)/ipp/$(lib_libautotools_autoconf_la_CONFIGasDOTS)
lib_libautotools_autoconf_la_SOURCE.tpp = $(scold_modulesir)/$(lib_libautotools_autoconf_la_CONFIGasDOTS)
lib_libautotools_autoconf_la_SOURCE.cpp = $(scold_cxxdir)/$(lib_libautotools_autoconf_la_CONFIGasSLASHES).cpp
lib_libautotools_autoconf_la_SOURCE.xcpp = $(scold_cxxdir)/$(lib_libautotools_autoconf_la_CONFIGasSLASHES).xcpp
#
lib_libautotools_autoconf_la_TAG = \
  $(addsuffix ::CONFIG, \
    $(strip \
      $(subst .,::, \
        $(if $(lib_libautotools_autoconf_la_IMPORT), \
             $(lib_libautotools_autoconf_la_IMPORT), \
             $(error lib_libautotools_autoconf_la_IMPORT is undefined)))))
#
# yes, SOURCE.xcpp is synthesized into $(scold_cxxdir)
lib_libautotools_autoconf_la_SOURCE.config.h ?= config.h # MUST match the value given in configure.ac AC_CONFIG_HEADRES([config.h])
$(lib_libautotools_autoconf_la_SOURCE.xcpp) : $(lib_libautotools_autoconf_la_SOURCE.config.h)
	mkdir -p $(@D)
	: lib_libautotools_autoconf_la_SOURCE.config.h && test -e $<
	$(htGC) --tag=$(lib_libautotools_autoconf_la_TAG) --import=$(lib_libautotools_autoconf_la_IMPORT) $< $@
	: lib_libautotools_autoconf_la_SOURCE.xcpp && test -e $@
$(scold_cxxdir)/autotools/autoconf/dependencies.mk: $(lib_libautotools_autoconf_la_SOURCE.xcpp)
# else you will see the error:
#
#   obj/modules/fpp/$(lib_libautotools_autoconf_la_MODULE):3:47: fatal error: autotools.autoconf.Config.$(lib_libautotools_autoconf_la_IMPORT): No such file or directory
#   #include <$(lib_libautotools_autoconf_la_IMPORT)> < -------------- you don't want this, it doesn't exist
#
$(scold_cxxdir)/autotools/autoconf/dependencies.mk: bbDC_OPTIONS+=--no-insert-namespace
# because $(bbDC_OPTIONS) expects .../SOURCE.xcpp to be hand-coded in .../src/... not generated in .../obj/src/...
$(scold_cxxdir)/autotools/autoconf/dependencies.mk: scold_srcdir=$(scold_cxxdir)
$(scold_cxxdir)/autotools/autoconf/dependencies.mk: $(lib_libautotools_autoconf_la_SOURCE.xcpp)
	$(AM_V_BB1ST) $(bbDC) $(bbDC_OPTIONS) $(lib_libautotools_autoconf_la_SOURCE.xcpp)
	@touch $@
#	$(AM_V_BB2ND) $(call bbSCOLD_DEPENDENCIES_COMPILE, $(lib_libautotools_autoconf_la_SOURCES))
# You MUST use the $(scold_cxxdir) variable, otherwise automake will try to process the include itself (GNU make must do that)
include $(scold_cxxdir)/autotools/autoconf/dependencies.mk
$(lib_libautotools_autoconf_la_SOURCE.tpp) : $(lib_libautotools_autoconf_la_SOURCE.ipp)
$(lib_libautotools_autoconf_la_SOURCE.ipp) : $(lib_libautotools_autoconf_la_SOURCE.hpp)
$(lib_libautotools_autoconf_la_SOURCE.hpp) : $(lib_libautotools_autoconf_la_SOURCE.fpp)
$(lib_libautotools_autoconf_la_SOURCE.fpp) : $(lib_libautotools_autoconf_la_SOURCE.cpp)
	echo use baleful-ballad, not -- $(aaMC) $@ $(scold_cxx_modulesdir) $(scold_srcdir); \
	: lib_libautotools_autoconf_la_SOURCE.fpp && test -e $@
$(lib_libautotools_autoconf_la_SOURCE.cpp) : $(lib_libautotools_autoconf_la_SOURCE.xcpp)
	: no-insert-namespace because the generated code supplies its own; \
	: use baleful-ballad, not -- $(aaDC) --no-insert-namespace --srcdir=$(scold_cxxdir) --objdir=$(scold_cxxdir) $< ; \
	: WATCHOUT - bbDC_OPTIONS contains --srcdir=$(scold_srcdir) which is wrong;
	$(bbDC)  --no-insert-namespace $(bbDC_OPTIONS) --srcdir=$(scold_cxxdir) $<; \
	: lib_libautotools_autoconf_la_SOURCE.cpp && test -e $@
clean-local::
	rm -f $(scold_cxxdir)/autotools/autoconf/dependencies.mk
	rm -f $(lib_libautotools_autoconf_la_SOURCE.xcpp)
	rm -f $(lib_libautotools_autoconf_la_SOURCE.cpp)
	rm -f $(lib_libautotools_autoconf_la_SOURCE.tpp)
	rm -f $(lib_libautotools_autoconf_la_SOURCE.ipp)
	rm -f $(lib_libautotools_autoconf_la_SOURCE.hpp)
	rm -f $(lib_libautotools_autoconf_la_SOURCE.fpp)
