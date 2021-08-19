# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
# was once .../am/EXTERNAL-PATHS.mk
hypogeal_twilight_toolflags_mk_included = 1

#
# Develop definitions for TOOL in { CPP, C, CXX, LD }
#
#    PACKAGE_${TOOL}FLAGS_SET
#    CHECK_${TOOL}FLAGS_SET
#    AND_CHECK_${TOOL}FLAGS_SET
#
# Using Makefile (Makefile.am) level definitions
# these definitions must be made where automake's @variable@ substituions can occur.
#
#    Makefile_COMPILER_${TOOL}FLAGS_SET       ... optional
#    Makefile_PACKAGE_${TOOL}FLAGS_SET   ... for the package as a whole
#    Makefile_CHECK_${TOOL}FLAGS_SET     ... plus these for "checking"
#
# Usage:
#
#     DEVELOPMENT_AREAS   = ...@module_${MODULE}_prefix@... for many ${MODULE}
#     TESTING_AREAS       = ...@module_${MODULE}_prefix@... for many ${MODULE}
#     INSTALLATION_AREAS  = ...@nonstd_${COMPONENT}_prefix@... for many ${COMPONENT} @std_scold_prefix@
#     ...etc...
#     Makefile_COMPILER_CPPFLAGS_SET  = @CPPFLAGS_gcc@ 
#     Makefile_COMPILER_CFLAGS_SET    =   @CFLAGS_gcc@   @CFLAGS_gdb@
#     Makefile_COMPILER_CXXFLAGS_SET  = @CXXFLAGS_gcc@ @CXXFLAGS_gdb@
#     Makefile_COMPILER_LDFLAGS_SET   =  @LDFLAGS_gcc@  @LDFLAGS_gdb@
#     Makefile_PACKAGE_CPPFLAGS_SET =  @CPPFLAGS_boost@ @CPPFLAGS_sqlite@ 
#     Makefile_PACKAGE_CFLAGS_SET   =    @CFLAGS_boost@   @CFLAGS_sqlite@
#     Makefile_PACKAGE_CXXFLAGS_SET =  @CXXFLAGS_boost@ @CXXFLAGS_sqlite@
#     Makefile_PACKAGE_LDFLAGS_SET  =   @LDFLAGS_boost@  @LDFLAGS_sqlite@
#     Makefile_CHECK_CPPFLAGS_SET   = @CPPFLAGS_cppunit@
#     Makefile_CHECK_CFLAGS_SET     =   @CFLAGS_cppunit@
#     Makefile_CHECK_CXXFLAGS_SET   = @CXXFLAGS_cppunit@
#     Makefile_CHECK_LDFLAGS_SET    =  @LDFLAGS_cppunit@
#     include @hypogeal_twilight_datarootdir@/mk/compile.mk
#     AM_CPPFLAGS = $(PACKAGE_CPPFLAGS_SET)
#     AM_CFLAGS   = $(PACKAGE_CFLAGS_SET)
#     AM_CXXFLAGS = $(PACKAGE_CXXFLAGS_SET)
#     AM_LDFLAGS  = $(V_LDFLAGS_avoid.VERBOSE_Veq$(V))
#           ... the global AM_LDFLAGS is deprecating; each DSO and EXE must define individual LDADD and LDFLAGS
#     AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))
#
# Inputs
#   DEVELOPMENT_AREAS             - submodule areas that you're developing against
#   TESTING_AREAS                 - submodule areas with test rigging
#   INSTALLATION_AREAS            - (post-development) readonly installation areas
#
# Outputs
#   [[deprecated]] AREAS                         - the concatenation of the $(*_AREAS)
#   [[deprecated]] SEARCHPATH_EXTERNAL_MODULES   - all the -I options
#   [[deprecated]] LOADPATH_EXTERNAL_MODULES     - all the -L options
#
# Example
#   DEVELOPMENT_AREAS = @module_c_prefix@ @module_format_prefix@
#   TESTING_AREAS = @module_cppunit_prefix@ @module_unit_rigging_prefix@
#   INSTALLATION_AREAS = @nonstd_gcc_prefix@ @std_scold_prefix@
#

AREAS = \
  $(if $(VERBOSITY_CONDITION), \
       $(warning deprecation: the variable AREAS is deprecating, begin to avoid using it) \
       $(warning deprecation: instead use a separation of DEVELOPMENT_AREAS & TESTING_AREAS and INSTALLATION_AREAS)) \
  $(DEVELOPMENT_AREAS) \
  $(TESTING_AREAS) \
  $(INSTALLATION_AREAS) \
  $(end)

