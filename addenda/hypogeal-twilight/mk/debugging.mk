# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
# must cooperate with vernacular-doggerel .../mk/debugging.mk
hypogeal_twilight_debugging_mk_included = 1

#
# Usage:  (in a Makefile or Makefile.am)
#
#     include @hypogeal_twilight_datarootdir@/mk/debugging.mk
#     ...but other higher-level includes, e.g. mk/compile.mk may have already included it for you.
#
# Usage of the verbosity
#
#   either:  $(if $(filter 1, $(DEBUGGING_BOOLEAN)),   $(info verbose: ... see something ... say something ...))
#       or:  $(if $(DEBUGGING_CONDITION),              $(info verbose: ... see something ... say something ...))
#
# The debugging system rhymes with the conventions of the verbosity system of hypogeal-twilight (herein).
# In turn the hypogeal-twilight verbosity system follows the convention of automake's verbosity system.
#
# The D variable is reserved to the command line (i.e. unassigned but referenced herein)
#
#   D - a choice of verbosity among D=1, D=0, unassigned
#
# These variables are reserved to the top-level Makefile or Makefile.am (i.e. unassigned but referenced herein)
#
#   Makefile_DEFAULT_DEBUGGING        is for hand-coded (GNU) Makefiles, see $D
#   DEFAULT_DEBUGGING                 is defined herein as the rhyming equivalent of AM_DEFAULT_DEBUGGING
#                                     NO SUCH ---> AM_DEFAULT_DEBUGGING <--- NO SUCH
#

# is 1 or empty, useful for $(if ...)
DEBUGGING_CONDITION = $(__debugging_ref_DEBUGGING_CONDITION)
# is 0 or 1, useful for substitution
DEBUGGING_BOOLEAN = $(__debugging_ref_DEBUGGING_BOOLEAN)
# is disallowed (go ahead, try and use it)
DEBUGGING = $(__debugging_ref_DEBUGGING)
# resolves the multiple signals of the default debugging
DEFAULT_DEBUGGING_BOOLEAN = $(__debugging_ref_DEFAULT_DEBUGGING_BOOLEAN)

DEFAULT_DEBUGGING = $(if $(Makefile_DEFAULT_DEBUGGING), $(Makefile_DEFAULT_DEBUGGING), 0)
DEBUG           = $(error not DEBUG, but DEBUGGING)
DEBUG_CONDITION = $(error not DEBUG_CONDITION, but DEBUGGING_CONDITION)
DEBUG_BOOLEAN   = $(error not DEBUG_BOOLEAN, but DEBUGGING_BOOLEAN)

# Debugging, as $(if ...)
# Usage:
#
#    $(if $(filter 1, $(__debugging_DEBUGGING)), ... do stuff ...)
#
# maps: D = case when unset -> 0; when 0 -> 0, when 1 -> 1, otherwise -> 1
# then: $(if $(filter 1,$(D)),$(info debug: ... blah blah blah ...))
__debugging_DEBUGGING__MAPPER = $(strip $(if $(filter 1, $1), 1, $(if $(filter 0, $1), 0, $(if $1, 1, 0))))
__debugging_DEBUGGING_MAPPER = $(call __debugging_DEBUGGING__MAPPER,$(strip $1))

__debugging_def_DEBUGGING_BOOLEAN = $(call __debugging_DEBUGGING_MAPPER, $V)
__debugging_ref_DEBUGGING_BOOLEAN = $(__debugging_def_DEBUGGING_BOOLEAN)

__debugging_def_DEBUGGING_CONDITION = $(filter 1, $(__debugging_def_DEBUGGING_BOOLEAN))
__debugging_ref_DEBUGGING_CONDITION = $(__debugging_def_DEBUGGING_CONDITION)

__debugging_empty = (empty)
__debugging_def_DEBUGGING = \
$(info notice: do not use DEBUGGING, rather use DEBUGGING_CONDITION or DEBUGGING_BOOLEAN)\
$(info notice: currently, DEBUGGING_CONDITION = $(if $(DEBUGGING_CONDITION),$(DEBUGGING_CONDITION),$(__debugging_empty)))\
$(info notice: currently, DEBUGGING_BOOLEAN = $(if $(DEBUGGING_BOOLEAN),$(ooleanDEBUGGING_),$(__debugging_empty)))\
$(error references to DEBUGGING are invalid, instead use VERBOSITY_CONDITION or VERBOSITY_BOOLEAN)\
$(end)
__debugging_ref_DEBUGGING = $(__debugging_def_DEBUGGING)

__debugging_def_DEFAULT_DEBUGGING_BOOLEAN = $(call __debugging_DEBUGGING_MAPPER, $(word 1, $(sort $(Makefile_DEFAULT_DEBUGGING) $(DEFAULT_DEBUGGING) 0)))
__debugging_ref_DEFAULT_DEBUGGING_BOOLEAN = $(__debugging_def_DEFAULT_DEBUGGING_BOOLEAN)
$(if $(filter 1, $(__debugging_ref_DEBUGGING_BOOLEAN)), $(info verbose: DEBUGGING_BOOLEAN=$(DEBUGGING_BOOLEAN)))
$(if $(filter 1, $(__debugging_ref_DEBUGGING_BOOLEAN)), $(info verbose: DEBUGGING_CONDITION=$(DEBUGGING_CONDITION)))
$(if $(filter 1, $(__debugging_ref_DEBUGGING_BOOLEAN)), $(info verbose: DEBUGGING=<invalid>, use D=1 to enable debugging))
$(if $(filter 1, $(__debugging_ref_DEBUGGING_BOOLEAN)), $(info verbose: DEFAULT_DEBUGGING_BOOLEAN=$(DEFAULT_DEBUGGING_BOOLEAN)))

# end
