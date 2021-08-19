# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
hypogeal_twilight_compile_mk_included = 1

# The make (automake) definitions needed to use the hypogeal-twilight build system.
# the SCOLD scaffolding
# compatibility with the anguish-answer .../mk/compile.mk
# compatibility with the baleful-ballad .../mk/compile.mk
# ... and successors and assigns.

include mk/configured.mk
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir should have been defined in mk/configured.mk by ./configure))

# visibility first
include $(hypogeal_twilight_datarootdir)/mk/debugging.mk
include $(hypogeal_twilight_datarootdir)/mk/verbosity.mk
# and then functionality
include $(hypogeal_twilight_datarootdir)/mk/basic.mk
include $(hypogeal_twilight_datarootdir)/mk/toolflags.mk

scold_srcdir = src
scold_objdir = obj
scold_cxxdir = obj/src
scold_cxx_modulesdir = $(scold_objdir)/modules
scold_cxx_includedir = $(scold_objdir)/include

# [[deprecating]] ----------------------------------------------------------------------------------------------------

# given
#     $< = obj/driver/our/package/Class.cpp
# the "componentdir" is obj/driver
scold_cxx_componentdir = $(addprefix $(scold_cxxdir)/,$(word 2,$(subst /,$(space),$(<D))))

# modules are absolute (and global)
#deprecating $(modules)
modules = modules$(warning the keyword variable $$(modules) is deprecating)

standard_scold_cxx_modulesdir = $(srcdir)/modules
standard_scold_cxx_includedir = $(srcdir)/include

# Until such time as scold has a "real" compiler,
# the Makefile scaffolding must be pulled in as a git submodule
#
# n.b. the "scold-" prefix on the names is deprecated.
# just use the regular repo names without adornment or renaming.
# e.g. anguish-answer and hypogeal-twilight
#
# Avoid $(scold_anguish_answer_prefix)
# Use   $(anguish_answer_prefix)
#
# Candidates:
#
#     /opt/scold/libexec/anguish-answer/xscold
#     /opt/scold/libexec/anguish-answer/module-compile
#
#     /build/scold/anguish-answer/xscold
#     /build/scold/anguish-answer/module-compile
#
# Expected:
#
#     ANGUISH_ANSWER is reserved to the user
#                    possible /opt/scold or / build/scold/anguish-answer
#                    from the make variables or the environment
#
#     std_scold_prefix is the installation area via SCOLD_WITH_STD(scold, scold, description)
#                      expect /opt/scold
#                      via --with-std-scold=ROOT
#
#     [deprecated] scold_prefix is the installation area
#     [deprecated]              expect /opt/scold
#     [deprecated]              <strike>via --with-scold=ROOT</strike>
#
#     anguish_answer_prefix is the development area
#                           expect /build/scold/anguish-answer
#                           via --with-anguish-answer=AREA
# Usage:
#     make
#     make ANGUISH_ANSWER=/opt/scold
#
ANGUISH_ANSWER_ROOT_COLLECTION = \
  $(comment make) $(ANGUISH_ANSWER) \
  $(comment current, in-development) $(anguish_answer_prefix) \
  $(comment deprecated) $(scold_prefix) \
  $(comment current, as-installed) $(std_scold_prefix) \
  $(comment NO NEED FOR THIS SELF-CHECK: error missing --with-scold=ROOT or --with-anguish-answer=ROOT) \
  $(end)
ANGUISH_ANSWER_libexecdir = \
  $(word 1, $(foreach root,$(ANGUISH_ANSWER_ROOT_COLLECTION), \
                      $(if $(root)/libexec, \
                           $(if $(wildcard $(root)/libexec/anguish-answer), \
                                $(comment installation area) $(root)/libexec/anguish-answer, \
                                $(comment development area)  $(root)))))
ANGUISH_ANSWER_libexecdir_slash = \
  $(if $(ANGUISH_ANSWER_libexecdir), \
       $(addprefix $(ANGUISH_ANSWER__libexecdir), /))
aaDC = $(ANGUISH_ANSWER_libexecdir)/xscold
aaMC = $(ANGUISH_ANSWER_libexecdir)/module-compile