# These are the modules (as include files) *within* the current tree.
__toolflags_SEARCHPATH_JUSTBUILT_MODULES = \
  $(addprefix -I, \
              $(srcdir)/modules $(srcdir)/include \
              $(scold_cxx_includedir) $(scold_cxx_modulesdir) \
              $(comment deprecated) $(scold_cxxdir)) \
  $(end)
SEARCHPATH_SCOLD_MODULES = $(warning toolflags.mk SEARCHPATH_SCOLD_MODULES)\
  $(__toolflags_SEARCHPATH_JUSTBUILT_MODULES) \
  $(if $(VERBOSITY_CONDITION), \
       $(warning deprecation: the variable SEARCHPATH_SCOLD_MODULES is deprecated, do not use it) \
       $(warning deprecation: instead use PACKAGE_CPPFLAGS_SET)) \
  $(end)

# Decision: we do want -L@(abs_top_builddir)/lib
# This is only really significant when a single build area produces multiple libraries
# in that case we need all of -LPATH, -Wl,-rpath=PATH and -lLIB
# and also we want a dependency so that concurrent building "just works"
#
#   lib_librigging_bench_module_la = lib/librigging-bench-module.la
#   lib_librigging_bench_module_la_LIBADD = \
#     -lrigging-unit-module \
#     $(end)
#   lib_librigging_bench_module_la_LDFLAGS = $(PACKAGE_LDFLAGS_SET)
#
# AND we also need this local rpath to "disappear" when the library is finally installed.
# so use -L.../lib but not -Wl,-rpath=.../lib
#
__toolflags_LOADPATH_JUSTBUILT_MODULES = \
  $(addprefix -L, \
              $(addsuffix /lib, \
                          $(word 1, $(abs_builddir) $(srcdir) $(PWD)))) \
  $(end)
LOADPATH_SCOLD_MODULES = \
  $(__toolflags_LOADPATH_JUSTBUILT_MODULES) \
  $(if $(VERBOSITY_CONDITION), \
       $(warning deprecation: the variable LOADPATH_SCOLD_MODULES is deprecating, avoid new uses of it) \
       $(warning deprecation: instead use PACKAGE_LDFLAGS_SET)) \
  $(end)

# Delicate issues ...
#
# remove the THERE list from the NEAR list
# (a) There will be lots of -I/opt/scold/modules in the NEAR list and we do not want that.
#     This occurs when explicity specification of a development tree is declined (omitted).
#     It must be removed; if left in the NEAR list then the "old" implementations will be found in the searchpath up prior to the "new" ones in NEAR.
#     Example:
#
#     -I/build/scold/module-something/modules \ ................... was explicitly specified; e.g. with_module_something=/build/scold/module-something
#     -I/opt/scold/modules \ ...................................... was NOT specified ...
#     -I/build/scold/module-something-else/modules \ .............. was explicitly specified; e.g. with_module_something_else=/build/scold/module-something-else
#     -I/build/scold/module-dark-side/modules \.................... was explicitly specified; e.g. with_module_dark_side=/build/scold/module-dark-side
#     -I/opt/scold/modules ........................................ backstopped with $(std_scold_prefix)
#     
# (b) same pattern applies to the LOADPATH
#
__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR = \
  $(filter-out $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_THEREobj), \
               $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR_and_THERE))
__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR_and_THERE = \
  $(addprefix -I, \
              $(foreach area, $(DEVELOPMENT_AREAS) $(TESTING_AREAS), \
                        $(area)/modules $(area)/obj/modules \
                        $(area)/include $(area)/obj/include $(comment indeed... include files can be synthetic too)))
  $(end)
__toolflags_SEARCHPATH_EXTERNAL_MODULES_THEREobj = \
  $(addprefix -I, \
              $(foreach area, $(INSTALLATION_AREAS), \
                        $(area)/include $(area)/obj/include \
                        $(area)/modules $(area)/obj/modules)) \
  $(end)
__toolflags_SEARCHPATH_EXTERNAL_MODULES_THERE = \
  $(addprefix -I, \
              $(foreach area, $(INSTALLATION_AREAS), \
                        $(area)/include \
                        $(area)/modules)) \
  $(end)
