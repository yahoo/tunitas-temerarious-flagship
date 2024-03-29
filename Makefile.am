# This is a GNU -*- Makefile -*- which is managed by automake.
# Copyright Yahoo Inc, 2021.
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

# silent-rules has no effect, see configure.ac
# cannot -Wall -Werror
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4
AM_MAKEFLAGS= \
  DO_NOT_REPASS_MAKEFLAGS='$(MAKEFLAGS)' \
  CPPFLAGS='$(CPPFLAGS)' \
  CXXFLAGS='$(CXXFLAGS)' \
  LDFLAGS='$(LDFLAGS)' \
  $(end)

default:
# This bad design ... with limited tooling ... trying to get 'make' and one Makefile to do too many things "automatically"
# This recursion and the ordering can't be fixed or overridden.
#
# WATCHOUT ---> The default 'all' rule DOES NOT pass command-line variable embellishments down one gratuitous level
# WATCHOUT ---> all: config.h
# WATCHOUT --->	     $(MAKE) $(AM_MAKEFLAGS) all-am
# WATCHOUT --->	     $(MAKE) $(AM_MAKEFLAGS) all-am
# WATCHOUT ---> all-am: Makefile $(PROGRAMS) $(LTLIBRARIES) config.h
# WATCHOUT ---> 
# WATCHOUT ---> The default 'check' rule DOES NOT pass command-line variable embellishments down one gratuitous level
# WATCHOUT ---> check: check-am
# WATCHOUT ---> check-am: all-am
# WATCHOUT ---> 	$(MAKE) $(AM_MAKEFLAGS) $(check_PROGRAMS) $(check_LTLIBRARIES)
# WATCHOUT ---> 	$(MAKE) $(AM_MAKEFLAGS) check-TESTS
#
include tests/Makefrag.am
include @temerarious_flagship_datadir@/am/build.am

DEVELOPMENT_AREAS = \
  $(module_langu_prefix) \
  $(module_nonstd_prefix) \
  $(module_cli_core_prefix) \
  $(module_sys_prefix) \
  $(tunitas_basics_prefix) \
  $(deprecated_DEVELOPMENT_AREAS) \
  $(end)
TESTING_AREAS = \
  $(module_rigging_app_prefix) \
  $(module_rigging_core_prefix) \
  $(deprecated_TESTING_AREAS) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_gcc_prefix) \
  $(opt_scold_prefix) \
  $(opt_tunitas_prefix) \
  $(deprecated_INSTALLATION_AREAS) \
  $(end)

include bin/tf.am
include check/bin//catty.am
include check/bin//roff.am
include check/bin//tf.am
include check/bin//unit.am
include check/lib/libtests.am
include libexec/temerarious-flagship/roff.am
include libexec/temerarious-flagship/thunks.am # which recursively includes at least: echo help list ls usage version
include lib/libtunitas-flagship-temerarious.am
include noinst/lib/libapp.am
include noinst/lib/libapp-roff.am
include noinst/lib/libapp-tf.am
include noinst/lib/libautotools-autoconf+tunitas-flagship-temerarious.am
include noinst/lib/libstd+tunitas-flagship-temerarious.am
include noinst/lib/libtunitas-flagship-temerarious.am

include ac/Makefrag.am
include am/Makefrag.am
include mk/Makefrag.am
include bc/Makefrag.am
include modules/Makefrag.am

bin_PROGRAMS = bin/tf
libexec_temerarious_flagshipdir = $(libexecdir)/temerarious-flagship
libexec_temerarious_flagship_PROGRAMS = \
  libexec/temerarious-flagship/echo \
  libexec/temerarious-flagship/help \
  libexec/temerarious-flagship/list \
  libexec/temerarious-flagship/eles \
  libexec/temerarious-flagship/roff \
  libexec/temerarious-flagship/usage \
  libexec/temerarious-flagship/version \
  $(end)
lib_LTLIBRARIES = lib/libtunitas-flagship-temerarious.la
noinst_LTLIBRARIES = \
  noinst/lib/libautotools-autoconf+tunitas-flagship-temerarious.la \
  noinst/lib/libstd+tunitas-flagship-temerarious.la \
  noinst/lib/libtunitas-flagship-temerarious.la \
  noinst/lib/libapp.la \
  noinst/lib/libapp-roff.la \
  noinst/lib/libapp-tf.la \
  $(end)
check_PROGRAMS = \
  check/bin/unit \
  check/bin/catty \
  check/bin/tf \
  check/bin/roff \
  $(end)
check_LTLIBRARIES = check/lib/libtests.la

# SHOULD already be supplied in .../am/build.am
# NEED ---> module_sys_datadir = $(dir $(word 1, $(wildcard $(addsuffix /mk /share/module-sys/mk,$(module_sys_prefix) $(std_scold_prefix) $(prefix)))))
# NEED ---> .PRECIOUS: $(module_sys_datadir)/mk/sys.o.DUMMIES.mk
# NEED ---> include $(module_sys_datadir)/mk/sys.o.DUMMIES.mk

# The Makefile_*SET variables are assembled by .../toolflags.mk

# configure.ac: TF_ENABLE_GCC enables these @-variables
Makefile_COMPILER_CPPFLAGS_SET = @CPPFLAGS_gdb@ @CPPFLAGS_gcc@
Makefile_COMPILER_CFLAGS_SET   =   @CFLAGS_gdb@   @CFLAGS_gcc@
Makefile_COMPILER_CXXFLAGS_SET = @CXXFLAGS_gdb@ @CXXFLAGS_gcc@ -Wno-attributes
Makefile_COMPILER_LDFLAGS_SET  =  @LDFLAGS_gdb@  @LDFLAGS_gcc@  @libstd_filesystem@

# configure.ac: TF_WITH_NONSTD([nonstd-libhttpserver])
Makefile_nonstd_CPPFLAGS_SET = 
Makefile_nonstd_CFLAGS_SET   = 
Makefile_nonstd_CXXLAGS_SET  = 
Makefile_nonstd_LDFLAGS_SET  = 

# extras not otherwise covered by the TF_WITH_MODULE([...]) declarations
Makefile_PACKAGE_CPPFLAGS_SET = 
Makefile_PACKAGE_CFLAGS_SET   = 
Makefile_PACKAGE_CXXLAGS_SET  = 
Makefile_PACKAGE_LDFLAGS_SET  = 

$(if $(checkobj),$(ok),$(error checkobj remains undefined))
Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@ @CPPFLAGS_no_install@ -I$(checkobj)/modules # [[FIXTHIS]] remove with hypogeal-twilight >= 0.48
Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_cppunit@   @CFLAGS_no_install@
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_cppunit@ @CXXFLAGS_no_install@
Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_cppunit@  @LDFLAGS_no_install@

AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
# WATCHOUT - AM_LDFLAGS is not normally included in libtool final-link lines (whereas AM_CPPFLAGS, AM_CXXFLAGS are)
AM_LDFLAGS = $(PACKAGE_LDFLAGS_SET)
AM_LIBTOOLFLAGS = --silent

.PHONY: clean-local mostlyclean-local distclean-local
clean-local mostlyclean-local distclean-local::
clean-dependencies::
clean-local:: clean-dependencies

default: all

deprecated_DEVELOPMENT_AREAS = \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_std_prefix) \
  $(module_string_prefix) \
  $(end)
deprecated_TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
deprecated_INSTALLATION_AREAS = \
  $(none) \
  $(end)