#
# Usages of Baleful Ballad
#
#      $(scold_cxxdir)/tests/unit/dependencies.mk:
#          : two separate lines for the dependencies.mk
#          $(call bbHGTW_DISAGGREGATE_COMPILE, $(bin_unit_SOURCES)) <----- $1
#          $(call bbsCOLD_DEPENDENCIES_COMPILE, $(bin_unit_SOURCES)) <----- $1
#      include $(scold_cxxdir)/tests/unit/dependencies.mk
#      
#     $(scold_cxxdir)/squark/dependencies.mk:
#          $(bbDC) $(bbDC_OPTIONS) $(call SCOLD_SOURCEStoSOURCES, $(bin_application_SOURCES))
#	   mkdir -p $(@D) && echo '-include $(patsubst %.cpp,%.mk,$(bin_application_SOURCES))' > $@
#     include $(scold_cxxdir)/squark/dependencies.mk
#
# External modules are defined by those modules that exist in the external searchpath
# yes use EXTERNAL_MODULE_SEARCHPATH
# but not SEARCHPATH
#
# bbDC_FLAGS is reserved to the end user in the Makefile or from the command line
#
# Expected:
#
#     BALEFUL_BALLAD is reserved to the user
#                    possible /opt/scold/bootstrap, /opt/scold or /build/scold/baleful-ballad
#                    from the make variables or the environment
#
#     baleful_ballad_prefix is the development area
#                           expect /build/scold/baleful-ballad
#                           via --with-baleful-ballad=/build/scold/baleful-ballad
#
# Usage (in order of preference):
#
#     export PATH=/opt/scold/bootstrap/bin:$PATH ; make
#     make BALEFUL_BALLAD=/opt/scold/bootstrap
#     ./configure --with-baleful-ballad=/opt/scold/bootstrap && make
#     ./configure --with-std-scold=/opt/scold --prefix=/exp/something && make
#
__compile_BALEFUL_BALLAD_ROOT_COLLECTION = \
  $(comment [[deprecated]]) \
            $(comment a make variable, e.g. make BALEFUL_BALLAD=/opt/scold/bootstrap) \
	              BALEFUL_BALLAD=$(BALEFUL_BALLAD) \
            $(comment current, baleful-ballad development, but normally elided) \
	              baleful_ballad_prefix=$(filter-out @baleful_ballad_prefix@, $(baleful_ballad_prefix)) \
  $(end)

# because ...
__compile_BALEFUL_BALLAD_prefix_REASON.BALEFUL_BALLAD = BALEFUL_BALLAD=$(BALEFUL_BALLAD) which is settable from make
__compile_BALEFUL_BALLAD_prefix_REASON.baleful_ballad_prefix = baleful_ballad_prefix=$(baleful_ballad_prefix) which is configurable as --without-baleful-ballad= or --with-baleful-ballad=$(baleful_ballad_prefix)
__compile_BALEFUL_BALLAD_prefix_REASON.remonstrate = it is ambient in the PATH=$(PATH)

__compile_mark =
__compile_space = $(__compile_mark) $(__compile_mark)

__compile_BALEFUL_BALLAD_prefix.base = $(__compile_BALEFUL_BALLAD_ROOT_COLLECTION) $(NOT remonstrate=remonstrate)
__compile_BALEFUL_BALLAD_prefix.partial1 = $(word 1, \
                                                  $(foreach pair, \
                                                            $(__compile_BALEFUL_BALLAD_prefix.base), \
                                                            $(if $(word 2, $(subst =,$(__compile_space), $(pair))), \
                                                                 $(pair))))
__compile_BALEFUL_BALLAD_prefix.partial2 = $(subst =,$(__compile_space), $(__compile_BALEFUL_BALLAD_prefix.partial1))
__compile_BALEFUL_BALLAD_prefix.partial3 = $(word 2, $(__compile_BALEFUL_BALLAD_prefix.partial2))
__compile_BALEFUL_BALLAD_prefix = $(__compile_BALEFUL_BALLAD_prefix.partial3)

__compile_BALEFUL_BALLAD_prefix_REASON.base = $(__compile_BALEFUL_BALLAD_prefix.base) remonstrate=remonstrate
__compile_BALEFUL_BALLAD_prefix_REASON.index1 = $(word 1, \
                                                  $(foreach pair, \
                                                            $(__compile_BALEFUL_BALLAD_prefix_REASON.base), \
                                                            $(if $(word 2, $(subst =,$(__compile_space), $(pair))), \
                                                                 $(pair))))
__compile_BALEFUL_BALLAD_prefix_REASON.index2 = $(subst =,$(__compile_space), $(__compile_BALEFUL_BALLAD_prefix_REASON.index1))
__compile_BALEFUL_BALLAD_prefix_REASON.index3 = $(word 1, $(__compile_BALEFUL_BALLAD_prefix_REASON.index2))
__compile_BALEFUL_BALLAD_prefix_REASON = $(__compile_BALEFUL_BALLAD_prefix_REASON.$(__compile_BALEFUL_BALLAD_prefix_REASON.index3))
$(if $(DEBUGGING_CONDITION), \
$(info .../mk/compile.mk: debug, __compile_BALEFUL_BALLAD_prefix=$(__compile_BALEFUL_BALLAD_prefix)) \
$(info .../mk/compile.mk: debug, because $(__compile_BALEFUL_BALLAD_prefix_REASON)))