__toolflags_SEARCHPATH_EXTERNAL_MODULES = \
  $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR) \
  $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_THERE) \
  $(end)
$(if $(DEBUGGING_CONDITION), \
$(info DEBUG __toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR=[$(__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR)]) \
$(info DEBUG __toolflags_SEARCHPATH_EXTERNAL_MODULES_THERE=[$(__toolflags_SEARCHPATH_EXTERNAL_MODULES_THERE)]) \
$(info DEBUG __toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR_and_THERE=[$(__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR_and_THERE)]) \
$(info DEBUG __toolflags_SEARCHPATH_EXTERNAL_MODULES=[$(__toolflags_SEARCHPATH_EXTERNAL_MODULES)]))

SEARCHPATH_EXTERNAL_MODULES_NEAR = $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_NEAR)
SEARCHPATH_EXTERNAL_MODULES_THERE = $(__toolflags_SEARCHPATH_EXTERNAL_MODULES_THERE)
SEARCHPATH_EXTERNAL_MODULES = \
  $(__toolflags_SEARCHPATH_EXTERNAL_MODULES) \
  $(if $(VERBOSITY_CONDITION), \
       $(warning deprecation: the variable SEARCHPATH_EXTERNAL_MODULES is deprecated, do not use it) \
       $(warning deprecation: instead use PACKAGE_LDFLAGS_SET)) \
  $(end)

#
# Delicate issues ...
#
# 1. for x86_64, if present, prefer the .../lib64 over .../lib
#    e.g.
#          -L/opt/gcc/lib64
#      NOT -L/opt/gcc/lib
#
#  2. remove missing directories
#     while the linker can handle that, libtool cannot.
#     libtool fails when attempts to acquire a fullpath
#
#    e.g. /bin/sh ./libtool  ...etc... -Lexternal/module-mysqlpp/lib ...etc...
#         ./libtool: line 6000: cd: external/module-mysqlpp/lib: No such file or directory
#         libtool: link: cannot determine absolute directory name of `external/module-mysqlpp/lib'
#
# 3. remove the THERE list from the NEAR list
#    see the reasoning up in the commentariat for SEARCHPATH

__toolflags_LOADPATH_EXTERNAL_MODULES_NEAR = \
  $(filter-out \
    $(__toolflags_LOADPATH_EXTERNAL_MODULES_THERE), \
    $(__toolflags_LOADPATH_EXTERNAL_MODULES_NEAR_and_THERE))
__toolflags_LOADPATH_EXTERNAL_MODULES_NEAR_and_THERE = \
  $(addprefix -L, \
              $(foreach area, $(patsubst ./%,%, $(DEVELOPMENT_AREAS) $(TESTING_AREAS)), \
                        $(wildcard \
                          $(if $(wildcard $(area)/lib64), \
                               $(area)/lib64, \
                               $(area)/lib))))
__toolflags_LOADPATH_EXTERNAL_MODULES_THERE = \
  $(addprefix -L, \
              $(foreach area, $(patsubst ./%,%, $(INSTALLATION_AREAS)), \
                        $(wildcard \
                          $(if $(wildcard $(area)/lib64), \
                               $(area)/lib64, \
                               $(area)/lib))))
__toolflags_LOADPATH_EXTERNAL_MODULES = \
  $(__toolflags_LOADPATH_EXTERNAL_MODULES_NEAR) \
  $(__toolflags_LOADPATH_EXTERNAL_MODULES_THERE) \
  $(end)

LOADPATH_EXTERNAL_MODULES = \
  $(__toolflags_LOADPATH_EXTERNAL_MODULES) \
  $(if $(VERBOSITY_CONDITION), \
       $(warning deprecation: the variable LOADPATH_EXTERNAL_MODULES is deprecated, do not use it) \
       $(warning deprecation: instead use PACKAGE_LDFLAGS_SET)) \
  $(end)

