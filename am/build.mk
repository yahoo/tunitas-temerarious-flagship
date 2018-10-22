# -*- Makefile -*-
# Buy them all, one call does it all.
#
# Usage:  (the Makefile.am)
#     
#    default:
#    SUBDIRS = @subdirs@
#    DEVELOPMENT_AREAS = ...
#    TESTING_AREAS = ...
#    INSTALLATION_AREAS = ...
#    default: all
#    module_SOURCE_SET = ...
#    .PHONY: clean-local mostlyclean-local distclean-local
#    clean-local mostlyclean-local distclean-local::
#    include @temerarious_flagship_datarootdir@/am/build.mk <------------------------------------------- here
#    include src/.../Makefrag.am
#    include src/.../Makefrag.am
#    bin_PROGRAMS = ...
#    lib_LTLIBRARIES = ...
#    noinst_LTLIBRARIES = ...
#    check_PROGRAMS = ...
#    include tests/.../Makefrag.am
#    TESTS = ...
#    ACLOCAL_AMFLAGS = -I m4 -I $(temerarious_flagship_datadir)/ac -I $(temerarious_flagship_datadir)/m4
#    AUTOMAKE_OPTIONS = no-define subdir-objects foreign
#    ...etc...
#    
include $(hypogeal_twilight_datadir)/am/EXTERNAL-PATHS.mk
include $(hypogeal_twilight_datadir)/am/compile.mk
$(if $(DC),$(__OK),$(error DC is not set, you should call TF_PROG_DC in configure.ac))
# temerarious-flagship uses $(DC)
# hypogeal-twilight still uses $(bbDC) but will use $(DC) one day soon
ifeq "remonstrate" "$(bbDC)"
ifeq "1" "$(words $(DC))"
bbDC = $(DC)
endif
endif
TF_DISAGGREGATE_COMPILE = $(call bbSCOLD_DISAGGREGATE_COMPILE,$1)
TF_DEPENDENCIES_COMPILE = $(call bbSCOLD_DEPENDENCIES_COMPILE,$1)
include $(hypogeal_twilight_datadir)/am/install.mk
include $(hypogeal_twilight_datadir)/am/distclean.mk