bbDC = $(strip \
  $(if $(__compile_BALEFUL_BALLAD_prefix), \
       $(addprefix $(addsuffix /bin/, $(__compile_BALEFUL_BALLAD_prefix)), remonstrate), \
       remonstrate))
$(if $(DEBUGGING_CONDITION), \
$(info .../mk/compile.mk: debug, bbDC=$(bbDC)))

#
# WATCHOUT - we MUST ....... have -E for the .../modules and .../includes areas so that the compatibility shims DO NOT ... trigger disaggregation
# WATCHOUT - we MUST NOT ... have -E for the .../obj/modules and .../obj/includes areas so that disagggregation DO ....... trigger disaggregation
#
# S.C.O.L.D.                         C++                           
# -E/opt/something/modules      #include <something.something.Dark_Side>
# -I/opt/something/modules      #include <something.something.Dark_Side> (only)
#
# -E/opt/something/obj/modules  these should not be occurring because obj/modules obj/includes is a development-only flourish
# -I/opt/something/obj/modules  #include <something.something.Dark_Side>
#                               #include <ipp/something.something.Dark_Side>
#                               #include <hpp/something.something.Dark_Side>
#                               #include <fpp/something.something.Dark_Side>
#
bbDC_SEARCHPATH = \
  $(foreach item, \
    $(filter-out $(SEARCHPATH_EXTERNAL_MODULES_THERE), \
		 $(if $(DEBUGGING_CONDITION),$(info SEARCHPATH_EXTERNAL_MODULES_NEAR=$(SEARCHPATH_EXTERNAL_MODULES_NEAR))) \
		 $(if $(SEARCHPATH_EXTERNAL_MODULES_NEAR), \
		      $(comment OK) $(SEARCHPATH_EXTERNAL_MODULES_NEAR), \
		      $(warning EMPTY SEARCHPATH_EXTERNAL_MODULES_NEAR from EXTERNAL.mk))), \
    $(if $(filter %/obj/include %/obj/modules,$(item)), $(item), \
         $(patsubst -I%,-E%,$(item)))) \
  $(patsubst -I%, -E%, \
             $(if $(DEBUGGING_CONDITION),$(info SEARCHPATH_EXTERNAL_MODULES_THERE=$(SEARCHPATH_EXTERNAL_MODULES_THERE))) \
             $(if $(SEARCHPATH_EXTERNAL_MODULES_THERE), \
                  $(comment OK) $(SEARCHPATH_EXTERNAL_MODULES_THERE), \
                  $(warning EMPTY SEARCHPATH_EXTERNAL_MODULES_THERE from EXTERNAL.mk))) \
  $(end)

# bbDC_FLAGS is reserved to the command line
bbDC_OPTIONS = \
  $(bbDC_FLAGS) $(Makefile_bbDC_FLAGS) \
  $(comment --verbose) \
  --make-directories \
  $(addprefix --submodule=, $(SUBDIRS)) \
  $(bbDC_SEARCHPATH) \
  --modulesdir-directory=$(scold_cxx_modulesdir) \
  --modulesdir-variable='$$(scold_cxx_modulesdir)' \
  --objdir-directory=$(scold_cxxdir) \
  --objdir-variable='$$(scold_cxxdir)' \
  $(comment WATCHOUT - the source may be in $(scold_cxxdir) so this is wrong for .../CONFIG.xcpp) \
  --srcdir-directory=$(scold_srcdir) \
  --srcdir-variable='$$(scold_srcdir)' \
  $(end)
$(if $(DEBUGGING_CONDITION), \
$(info .../mk/compile.mk: debug, bbDC_OPTIONS=$(bbDC_OPTIONS)))

#
# Recall: two separate lines for the separated usage of disaggregate and dependencies compilation
# to be placed underneath dependencies.mk with $@ already 'set'
# WATCHOUT - if bbDC fails then do not proceed on to create $@
#
# to be used anywhere
#
# .../dependencies.mk:
#     $(AM_V_BB1ST) $(call bbHGTW_DISAGGREGATE_COMPILE, ...*.xcpp sources...)
#     $(AM_V_BB2ND) $(call bbHGTW_DEPENDENCIES_COMPILE, ...*.xcpp sources...)
#
define __compile_bbHGTW_WARN_ABOUT_EMPTY_FILES_IN_THE_CPP_SOURCES_LIST =
  { : this is a common error and should be part of bbDC but is not yet checked there; \
    if [[ 0 == $(words $1) ]] ; \
    then echo "$@: error, there are no source files at all (no .cpp files)"; \
         echo "$@: notice,  frequently this is an error in macro spelling"; \
         exit 1 ; \
    fi; } 1>&2