#
# Usage:
#
#   __toolflags_expand_deprecated_variables GOODVAR,BADVAR1,BADVAR2,BADVAR3 ...) <------------------ NO SPACES after the comma
#
# WATCHOUT - use NO SPACES after the comma (otherwise the macro silently does not work)
# [[FIXTHIS]] use $(strip ...) to get rid of those spaces ... which will make this macro beyond unreadable
__toolflags_expand_deprecated_variable1 = $(if $(filter-out undefined,$(origin $2)),$($2)$(warning the variable $2 is deprecated, instead use $1))
__toolflags_expand_deprecated_variables = \
  $(if $2,$(call __toolflags_expand_deprecated_variable1,$1,$2)) \
  $(if $3,$(call __toolflags_expand_deprecated_variable1,$1,$3)) \
  $(if $4,$(call __toolflags_expand_deprecated_variable1,$1,$4)) \
  $(if $5,$(call __toolflags_expand_deprecated_variable1,$1,$5)) \
  $(if $6,$(call __toolflags_expand_deprecated_variable1,$1,$6)) \
  $(if $7,$(call __toolflags_expand_deprecated_variable1,$1,$7)) \
  $(if $8,$(call __toolflags_expand_deprecated_variable1,$1,$7)) \
  $(if $9,$(error TOO MANY COMPATIBILITY ... rewrite something)) \
  $(end)

# REMOVE WHEN every Makefile (Makefile.am) has converted to current usage, the $(__COMPILER_${TOOL}FLAGS_SET) 
#                                    $( ........current usage........) $(.......deprecated.......)
__toolflags_COMPILER_CPPFLAGS_SET  = $(Makefile_COMPILER_CPPFLAGS_SET) $(__COMPILER_CPPFLAGS_SET)
__toolflags_COMPILER_CFLAGS_SET    = $(Makefile_COMPILER_CFLAGS_SET)   $(__COMPILER_CFLAGS_SET)
__toolflags_COMPILER_CXXFLAGS_SET  = $(Makefile_COMPILER_CXXFLAGS_SET) $(__COMPILER_CXXFLAGS_SET)
__toolflags_COMPILER_LDFLAGS_SET   = $(Makefile_COMPILER_LDFLAGS_SET)  $(__COMPILER_LDFLAGS_SET)

# REMOVE WHEN: hypogeal-twilight 0.46, 0.47 or greater such has work that supercedes this
# there remains hackery in the Makefile (Makefile.am) for this using the "__nonstd_PACKAGE" prefix 
#                                             $( ...........current usage...........) $(..........deprecated.........)
__toolflags_PACKAGE_NoNsTdHaCk_CPPFLAGS_SET = $(Makefile_nonstd_PACKAGE_CPPFLAGS_SET) $(__nonstd_PACKAGE_CPPFLAGS_SET)
__toolflags_PACKAGE_NoNsTdHaCk_CFLAGS_SET   = $(Makefile_nonstd_PACKAGE_CFLAGS_SET)   $(__nonstd_PACKAGE_CFLAGS_SET)
__toolflags_PACKAGE_NoNsTdHaCk_CXXFLAGS_SET = $(Makefile_nonstd_PACKAGE_CXXFLAGS_SET) $(__nonstd_PACKAGE_CXXFLAGS_SET)
__toolflags_PACKAGE_NoNsTdHaCk_LDFLAGS_SET  = $(Makefile_nonstd_PACKAGE_LDFLAGS_SET)  $(__nonstd_PACKAGE_LDFLAGS_SET)
#
#                                             $(........current usage........) $(.....deprecated..... WATCHOUT - use NO SPACES after the comma, otherwise the macro silently does not work)
__toolflags_PACKAGE_CORE_CPPFLAGS_SET       = $(Makefile_PACKAGE_CPPFLAGS_SET) $(call __toolflags_expand_deprecated_variables,Makefile_PACKAGE_CPPFLAGS_SET,Makefile_COMPONENT_CPPFLAGS_SET,__COMPONENT_CPPFLAGS_SET,__PACKAGE_CPPFLAGS_SET)
__toolflags_PACKAGE_CORE_CFLAGS_SET         = $(Makefile_PACKAGE_CFLAGS_SET)   $(call __toolflags_expand_deprecated_variables,Makefile_PACKAGE_CFLAGS_SET,Makefile_COMPONENT_CFLAGS_SET,__COMPONENT_CFLAGS_SET,__PACKAGE_CFLAGS_SET)
__toolflags_PACKAGE_CORE_CXXFLAGS_SET       = $(Makefile_PACKAGE_CXXFLAGS_SET) $(call __toolflags_expand_deprecated_variables,Makefile_PACKAGE_CXXFLAGS_SET,Makefile_COMPONENT_CXXFLAGS_SET,__COMPONENT_CXXFLAGS_SET,__PACKAGE_CXXFLAGS_SET)
__toolflags_PACKAGE_CORE_LDFLAGS_SET        = $(Makefile_PACKAGE_LDFLAGS_SET)  $(call __toolflags_expand_deprecated_variables,Makefile_PACKAGE_LDFLAGS_SET,Makefile_COMPONENT_LDFLAGS_SET,__COMPONENT_LDFLAGS_SET,__PACKAGE_LDFLAGS_SET)
#
__toolflags_PACKAGE_FINAL_CPPFLAGS_SET      = $(__toolflags_PACKAGE_CORE_CPPFLAGS_SET) $(__toolflags_PACKAGE_NoNsTdHaCk_CPPFLAGS_SET)
__toolflags_PACKAGE_FINAL_CFLAGS_SET        = $(__toolflags_PACKAGE_CORE_CFLAGS_SET)   $(__toolflags_PACKAGE_NoNsTdHaCk_CFLAGS_SET)
__toolflags_PACKAGE_FINAL_CXXFLAGS_SET      = $(__toolflags_PACKAGE_CORE_CXXFLAGS_SET) $(__toolflags_PACKAGE_NoNsTdHaCk_CXXFLAGS_SET)
__toolflags_PACKAGE_FINAL_LDFLAGS_SET       = $(__toolflags_PACKAGE_CORE_LDFLAGS_SET)  $(__toolflags_PACKAGE_NoNsTdHaCk_LDFLAGS_SET)

