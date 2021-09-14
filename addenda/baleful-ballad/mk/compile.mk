# included via automake, not really a GNU -*- Makefile -*- fragment; For terms, see the LICENSE file at the top of the repository.
baleful_ballad_compile_mk_included = 1

# The make (automake) definitions needed to use the hypogeal-twilight build system.
# the SCOLD scaffolding
# compatibility with the anguish-answer .../mk/compile.mk
# compatibility with the baleful-ballad .../mk/compile.mk
# ... and successors and assigns.

#
# Usages of Baleful Ballad
#
#      $(scold_cxxdir)/tests/unit/dependencies.mk:
#          : two separate lines for the dependencies.mk
#          $(call bbSCOLD_DISAGGREGATE_COMPILE, $(bin_unit_SOURCES)) <----- $1
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
# bbDC_FLAGS is reserved to the send user in the Makefile or from the command line
#
# Candidates:
#
#     /opt/scold/bin/remonstrate
#     /build/scold/baleful-ballad/bin/remonstrate
#
# Expected:
#
#     BALEFUL_BALLAD is reserved to the user
#                    possible /opt/scold or /build/scold/baleful-ballad
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
#     baleful_ballad_prefix is the development area
#                           expect /build/scold/baleful-ballad
#                           via --with-baleful-ballad=AREA
# Usage:
#     make
#     make BALEFUL_BALLAD=/opt/scold
#
__compile_BALEFUL_BALLAD_ROOT_COLLECTION = \
  $(comment make) \
	$(BALEFUL_BALLAD) \
  $(comment current, baleful-ballad development, but normally elided) \
	$(filter-out @baleful_ballad_prefix@, $(baleful_ballad_prefix)) \
  $(comment deprecated) \
	$(scold_prefix) \
  $(comment current, expected usage, scold, as-standard, as-installed) \
	$(std_scold_prefix) \
  $(comment NO NEED FOR THIS SELF-CHECK: error missing --with-scold=ROOT or --with-baleful-ballad=ROOT) \
  $(end)
__compile_BALEFUL_BALLAD_bindir = \
  $(word 1, $(foreach root,$(__compile_BALEFUL_BALLAD_ROOT_COLLECTION), \
                      $(if $(root), \
                           $(root)/bin)))
__compile_BALEFUL_BALLAD_bindir_slash = \
  $(if $(__compile_BALEFUL_BALLAD_bindir), \
       $(addprefix $(__compile_BALEFUL_BALLAD_bindir), /))
bbDC = $(addprefix $(__compile_BALEFUL_BALLAD_bindir_slash), remonstrate)
bbDC_OPTIONS = \
  $(bbDC_FLAGS) \
  $(comment --verbose) \
  --make-directories \
  $(addprefix --submodule=, $(SUBDIRS)) \
  $(if $(SEARCHPATH_EXTERNAL_MODULES), \
       $(comment OK) $(SEARCHPATH_EXTERNAL_MODULES), \
       $(error EMPTY SEARCHPATH_EXTERNAL_MODULES from EXTERNAL.mk)) \
  --modulesdir-directory=$(scold_cxx_modulesdir) \
  --modulesdir-variable='$$(scold_cxx_modulesdir)' \
  --objdir-directory=$(scold_cxxdir) \
  --objdir-variable='$$(scold_cxxdir)' \
  $(comment WATCHOUT - the source may be in $(scold_cxxdir) so this is wrong for .../CONFIG.xcpp) \
  --srcdir-directory=$(scold_srcdir) \
  --srcdir-variable='$$(scold_srcdir)' \
  $(end)

# %.xcpp -> package.subpackage.Class  (the word)
# e.g.
#    src/package/subpackage/Class.xcpp
#    package.subpackage.Class
SCOLD_SOURCEStoMODULENAMES = \
  $(subst /,., \
          $(patsubst %/namespace,%, \
                     $(patsubst $(scold_cxxdir)/%.cpp,%, \
                                $(patsubst $(scold_srcdir)/%.xcpp,%, $1)))) \
  $(end)

# %.xcpp -> .../modules/package.subpackage.Class  (the path to the include file)
# e.g.
#    obj/src/package/subpackage/Class.cpp
#    obj/modules/package.subpackage.Class
SCOLD_SOURCEStoMODULES = \
  $(addprefix $(scold_cxx_modulesdir)/, \
              $(call SCOLD_SOURCEStoMODULENAMES, $1)) \
  $(end)

# %.cpp -> %.xcpp
# e.g.
#    obj/src/package/subpackage/Class.cpp
#    src/package/subpackage/Class.xcpp
SCOLD_SOURCEStoSOURCES = \
  $(patsubst $(scold_cxxdir)/%.cpp, $(scold_srcdir)/%.xcpp, $1) \
  $(end)

# %.cpp -> %.mk
# e.g.
#    obj/src/package/subpackage/Class.cpp
#    obj/src/package/subpackage/Class.mk
SCOLD_SOURCEStoMAKEFILES = \
  $(patsubst %.cpp, %.mk, $1) \
  $(end)

#
# Recall: two separate lines for the separated usage of disaggregate and dependencies compilation
# to be placed underneath dependencies.mk with $@ already 'set'
# WATCHOUT - if bbDC fails then do not proceed on to create $@
#
# to be used anywhere
#
# .../dependencies.mk:
#     $(AM_V_BB1ST) $(call bbSCOLD_DISAGGREGATE_COMPILE, ...*.xcpp sources...)
#     $(AM_V_BB2ND) $(call bbSCOLD_DEPENDENCIES_COMPILE, ...*.xcpp sources...)
#
define bbSCOLD_DISAGGREGATE_COMPILE =
  $(bbDC) $(bbDC_OPTIONS) $(call SCOLD_SOURCEStoSOURCES, $1)
endef
define bbSCOLD_DEPENDENCIES_COMPILE =
  mkdir -p $(@D) && \
  for mk in $(call SCOLD_SOURCEStoMAKEFILES, $1) ; do echo "-include $$mk" ; done > $@
endef
