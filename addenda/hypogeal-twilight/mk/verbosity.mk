# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
# must cooperate with vernacular-doggerel .../mk/verbosity.mk
hypogeal_twilight_verbosity_mk_included = 1

#
# Usage:  (in a Makefile or Makefile.am)
#
#     include @hypogeal_twilight_datarootdir@/mk/verbosity.mk
#     ...but other higher-level includes, e.g. mk/compile.mk may have already included it for you.
#
# Usage of the verbosity
#
#   either:  $(if $(filter 1, $(VERBOSITY_BOOLEAN)),   $(info verbose: ... see something ... say something ...))
#       or:  $(if $(VERBOSITY_CONDITION),              $(info verbose: ... see something ... say something ...))
#
# The verbosity system follows the convention of automake.
#
# The V variable is reserved to the command line (i.e. unassigned but referenced herein)
#
#   V - a choice of verbosity among V=1, V=0, unassigned
#   VV - (somewhat secret) for rpmbuild, the -vv option 
#
# These variables are reserved to the top-level Makefile or Makefile.am (i.e. unassigned but referenced herein)
#
#   Makefile_DEFAULT_VERBOSITY        is for hand-coded (GNU) Makefiles, see $V
#   AM_DEFAULT_VERBOSITY              in automake-generated Makefiles, see $V
#

# is 1 or empty, useful for $(if ...)
VERBOSITY_CONDITION = $(__verbosity_ref_VERBOSITY_CONDITION)
# is 0 or 1, useful for substitution
VERBOSITY_BOOLEAN = $(__verbosity_ref_VERBOSITY_BOOLEAN)
# is disallowed (go ahead, try and use it)
VERBOSITY = $(__verbosity_ref_VERBOSITY)
# resolves the multiple signals of the default verbosity
DEFAULT_VERBOSITY_BOOLEAN = $(__verbosity_ref_DEFAULT_VERBOSITY_BOOLEAN)

DEFAULT_VERBOSITY = $(error NOT DEFAULT_VERBOSITY, instead use AM_DEFAULT_VERBOSITY or Makefile_DEFAULT_VERBOSITY)
VERBOSE           = $(error not VERBOSE, but VERBOSITY)
VERBOSE_CONDITION = $(error not VERBOSE_CONDITION, but VERBOSITY_CONDITION)
VERBOSE_BOOLEAN   = $(error not VERBOSE_BOOLEAN, but VERBOSITY_BOOLEAN)

# Verbosity, as $(if ...)
# Usage:
#
#    $(if $(filter 1, $(__verbosity_VERBOSITY)), ... do stuff ...)
#
# maps: V = case when unset -> 0; when 0 -> 0, when 1 -> 1, otherwise -> 1
# then: $(if $(filter 1,$(V)),$(info debug: ... blah blah blah ...))
__verbosity_VERBOSITY__MAPPER = $(strip $(if $(filter 1, $1), 1, $(if $(filter 0, $1), 0, $(if $1, 1, 0))))
__verbosity_VERBOSITY_MAPPER = $(call __verbosity_VERBOSITY__MAPPER,$(strip $1))

__verbosity_def_VERBOSITY_BOOLEAN = $(call __verbosity_VERBOSITY_MAPPER, $V)
__verbosity_ref_VERBOSITY_BOOLEAN = $(__verbosity_def_VERBOSITY_BOOLEAN)

__verbosity_def_VERBOSITY_CONDITION = $(filter 1, $(__verbosity_def_VERBOSITY_BOOLEAN))
__verbosity_ref_VERBOSITY_CONDITION = $(__verbosity_def_VERBOSITY_CONDITION)

__verbosity_empty = (empty)
__verbosity_def_VERBOSITY = \
$(info notice: do not use VERBOSITY, rather use VERBOSITY_CONDITION or VERBOSITY_BOOLEAN)\
$(info notice: currently, VERBOSITY_CONDITION = $(if $(VERBOSITY_CONDITION),$(VERBOSITY_CONDITION),$(__verbosity_empty)))\
$(info notice: currently, VERBOSITY_BOOLEAN = $(if $(VERBOSITY_BOOLEAN),$(ooleanVERBOSITY_),$(__verbosity_empty)))\
$(error references to VERBOSITY are invalid, instead use VERBOSITY_CONDITION or VERBOSITY_BOOLEAN)\
$(end)
__verbosity_ref_VERBOSITY = $(__verbosity_def_VERBOSITY)

