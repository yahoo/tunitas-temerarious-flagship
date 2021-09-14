# -*- Makefile -*-
# This is a -*- Makefile -*- fragment.
# For terms and provenance see the LICENSE file at the top of this repository.

# silent-rules has no effect, see configure.ac
# cannot use -Wall -Werror because $(shell ...) is used herein
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4

default:
include @hypogeal_twilight_datarootdir@/am/compile.mk

# The following must be consistent
# configure.ac: HGTW_CONFIG_SUBMODULES([submodules], [ ...list...])
# Makefile.am:  SUBDIRS = @subdirs@

# WATCHOUT in automake you can't tie 'check' to 'install'
check:

clean-dependencies::
clean-local:: clean-dependencies

# These must match the HGTW_MODULE declarations in confgiure.ac
DEVELOPMENT_AREAS = \
  $(module_half_prefix) \
  $(module_nonstd_prefix) \
  $(module_posix_prefix) \
  $(module_std_prefix) \
  $(module_string_prefix) \
  $(module_sys_prefix) \
  $(module_uuid_prefix) \
  $(end)
TESTING_AREAS = \
  $(module_cppunit_prefix) \
  $(module_rigging_prefix) \
  $(end)
INSTALLATION_AREAS =\
  $(nonstd_gcc_prefix) \
  $(std_scold_prefix) \
  $(end)

include src/app/dc/Makefrag.am
include src/lite/Makefrag.am
include src/scold/Makefrag.am
include src/scold/easy/Makefrag.am
include src/tests/unit/Makefrag.am
include src/want/Makefrag.am

INSTALL_MODULES = $(none)

bin_PROGRAMS = \
  $(bin_dc) \
  $(end)
lib_LTLIBRARIES = \
  $(lib_libscold_anguish_answer_module_la) \
  $(end)
noinst_LTLIBRARIES = \
  $(lib_liblite_la) \
  $(lib_libscold_easy_la) \
  $(lib_libwant_la) \
  $(end)
check_PROGRAMS = \
  $(check_bin_unit) \
  $(end)
check_LTLIBRARIES = \
  $(end)

# NO NEED ---> $(bin_PROGRAMS) : $(lib_LTLIBRARIES) $(noinst_LTLIBRARIES)
# NO NEED ---> $(lib_LTLIBRARIES) : $(noinst_LTLIBRARIES)
# NO NEED ---> $(check_PROGRAMS) : $(check_LTLIBRARIES)
# NO NEED ---> $(check_PROGRAMS)  $(check_LTLIBRARIES) : $(bin_PROGRAMS) $(lib_LTLIBRARIES) $(noinst_LTLIBRARIES)

module_sys_datadir = $(dir $(word 1, $(wildcard $(addsuffix /mk /share/module-sys/mk,$(module_sys_prefix) $(std_scold_prefix) $(prefix)))))
.PRECIOUS: $(module_sys_datadir)/mk/sys.o.DUMMIES.mk
include $(module_sys_datadir)/mk/sys.o.DUMMIES.mk

include tests/unit/Makefrag.am
include tests/scripty/dc/Makefrag.am
TESTS = \
  $(tests_unit_TESTS) \
  $(tests_dc_TESTS) \
  $(end)
XFAIL_TESTS = \
  $(tests_unit_XFAIL_TESTS) \
  $(tests_dc_XFAIL_TESTS) \
  $(end)

# Reminder...
# Debugging
#   -ggdb can't tolerate -O
#   -ggdb is specified via configure --enable-gdb
# Standards (C++17, 20, 23)
#   always -Wall or else the language isn't complete (can functions without return statements, etc.)
#   recall: c++1y vs c++1z and -fconcepts
#
# -Wno-attributes since we use non-standard attributes to document semantic flavorings.
#   e.g. 'namespace [[eponymous something { ... somehow... }
#
# and remember -fsyntax-only to just check syntax (but codegen isn't that expensive it turns out)
# https://www.gnu.org/software/libtool/manual/html_node/Link-mode.html#Link-mode
#     
# -no-fast-install
#
#    Disable fast-install mode for the executable output-file.
#    Useful if the program won’t be necessarily installed.
#
# -no-install
#
#    Link an executable output-file that can’t be installed and therefore doesn’t need a wrapper script.
#    This is useful if the program is only used in the build tree, e.g., for testing or generating other files.
#
# This is handled by hypogeal-twilight >= 0.45, available any time now, and hopefully soon.
#
Makefile_COMPILER_CPPFLAGS_SET = @CPPFLAGS_gcc@ @CPPFLAGS_gdb@
Makefile_COMPILER_CFLAGS_SET   =   @CFLAGS_gcc@   @CFLAGS_gdb@
Makefile_COMPILER_CXXFLAGS_SET = @CXXFLAGS_gcc@ @CXXFLAGS_gdb@ -Wno-attributes
Makefile_COMPILER_LDFLAGS_SET  =  @LDFLAGS_gcc@  @LDFLAGS_gdb@ @libstd_filesystem@

Makefile_PACKAGE_CPPFLAGS_SET = @CPPFLAGS_uuid@
Makefile_PACKAGE_CFLAGS_SET   =    @FLAGS_uuid@
Makefile_PACKAGE_CXXFLAGS_SET = @CXXFLAGS_uuid@
Makefile_PACKAGE_LDFLAGS_SET  =  @LDFLAGS_uuid@

Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_no_install@
Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_no_install@
Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_no_install@
Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_no_install@

# These are assembled by hypogeal-twilight >= 0.44 .../mk/toolflags.mk
AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)# WATCHOUT - $(AM_LDFLAGS) is not in any automake rules; use $(PACKAGE_LDFLAGS_SET) at the link site
AM_LIBTOOLFLAGS = --silent
#end
