# This is a -*- Makefile -*- for automake and GNU make. For terms, see the LICENSE file at the top of the repository.

default:
# Makefile.am:  SUBDIRS = @subdirs@
# configure.ac: HGTW_CONFIG_SUBMODULES([submodules], [ ... list ... ])
# ... not yet ... 
# ... SUBDIRS = @subdirs@

# silent-rules has no effect, see configure.ac
# no can do:  -Wall -Werror
AUTOMAKE_OPTIONS = no-define subdir-objects foreign
ACLOCAL_AMFLAGS = -I m4

DEVELOPMENT_AREAS = \
  $(module_boost_prefix) \
  $(module_c_prefix) \
  $(module_format_prefix) \
  $(module_nonstd_prefix) \
  $(module_options_prefix) \
  $(module_posix_prefix) \
  $(module_slurp_prefix) \
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
  $(nonstd_cppunit_prefix) \
  $(nonstd_boost_prefix) \
  $(std_scold_prefix) \
  $(nonstd_gcc_prefix) \
  $(end)

include $(hypogeal_twilight_datarootdir)/am/compile.mk
module_sys_datadir = $(dir $(word 1, $(wildcard $(addsuffix /mk /share/module-sys/mk,$(module_sys_prefix) $(prefix)))))
include $(module_sys_datadir)/mk/sys.o.DUMMIES.mk

# There is no devel packaging right now. there are no modules to install.
# The output of this package is an executable (and its shared libraries).
module_SOURCE_SET = $(nothing)
include $(hypogeal_twilight_datarootdir)/am/install.mk

include src/autotools/autoconf/Makefrag.am
include src/scold/Makefrag.am
include src/remonstrate/Makefrag.am
include src/want/Makefrag.am
include src/tests/unit/Makefrag.am

bin_PROGRAMS = \
  $(bin_remonstrate) \
  $(end)
lib_LTLIBRARIES = \
  $(end)
noinst_LTLIBRARIES = \
  $(lib_libautotools_autoconf_la) \
  $(lib_libscold_la) \
  $(lib_libwant_la) \
  $(end)
check_PROGRAMS = \
  $(check_bin_unit) \
  $(end)
check_LTLIBRARIES = \
  $(end)

# GOALS = ...
# ${goal}_MODULES given ${goal}_SOURCES   foreach goal in $(GOALS)
# $(GOALS_OBJECTS) : $(GOAL_MODULES)
$(eval $(EVAL_GOALS_STANDARD))
$(foreach goal,$(GOALS),$(eval $(call EVAL_SINGLE_SOURCEStoMODULES,$(goal))))
$(eval $(call EVAL_OBJECTSonMODULES,$(GOALS)))

# separable rules for make
pkgmkdir = $(pkgdatadir)/mk
pkgmk_DATA = \
  mk/compile.mk \
  mk/install.mk \
  $(end)

# all the source code will be full-tree-installed therein.
bootstrapdir = $(pkgdatadir)/bootstrap

include tests/unit/Makefrag.am
include tests/unit/fragment/Makefrag.am
include tests/unit/ground/Makefrag.am
include tests/unit/name/Makefrag.am
include tests/unit/phase/Makefrag.am
include tests/unit/processor/Makefrag.am
include tests/unit/scold/Makefrag.am
include tests/unit/search/Makefrag.am
include tests/unit/suffix/Makefrag.am
include tests/unit/to/Makefrag.am
include tests/unit/want/Makefrag.am
include tests/usage/Makefrag.am
include tests/remonstrate/Makefrag.am
TESTS = \
  $(tests_unit_TESTS) \
  $(tests_unit_ground_TESTS) \
  $(tests_unit_name_TESTS) \
  $(tests_unit_path_TESTS) \
  $(tests_unit_phase_TESTS) \
  $(tests_unit_processor_TESTS) \
  $(tests_unit_search_TESTS) \
  $(tests_unit_scold_TESTS) \
  $(tests_unit_suffix_TESTS) \
  $(tests_unit_to_TESTS) \
  $(tests_unit_want_TESTS) \
  $(tests_usage_TESTS) \
  $(tests_remonstrate_TESTS) \
  tests/self.test \
  $(end)

# increasing formulaic boilerplate below here

# committing to hypogeal-twilight v0.42
# these are absorbed via .../mk/toolflags.mk via .../mk/compile.mk

Makefile_nonstd_PACKAGE_CPPFLAGS_SET = @nonstd_boost_CPPFLAGS@
Makefile_nonstd_PACKAGE_CFLAGS_SET   = @nonstd_boost_CFLAGS@  
Makefile_nonstd_PACKAGE_CXXFLAGS_SET = @nonstd_boost_CXXFLAGS@
Makefile_nonstd_PACKAGE_LDFLAGS_SET  = @nonstd_boost_LDFLAGS@ 
Makefile_nonstd_CHECK_CPPFLAGS_SET   = @nonstd_cppunit_CPPFLAGS@
Makefile_nonstd_CHECK_CFLAGS_SET     = @nonstd_cppunit_CFLAGS@
Makefile_nonstd_CHECK_CXXFLAGS_SET   = @nonstd_cppunit_CXXFLAGS@
Makefile_nonstd_CHECK_LDFLAGS_SET    = @nonstd_cppunit_LDFLAGS@

Makefile_COMPILER_CPPFLAGS_SET = @CPPFLAGS_gcc@ 
Makefile_COMPILER_CFLAGS_SET   =   @CFLAGS_gcc@   @CFLAGS_gdb@
Makefile_COMPILER_CXXFLAGS_SET = @CXXFLAGS_gcc@ @CXXFLAGS_gdb@
Makefile_COMPILER_LDFLAGS_SET  =  @LDFLAGS_gcc@  @LDFLAGS_gdb@
Makefile_PACKAGE_CPPFLAGS_SET  =  @CPPFLAGS_boost@ @CPPFLAGS_uuid@
Makefile_PACKAGE_CFLAGS_SET    =    @CFLAGS_boost@   @CFLAGS_uuid@
Makefile_PACKAGE_CXXFLAGS_SET  =  @CXXFLAGS_boost@ @CXXFLAGS_uuid@
Makefile_PACKAGE_LDFLAGS_SET   =   @LDFLAGS_boost@  @LDFLAGS_uuid@
Makefile_CHECK_CPPFLAGS_SET    = @CPPFLAGS_cppunit@
Makefile_CHECK_CFLAGS_SET      =   @CFLAGS_cppunit@
Makefile_CHECK_CXXFLAGS_SET    = @CXXFLAGS_cppunit@
Makefile_CHECK_LDFLAGS_SET     =  @LDFLAGS_cppunit@ @LDFLAGS_no_install@ # hypogeal-twilight >= 0.45

AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
AM_LDFLAGS  = $(PACKAGE_LDFLAGS_SET)$(warning AM_LDFLAGS is dubiously deprecating, use specific "$@"_LDFLAGS=$$(PACKAGE_LDFLAGS_SET))
# hypogeal-twilight 0.42 is required, hypogeal-twilight >= 0.45 is expected
#end