endef
define __compile_bbHGTW_WARN_ABOUT_XCPP_FILES_IN_THE_CPP_SOURCES_LIST =
  { : this is a common error but it cannot be part of bbDC because SOURCEStoSOURCES elides it ; \
    if [[ 0 != $(if $(filter %.xcpp, $1), 1, 0) ]] ; \
    then guess_Makefrag="$(subst $(scold_cxxdir)/,$(scold_srcdir)/,$(@D))/Makefrag.am"; \
echo "$@: DEBUG because $(filter %.xcpp, $1)"; \
         echo "$@: warning, surprisingly, the C++ SOURCES listing in $${guess_Makefrag?} contains S.C.O.L.D. source files"; \
    fi; \
    for invalid_xcpp in $(filter %.xcpp, $1); \
    do probably_cpp="$$(dirname $$invalid_xcpp)/$$(basename $$invalid_xcpp .xcpp).cpp"; \
       echo "$@: warning, found ...... $${invalid_xcpp?} (.xcpp)"; \
       echo "$@: notice,  expected ... $${probably_cpp?} (.cpp)"; \
    done; \
    true; } 1>&2
endef
define __compile_bbHGTW_DISAGGREGATE_COMPILE =
  $(bbDC) $(bbDC_OPTIONS) $(call HT_SOURCEStoSOURCES, $1)
endef
define __compile_bbHGTW_DEPENDENCIES_COMPILE =
  { mkdir -p $(@D) && \
    for mk in $(call HT_SOURCEStoMAKEFILES, $1) ; do echo "-include $$mk" ; done > $@ ; }
endef

define bbHGTW_COMPILE =
  { $(call __compile_bbHGTW_WARN_ABOUT_EMPTY_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_WARN_ABOUT_XCPP_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_DISAGGREGATE_COMPILE, $1) && \
    $(call __compile_bbHGTW_DEPENDENCIES_COMPILE, $1) ; }
endef
define bbHGTW_DISAGGREGATE_COMPILE =
  { $(call __compile_bbHGTW_WARN_ABOUT_XCPP_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_DISAGGREGATE_COMPILE, $1) ; }
endef
define bbHGTW_DEPENDENCIES_COMPILE =
  $(call __compile_bbHGTW_DEPENDENCIES_COMPILE, $1)
endef
define bbSCOLD_COMPILE =
  $(if $(VERBOSITY_CONDITION), \
       $(warning bbSCOLD_COMPILE is deprecating, instead use bbHGTW_COMPILE) \
       : deprecation warning ; ) \
  $(call bbHGTW_COMPILE, $1)
endef
define bbSCOLD_DISAGGREGATE_COMPILE =
  $(if $(VERBOSITY_CONDITION), \
       $(warning bbSCOLD_DISAGGREGATE_COMPILE is deprecating, instead use bbHGTW_DISAGGREGATE_COMPILE) \
       : deprecation warning ; ) \
  $(call bbHGTW_DISAGGREGATE_COMPILE, $1)
endef
define bbSCOLD_DEPENDENCIES_COMPILE =
  $(if $(VERBOSITY_CONDITION), \
       $(warning bbSCOLD_DEPENDENCIES_COMPILE is deprecating, instead use bbHGTW_DEPENDENCIES_COMPILE) \
       : deprecation warning ; ) \
  $(call bbHGTW_DEPENDENCIES_COMPILE, $1)
endef

# [[REMOVETHIS]] hack it until hypogeal-twilight 0.45-0.0-devel is official and ubiquitous
HT_XCPP2CPP = $(call bbSCOLD_DISAGGREGATE_COMPILE, $1)
HT_DEPENDENCIES = $(call bbSCOLD_COMPILE, $1)

# The chatter is the first eleven (!!) characters.
#
# 123456789ab
# <--------->
#   CXX      obj/src/posix/shell/namespace.lo
#
# chatter for baleful-ballad 1st pass
AM_V_BB1ST = $(am__v_BB1ST_$(V))
am__v_BB1ST_ = $(am__v_BB1ST_$(AM_DEFAULT_VERBOSITY))
# .....................123456789ab
am__v_BB1ST_0 = @echo "  EXPLODES $@";
am__v_BB1ST_0 = @echo "  DESCOLD  $@";
am__v_BB1ST_1 = 