#                                           $( .........current usage...........) $(........deprecated.........)
__toolflags_CHECK_NoNsTdHaCk_CPPFLAGS_SET = $(Makefile_nonstd_CHECK_CPPFLAGS_SET) $(__nonstd_CHECK_CPPFLAGS_SET)
__toolflags_CHECK_NoNsTdHaCk_CFLAGS_SET   = $(Makefile_nonstd_CHECK_CFLAGS_SET)   $(__nonstd_CHECK_CFLAGS_SET)
__toolflags_CHECK_NoNsTdHaCk_CXXFLAGS_SET = $(Makefile_nonstd_CHECK_CXXFLAGS_SET) $(__nonstd_CHECK_CXXFLAGS_SET)
__toolflags_CHECK_NoNsTdHaCk_LDFLAGS_SET  = $(Makefile_nonstd_CHECK_LDFLAGS_SET)  $(__nonstd_CHECK_LDFLAGS_SET)
#                                           $( ......current usage.......) $(.....deprecated..... WATCHOUT - use NO SPACES after the comma, otherwise the macro silently does not work)
__toolflags_CHECK_CORE_CPPFLAGS_SET       = $(Makefile_CHECK_CPPFLAGS_SET) $(call __toolflags_expand_deprecated_variables,Makefile_CHECK_CPPFLAGS_SET,Makefile_TESTING_CPPFLAGS_SET,Makefile_TEST_CPPFLAGS_SET,__TESTING_CPPFLAGS_SET,__TEST_CPPFLAGS_SET)
__toolflags_CHECK_CORE_CFLAGS_SET         = $(Makefile_CHECK_CFLAGS_SET)   $(call __toolflags_expand_deprecated_variables,Makefile_CHECK_CFLAGS_SET,Makefile_TESTING_CFLAGS_SET,Makefile_TEST_CFLAGS_SET,__TESTING_CFLAGS_SET,__TEST_CFLAGS_SET)
__toolflags_CHECK_CORE_CXXFLAGS_SET       = $(Makefile_CHECK_CXXFLAGS_SET) $(call __toolflags_expand_deprecated_variables,Makefile_CHECK_CXXFLAGS_SET,Makefile_TESTING_CXXFLAGS_SET,Makefile_TEST_CXXFLAGS_SET,__TESTING_CXXFLAGS_SET,__TEST_CXXFLAGS_SET)
__toolflags_CHECK_CORE_LDFLAGS_SET        = $(Makefile_CHECK_LDFLAGS_SET)  $(call __toolflags_expand_deprecated_variables,Makefile_CHECK_LDFLAGS_SET,Makefile_TESTING_LDFLAGS_SET,Makefile_TEST_LDFLAGS_SET,__TESTING_LDFLAGS_SET,__TEST_LDFLAGS_SET)
#
__toolflags_CHECK_FINAL_CPPFLAGS_SET      = $(__toolflags_CHECK_CORE_CPPFLAGS_SET) $(__toolflags_CHECK_NoNsTdHaCk_CPPFLAGS_SET)
__toolflags_CHECK_FINAL_CFLAGS_SET        = $(__toolflags_CHECK_CORE_CFLAGS_SET)   $(__toolflags_CHECK_NoNsTdHaCk_CFLAGS_SET)
__toolflags_CHECK_FINAL_CXXFLAGS_SET      = $(__toolflags_CHECK_CORE_CXXFLAGS_SET) $(__toolflags_CHECK_NoNsTdHaCk_CXXFLAGS_SET)
__toolflags_CHECK_FINAL_LDFLAGS_SET       = $(__toolflags_CHECK_CORE_LDFLAGS_SET)  $(__toolflags_CHECK_NoNsTdHaCk_LDFLAGS_SET)

