# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# must cooperate with vernacular-doggerel .../mk/verbosity.mk
# must be standalone for use with .../mk/check/*.mk only
hypogeal_twilight_check_verbosity_mk_included = 1

#
# Usage:
#
#     check-this-or-that:
#             $(V_TEST) ...shell-commands...
#

# also cooperates with .../mk/verbosity.mk
# does not require .../mk/verbosity.mk

V_TEST = $(__v_TEST_$(V))
__v_TEST_ = $(__v_TEST_$(if $(DEFAULT_VERBOSITY),$(DEFAULT_VERBOSITY),1))
__v_TEST_0 = @echo "  TEST-MAKE ($$@)"; # WATCHOUT - this will be inside a macro so the $$ must be doubled
__v_TEST_1 = 