# chatter for baleful-ballad 2nd pass
AM_V_BB2ND = $(am__v_BB2ND_$(V))
am__v_BB2ND_ = $(am__v_BB2ND_$(AM_DEFAULT_VERBOSITY))
# .....................123456789ab
am__v_BB2ND_0 = @echo "  INCLUDES $@";
am__v_BB2ND_0 = @echo "  MAKEFRAG $@";
am__v_BB2ND_1 = 

#
# Example:
#
#   $(eval $(call HT_DEPENDENCIES_STANZA, app, $(lib_libapp_la_SOURCES)))
#
define HT_DEPENDENCIES_STANZA =
$(scold_cxxdir)/$(strip $1)/dependencies.mk: $2
$2 : obj/src/%.cpp : src/%.xcpp
	$(call HT_V_COLD2, $$@) $(call HT_XCPP2CPP, $$^)
	@test -e $$@
$(scold_cxxdir)/$(strip $1)/dependencies.mk:
	$(call HT_V_BOTH2, $$@) $(call HT_DEPENDENCIES2, $$^, $$@)
	@test -e $$@
include $(scold_cxxdir)/$(strip $1)/dependencies.mk
clean-dependencies::
	rm -f $(scold_cxxdir)/$(strip $1)/dependencies.mk
endef

# Perform ONLY and DEPENDENCIES elaboration
define HT_DEPENDENCIES =
  { $(call __compile_bbHGTW_WARN_ABOUT_EMPTY_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_WARN_ABOUT_XCPP_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_DEPENDENCIES_COMPILE, $1) ; }
endef
# WATCHOUT - AVOID - different than HT_DEPENDENCIES .. uses $2 for non-standard dependencies.mk output file naming
define HT_DEPENDENCIES2 =
  { $(call __compile_bbHGTW_WARN_ABOUT_EMPTY_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_WARN_ABOUT_XCPP_FILES_IN_THE_CPP_SOURCES_LIST, $1) && \
    $(call __compile_bbHGTW_DISAGGREGATE_COMPILE, $1) && \
    { : was call __compile_bbHGTW_DEPENDENCIES_COMPILE _1 but uses _2 instead; \
      mkdir -p $$(dir $2) && \
      for mk in $$(call HT_SOURCEStoMAKEFILES, $1) ; do echo "-include $$$$mk" ; done > $2 ; } ; }
endef
HT_V_BOTH = $(ht__v_BOTH_$(V))
ht__v_BOTH_ = $(ht__v_BOTH_$(AM_DEFAULT_VERBOSITY))
# ....................123456789ab
ht__v_BOTH_0 = @echo "  DEPENDS  $@";
ht__v_BOTH_1 = 
HT_V_BOTH2 = $(call ht__v_BOTH2_$(V), $1)
ht__v_BOTH2_ = $(call ht__v_BOTH2_$(AM_DEFAULT_VERBOSITY), $1)
# .....................123456789ab
ht__v_BOTH2_0 = @echo "  DEPENDS  $1";
ht__v_BOTH2_1 = 

HT_V_DONE = $(ht__v_DONE_$(V))
ht__v_DONE_ = $(ht__v_DONE_$(AM_DEFAULT_VERBOSITY))
# ....................123456789ab
ht__v_DONE_0 = @ : echo "  DONE     $@"; : In this step particularly. Shut. Up.
ht__v_DONE_1 = 

#
# Usage:
# 
#    $(scold_cxxdir)/tests/unit/dependencies.mk: $(check_bin_unit_SOURCES)
#    $(check_bin_unit_SOURCES) : obj/src/%.cpp : src/%.xcpp
#    	$(HT_V_COLD) $(call HT_XCPP2CPP, $<) <------------------------------------ WATCHOUT - older incarations used $@ not $<
#    	@test -e $@
#    $(scold_cxxdir)/tests/unit/dependencies.mk:
#    	$(HT_V_BOTH) $(call HT_DEPENDENCIES, $^) <-------------------------------- any declared antecedents of .../dependencies.mk
#    	@test -e $@
#
define HT_XCPP2CPP =
  $(bbDC) $(bbDC_OPTIONS) $1