__toolflags_SEARCHPATH = $(__toolflags_SEARCHPATH_JUSTBUILT_MODULES) $(__toolflags_SEARCHPATH_EXTERNAL_MODULES)
__toolflags_LOADPATH   = $(__toolflags_LOADPATH_JUSTBUILT_MODULES)   $(__toolflags_LOADPATH_EXTERNAL_MODULES)

# A Theory Of Ordering (and also Of Prettiness)
#   "SEARCHPATH" ought to come after the cpp options, merely because it is so very big
#   "LOADPATH" ought to come before the -llibrary names for the libraries (is that still a rule?)
# the theory is not necessary or ... necessarily used ...

# reminder: ${TOOL}FLAGS remain reserved to the command line; e.g. CPPFLAGS, CFLAGS, CXXFLAGS, LDFLAGS
PACKAGE_CPPFLAGS_SET = $(__toolflags_SEARCHPATH) $(__toolflags_PACKAGE_FINAL_CPPFLAGS_SET) $(__toolflags_COMPILER_CPPFLAGS_SET)
PACKAGE_CFLAGS_SET   =                           $(__toolflags_PACKAGE_FINAL_CFLAGS_SET)   $(__toolflags_COMPILER_CFLAGS_SET)
PACKAGE_CXXFLAGS_SET =                           $(__toolflags_PACKAGE_FINAL_CXXFLAGS_SET) $(__toolflags_COMPILER_CXXFLAGS_SET)
PACKAGE_LDFLAGS_SET  = $(__toolflags_LOADPATH)   $(__toolflags_PACKAGE_FINAL_LDFLAGS_SET)  $(__toolflags_COMPILER_LDFLAGS_SET)

# Reminder: most of the 'CHECK_' series is incremental
#           it is appended to AM_{CPP,C,CXX}FLAGS
#
# Usage (in 'make check' code):
#
#     bin_unit_LDFLAGS = $(PACKAGE_LDFLAGS_SET) $(AND_CHECK_LDFLAGS_SET)
#     $(bin_unit_OBJECTS): AM_CPPFLAGS+=$(CHECK_CPPFLAGS_SET)
#     $(bin_unit_OBJECTS): AM_CXXFLAGS+=$(CHECK_CXXFLAGS_SET)
#
#   -no-install    from https://www.gnu.org/software/libtool/manual/html_node/Link-mode.html
#
#      Link an executable output-file that can’t be installed and therefore doesn’t need a wrapper script.
#      It is useful if the program is only used in the build tree, e.g., for testing or generating other files.
#
AND_CHECK_CPPFLAGS_SET = $(__toolflags_CHECK_FINAL_CPPFLAGS_SET)
AND_CHECK_CFLAGS_SET   = $(__toolflags_CHECK_FINAL_CFLAGS_SET)
AND_CHECK_CXXFLAGS_SET = $(__toolflags_CHECK_FINAL_CXXFLAGS_SET)
AND_CHECK_LDFLAGS_SET  = $(__toolflags_CHECK_FINAL_LDFLAGS_SET) -no-install

CHECK_CPPFLAGS_SET = $(PACKAGE_CPPFLAGS_SET) $(AND_CHECK_CPPFLAGS_SET)
CHECK_CFLAGS_SET   = $(PACKAGE_CFLAGS_SET)   $(AND_CHECK_CFLAGS_SET)
CHECK_CXXFLAGS_SET = $(PACKAGE_CXXFLAGS_SET) $(AND_CHECK_CXXFLAGS_SET)
CHECK_LDFLAGS_SET  = $(PACKAGE_LDFLAGS_SET)  $(AND_CHECK_LDFLAGS_SET)

#end