__verbosity_def_DEFAULT_VERBOSITY_BOOLEAN = $(call __verbosity_VERBOSITY_MAPPER, $(word 1, $(sort $(Makefile_DEFAULT_VERBOSITY) $(AM_DEFAULT_VERBOSITY) 0)))
__verbosity_ref_DEFAULT_VERBOSITY_BOOLEAN = $(__verbosity_def_DEFAULT_VERBOSITY_BOOLEAN)
$(if $(filter 1, $(__verbosity_ref_VERBOSITY_BOOLEAN)), $(info verbose: VERBOSITY_BOOLEAN=$(VERBOSITY_BOOLEAN)))
$(if $(filter 1, $(__verbosity_ref_VERBOSITY_BOOLEAN)), $(info verbose: VERBOSITY_CONDITION=$(VERBOSITY_CONDITION)))
$(if $(filter 1, $(__verbosity_ref_VERBOSITY_BOOLEAN)), $(info verbose: VERBOSITY=<invalid>, use V=1 to enable verbosity))
$(if $(filter 1, $(__verbosity_ref_VERBOSITY_BOOLEAN)), $(info verbose: DEFAULT_VERBOSITY_BOOLEAN=$(DEFAULT_VERBOSITY_BOOLEAN)))

#
# Usage (in various sites: Makefile.am or Makefile or fragment.mk)
# 
#     AM_LDFLAGS  = $(V_LDFLAGS_avoid.$(V))
#     AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))
#
#     .../dependencies.mk:
#         $(V_BB1ST) ...shell-commands...
#         $(V_BD2ND) ...shell-commands...
#     .../something-else.mk
#         $(V_BDINC) ...shell-commands...
#
#     install-this-or-that:
#         $(V_INSTALL) ...shell-commands...
#

# chatter for baleful-ballad 1st pass
V_BB1ST = $(__v_BB1ST_$(V))
__v_BB1ST_ = $(__v_BB1ST_$(if $(DEFAULT_VERBOSITY_BOOLEAN),$(DEFAULT_VERBOSITY_BOOLEAN),1))
__v_BB1ST_0 = @echo "  BB-1ST ($@)";
__v_BB1ST_1 = 

# chatter for baleful-ballad 2nd pass
V_BB2ND = $(__v_BB2ND_$(V))
__v_BB2ND_ = $(__v_BB2ND_$(if $(DEFAULT_VERBOSITY_BOOLEAN),$(DEFAULT_VERBOSITY_BOOLEAN),1))
__v_BB2ND_0 = @echo "  BB-2ND ($@)";
__v_BB2ND_1 = 

# chatter for baleful-ballad incremental (used in the $(bbDC)-generated *.mk fragment files)
V_BBINC = $(__v_BBINC_$(V))
__v_BBINC_ = $(__v_BBINC_$(if $(DEFAULT_VERBOSITY_BOOLEAN),$(DEFAULT_VERBOSITY_BOOLEAN),1))
__v_BBINC_0 = @echo "  CXX-BB  <$(strip $(call SCOLD_SOURCEStoMODULENAMES,$@))>";
__v_BBINC_1 = 

V_INSTALL = $(__v_INSTALL_$(V))
__v_INSTALL = $(__v_INSTALL_$(if $(DEFAULT_VERBOSITY_BOOLEAN),$(DEFAULT_VERBOSITY_BOOLEAN),1))
__v_INSTALL_0 = @echo "  INSTALL     " $@;
__v_INSTALL_1 = 

V_LIBTOOLFLAGS_VERBOSE_Veq0 = --silent
V_LIBTOOLFLAGS_VERBOSE_Veq1 = --verbose

# AM_LDFLAGS is deprecating.
# AM_LDFLAGS is variously used.
# Do not use AM_LDFLAGS; though LDFLAGS remains reserved caller the top-level caller (of make)
#
# AM_LDFLAGS non-usage used by CXXLINK
#         which is used to make convenience libraries; e.g. libwant.la
#         this appears to be a leftover accident.
#         in this case there is libwant_la_LIBADD but no libwant_la_LDFLAGS
# NOT used by lib_lib${LIBRARY}_la_LINK, e.g. lib/libsomething-module.la
#             which is used to make final-link{ed,able} shared libraries.
# NOT used by bin_${PROGRAM}_LINK, e.g. bin/unit
#             which is used o make final-linked executables.
#
# Usage:
#
#   AM_LDFLAGS  = $(V_LDFLAGS_avoid.VERBOSE_Veq$(V))
#   AM_LIBTOOLFLAGS = $(V_LIBTOOLFLAGS_VERBOSE_Veq$(V))
#
V_LDFLAGS_avoid.VERBOSE_Veq0 = $(empty)
V_LDFLAGS_avoid.VERBOSE_Veq1 = $(warning warning: $@, \
CXXLINK still uses the AM_LDFLAGS variable is which is deprecated,  instead, use \
$(subst .,_,$(subst -,_,$(@F)_LIBADD)) \
or if available, \
$(subst .,_,$(subst -,_,$(@F)_LDFLAGS)))

# [[deprecated]] --------------------------------------------------------------------------------
# and thus avoid using them

# [[deprecated]] but used in the the generated *.mk files
AM_V_BBINC = $(V_BBINC)
AM_V_BB1ST = $(V_BB1ST)
AM_V_BB2ND = $(V_BB2ND)

V_LDFLAGS_avoid.0 = $(V_LDFLAGS_avoid.VERBOSE_Veq0)
V_LDFLAGS_avoid.1 = $(V_LDFLAGS_avoid.VERBOSE_Veq1)

# end