endef
HT_XPP2CPP = $(error instead use HT_XCPP2CPP)
# DESCOLD (Scalable C++ Object Location Disaggregation)
HT_V_COLD = $(ht__v_COLD_$(V))
ht__v_COLD_ = $(ht__v_COLD_$(AM_DEFAULT_VERBOSITY))
# ....................123456789ab
ht__v_COLD_0 = @echo "  XCPP2CPP $@";
ht__v_COLD_1 = 
HT_V_COLD2 = $(call ht__v_COLD2_$(V), $1)
ht__v_COLD2_ = $(call ht__v_COLD2_$(AM_DEFAULT_VERBOSITY), $1)
# ....................123456789ab
ht__v_COLD2_0 = @echo "  XCPP2CPP $1";
ht__v_COLD2_1 = 

#
# $(HT_V_TEST) test -e $2
HT_V_TEST = $(ht__v_TEST_$(V))
ht__v_TEST_ = $(ht__v_TEST_$(AM_DEFAULT_VERBOSITY))
# ....................123456789ab
ht__v_TEST_0 = @echo "  TESTING  $@";
ht__v_TEST_1 = 

# chatter for baleful-ballad incremental (used in the $(bbDC)-generated *.mk fragment files)
AM_V_BBINC = $(am__v_BBINC_$(V))$(if $(VERBOSITY_CONDITION),$(warning AM_V_BBINC is deprecating, begin to stop using it))
am__v_BBINC_ = $(am__v_BBINC_$(AM_DEFAULT_VERBOSITY))
# .....................123456789ab
am__v_BBINC_0 = @echo "  MODULE   $(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))";
am__v_BBINC_1 = 

# %.cpp -> package.subpackage.Class  (the word)
SCOLD_SOURCEStoMODULENAMES = $(call HT_SOURCEStoMODULENAMES,$1)$(warning [[deprecated]] SCOLD_SOURCEStoMODULENAMES instead prefer HT_SOURCEStoMODULENAMES)
HGTW_SOURCEStoMODULENAMES = $(call HT_SOURCEStoMODULENAMES,$1)$(warning [[deprecated]] HGTW_SOURCEStoMODULENAMES instead prefer HT_SOURCEStoMODULENAMES)
HT_SOURCEStoMODULENAMES = \
  $(subst /,., \
	  $(patsubst %/namespace,%, \
	  $(patsubst $(scold_cxxdir)/%,%, \
	  $(patsubst $(scold_srcdir)/%,%, \
	  $(patsubst %.xcpp,%, \
	  $(patsubst $(scold_cxxdir)/%.scold,%, $(comment deprecated) \
	  $(patsubst $(scold_cxxdir)/%.fpp,%, $(comment deprecated) \
	  $(patsubst $(scold_cxxdir)/%.hpp,%, $(comment deprecated) \
	  $(patsubst $(scold_cxxdir)/%.ipp,%, $(comment deprecated) \
	  $(patsubst $(scold_cxxdir)/%.tpp,%, $(comment deprecated) \
	  $(patsubst $(scold_cxxdir)/%.cpp,%, $(comment deprecated) \
          $1))))))))))) \
  $(end)
# %.cpp -> <package.subpackage.Class>  (the path to the lead include file)
# e.g. obj/src/package/subpackage/Class.cpp -> obj/modules/package.subpackage.Class
SCOLD_SOURCEStoMODULES = $(call HT_SOURCEStoMODULES,$1)$(warning [[deprecated]] SCOLD_SOURCEStoMODULES instead prefer HT_SOURCEStoMODULES)
HGTW_SOURCEStoMODULES = $(call HT_SOURCEStoMODULES,$1)$(warning [[deprecated]] HGTW_SOURCEStoMODULES instead prefer HT_SOURCEStoMODULES)
HT_SOURCEStoMODULES = \
  $(addprefix $(scold_cxx_modulesdir)/, \
              $(call HT_SOURCEStoMODULENAMES, $1)) \
  $(end)
# %.scold -> <package.subpackage.Class>  (the path to the lead include file)
SCOLD_IMPORTStoMODULES = $(warning [[deprecating]] SCOLD_IMPORTStoMODULES remove its use) \
  $(call SCOLD_SOURCEStoMODULES, \
         $(patsubst %.scold, %.cpp, $1)) \
  $(end)
# %.cpp -> %.scold
SCOLD_SOURCEStoIMPORTS = $(warning [[deprecating]] SCOLD_SOURCEStoIMPORTS remove its use) \
  $(patsubst %.cpp, %.scold, $1) \
  $(end)
