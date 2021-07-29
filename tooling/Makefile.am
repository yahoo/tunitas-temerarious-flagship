# This is a GNU -*- Makefile -*- which is managed by automake.
# Copyright Verizon Media
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

# silent-rules has no effect, see configure.ac
# cannot -Wall -Werror
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4

default:
include @temerarious_flagship_datadir@/am/build.am

DEVELOPMENT_AREAS = \
  $(module_nonstd_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_std_prefix) \
  $(module_string_prefix) \
  $(module_sys_prefix) \
  $(tunitas_basics_prefix) \
  $(end)
TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
INSTALLATION_AREAS = \
  $(nonstd_gcc_prefix) \
  $(std_scold_prefix) \
  $(std_tunitas_prefix) \
  $(end)

include src/app/Makefrag.am
include src/app/tf/Makefrag.am
include src/app/roff/Makefrag.am
include src/tests/unit/Makefrag.am
include src/tests/tf/Makefrag.am
include src/tests/roff/Makefrag.am

# install rules arrive from from @temerarious_flagship_datadir@/am/install.am
INSTALL_MODULES = \
  $(lib_libtunitas_application_la_MODULES) \
  $(lib_libtunitas_server_la_MODULES) \
  $(lib_libtunitas_la_MODULES) \
  $(lib_libwant_la_MODULES) \
  $(end)
$(if $(DEBUGGING_CONDITION),$(info DEBUG INSTALL_MODULES=$(INSTALL_MODULES)))

bin_PROGRAMS = $(bin_tf)
libexec_temerarious_flagshipdir = libexec/temerarious-flagship
libexec_temerarious_flagship_PROGRAMS = $(libexec_temerarious_flagship_roff)
lib_LTLIBRARIES = 
noinst_LTLIBRARIES = $(lib_libapp_la) $(lib_libapp_roff_la) $(lib_libapp_tf_la)
check_PROGRAMS = $(check_bin_unit) $(check_bin_tf) $(check_bin_roff)
check_LTLIBRARIES = 

include tests/unit/Makefrag.am
include tests/tf/Makefrag.am
include tests/roff/Makefrag.am
include tests/scripty/roff/Makefrag.am
include tests/scripty/tf/Makefrag.am
XPASS_TESTS = \
  $(tests_unit_XPASS_TESTS) \
  $(tests_tf_XPASS_TESTS) \
  $(tests_roff_XPASS_TESTS) \
  $(tests_scripty_tf_XPASS_TESTS) \
  $(tests_scripty_roff_XPASS_TESTS) \
  $(end)
XFAIL_TESTS = \
  $(tests_unit_XFAIL_TESTS) \
  $(tests_tf_XFAIL_TESTS) \
  $(tests_roff_XFAIL_TESTS) \
  $(tests_scripty_tf_XFAIL_TESTS) \
  $(tests_scripty_roff_XFAIL_TESTS) \
  $(end)
TESTS = \
  $(tests_unit_TESTS) \
  $(tests_tf_TESTS) \
  $(tests_roff_TESTS) \
  $(tests_scripty_tf_TESTS) \
  $(tests_scripty_roff_TESTS) \
  $(end)

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

Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_cppunit@ @CPPFLAGS_no_install@
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