# %.cpp -> %.cpp (an identity)
SCOLD_SOURCEStoENTAILS = $(warning [[deprecating]] SCOLD_SOURCEStoENTAILS remove its use) $1
# %.cpp -> %.xcpp
SCOLD_SOURCEStoSOURCES = $(call HT_SOURCEStoSOURCES, $1)$(warning [[deprecated]] SCOLD_SOURCEStoSOURCES instead prefer HT_SOURCEStoSOURCES)
HGTW_SOURCEStoSOURCES = $(call HT_SOURCEStoSOURCES, $1)$(warning [[deprecated]] HGTW_SOURCEStoSOURCES instead prefer HT_SOURCEStoSOURCES)
HT_SOURCEStoSOURCES = \
  $(patsubst $(scold_cxxdir)/%.cpp, $(scold_srcdir)/%.xcpp, $1) \
  $(end)
# %.cpp -> %.mk
SCOLD_SOURCEStoMAKEFILES = $(call HT_SOURCEStoMAKEFILES, $1)$(warning [[deprecated]] SCOLD_SOURCEStoMAKEFILES instead prefer HT_SOURCEStoMAKEFILES)
HGTW_SOURCEStoMAKEFILES = $(call HT_SOURCEStoMAKEFILES, $1)$(warning [[deprecated]] HGTW_SOURCEStoMAKEFILES instead prefer HT_SOURCEStoMAKEFILES)
HT_SOURCEStoMAKEFILES = \
  $(patsubst %.xcpp, %.mk, \
             $(patsubst %.cpp, %.mk, $1)) \
  $(end)

SCOLD_AUTOMAKE_SOURCEStoMODULES = $(warning [[deprecating]] SCOLD_AUTOMAKE_SOURCEStoMODULES remove its use) \
  $(addprefix $(scold_cxx_modulesdir)/, \
              $(call SCOLD_AUTOMAKE_MODULEStoMODULENAMES, $1)) \
  $(warning SCOLD_AUTOMAKE_SOURCEStoMODULES is deprecated; instead use SCOLD_SOURCEStoMODULES) \
  $(end)
SCOLD_AUTOMAKE_MODULEStoMODULENAMES = $(warning [[deprecating]] SCOLD_AUTOMAKE_MODULEStoMODULENAMES remove its use) \
  $(subst /,., \
          $(patsubst %/namespace,%, \
                     $(patsubst $(scold_cxx_modulesdir)/@scold/%.scold,%, $1))) \
  $(warning SCOLD_AUTOMAKE_MODULEStoMODULENAMES is deprecated; instead use SCOLD_MODULEStoMODULENAMES) \
  $(end)

# DO NOT apply $(AM_V_GEN) herein
# Apply $(AM_V_GEN) at the call sites
# recall that AM_V_GEN and its ilk contain their own semicolons; so no trailing semicolons
#
#   something:
#    \t$(AM_V_GEN) $(UPC_COMPILE)
#
#   something:
#   \t$(AM_V_GEN) $(SCOLD_DISAGGREGATE_COMPILE)
#
#   something:
#   \t$(AM_V_GEN) $(SCOLD_MODULE_COMPILE)
#
AM_V_UPC = $(am__v_UPC_$(V))
am__v_UPC_ = $(am__v_UPC_$(AM_DEFAULT_VERBOSITY))
# ......... = @echo "  GEN     " $@;
am__v_UPC_0 = @echo "  CXX-PC  <$(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))>";
am__v_UPC_1 = 

# disaggregate compiler
AM_V_DC = $(am__v_DC_$(V))
am__v_DC_ = $(am__v_DC_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "  GEN     " $@;
am__v_DC_0 = @echo "  CXX-DC  <$(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))>";
am__v_DC_1 = 

# entails compiler (like disaggregate-compiler)
AM_V_EC = $(AM_V_DC)
am__v_EC_ = $(am__v_EC_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "  GEN     " $@;
am__v_EC_0 = @echo "  CXX-EC  <$(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))>";
am__v_EC_1 = 

# module-compiler
AM_V_MC = $(am__v_MC_$(V))
am__v_MC_ = $(am__v_MC_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "  GEN     " $@;
am__v_MC_0 = @echo "  CXX-MC  <$(strip $(call SCOLD_AUTOMAKE_MODULEStoMODULENAMES,$@))>";
am__v_MC_1 = 

# imports-compiler (like module-compiler but takes a *.scold semaphore fiel)
AM_V_IC = $(am__v_IC_$(V))
am__v_IC_ = $(am__v_IC_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "  GEN     " $@;
am__v_IC_0 = @echo "  CXX-IC  <$(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))>";
am__v_IC_1 = 

UPC_COMPILE = \
  tmp=$(@D)/"t99.$$$$.$(@F).$$$$.t99~"; \
  mkdir -p $${tmp%/*}; \
  { { echo '\#pragma once' ; $(CPP) -x c++ -P -E $(SEARCHPATH) -imacros $$(sed -n -e '1 s/.*-\*-//p' $<) $< ; } > $$tmp && \
    chmod a-w $$tmp && \
    mv -f $$tmp $@ ; }
#
# usage:
#   $(LIST_OF_FILES) : $(scold_cxxdir)/%.cpp : $(scold_srcdir)/%.xcpp
#
SCOLD_DISAGGREGATE_COMPILE = \
  $(aaDC) --srcdir=$(scold_srcdir) --objdir=$(scold_cxxdir) --modulesdir=$(scold_cxx_modulesdir) $(SEARCHPATH_EXTERNAL_MODULES) $<
SCOLD_ENTAILS_COMPILE = $(SCOLD_DISAGGREGATE_COMPILE)

#
# usage:
#   lib_libEXAMPLE_la_MODULES = $(call SCOLD_SOURCEStoMODULES,$(lib_libEXAMPLE_la_SOURCES))
#   $(lib_libEXAMPLE_la_MODULES):
#       $(SCOLD_MODULE_COMPILE)
#
SCOLD_MODULE_COMPILE = \
  $(aaMC) $@ $(scold_cxx_modulesdir) $(scold_srcdir)
SCOLD_IMPORTS_COMPILE = \
  $(aaMC) $(call SCOLD_IMPORTStoMODULES,$@) $(scold_cxx_modulesdir) $(scold_srcdir) ; \
  mkdir -p $(@D) && touch $@

# as with a automake-1.13, with gcc3-type dependency generation
SCOLD_AUTOMAKE_LTCXX_COMPILE = \
  depbase=`echo $@ | sed 's|[^/]*$$|$(DEPDIR)/&|;s|\.lo$$||'`; : copied from automake Makefile CXXFLAGS='$(CXXFLAGS)'; \
  $(LTCXXCOMPILE) -MT $@ -MD -MP -MF $$depbase.Tpo -c -o $@ $< && $(am__mv) $$depbase.Tpo $$depbase.Plo
SCOLD_AUTOMAKE_MODULE_COMPILE = \
  $(aaMC) $(call SCOLD_AUTOMAKE_SOURCEStoMODULES,$@) $(scold_cxx_modulesdir) ./src

#
# given:
#
#     SEARCHPATH_EXTERNAL_MODULES = ... set from EXTERNAL-PATHS.mk
#
#     lib_libLIBRARY_la_MODULES_by_SCOLD_or_whatever shaped as a list of SCOLD module files
#         e.g. obj/modules/library.package.Class
#
#     lib_libLIBRARY_la_SOURCES as a list shaped as %.cpp (C++) files listed in automake SOURCES variable
#         e.g. obj/src/library/package/Class.cpp
#
# usage:
#     lib_libLIBRARY_la_SCOLD_MODULES = $(lib_libLIBRARY_la_MODULES_by_SCOLD_or_whatever)
#     lib_libLIBRARY_la_SCOLD_SOURCES = $(patsubst $(scold_cxxdir)/%.cpp, $(scold_srcdir)/%.xcpp, $(lib_libLIBRARY_la_SOURCES))
#     $(scold_cxxdir)/c/dependencies.mk:
#     \t(call call_SCOLD_COMPILE_INITIAL_DEPENDENCIES, $(lib_libLIBRARY_la_SCOLD_MODULES) $(lib_libLIBRARY_la_SCOLD_SOURCES))
#
# deprecating (in favor of another more concurrency-friendly pattern)
SCOLD_COMPILE_INITIAL_DEPENDENCIES = $(call call_SCOLD_COMPILE_INITIAL_DEPENDENCIES, $^)

# deprecating (in favor of another more concurrency-friendly pattern)
call_SCOLD_COMPILE_INITIAL_DEPENDENCIES = \
  if test 0 = $(words $1); \
  then echo 'No MODULES or SOURCES'; exit 2; \
  fi; \
  for module in $(filter-out %.xcpp, $1); \
  do echo $$module ; $(aaMC) $$module $(scold_cxx_modulesdir) $(scold_srcdir); \
  done; \
  for xcpp in $(filter %.xcpp, $1); \
  do echo $$xcpp ; $(aaDC) --no-warning --srcdir=$(scold_srcdir) --objdir=$(scold_cxxdir) --modulesdir=$(scold_cxx_modulesdir) $(SEARCHPATH_EXTERNAL_MODULES) $$xcpp; \
  done; \
  echo 'Touching $@' ; touch $@

# end
