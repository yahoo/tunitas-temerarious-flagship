# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# [[REMOVEWHEN]] every single Makefile.am in the universe no longer references EXTERNAL-PATHS.mk (i.e. when the sun grows cold?)
#
$(if $(VERBOSITY_CONDITION),\
$(info .../am/EXTERNAL-PATHS.mk: automake include files using a '*.mk' are deprecated)\
$(info .../am/EXTERNAL-PATHS.mk: instead use 'include $(at)hypogeal_twilight_datarootdir$(at)/am/EXTERNAL-PATHS.am'))
include mk/configured.mk
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir should have been defined in mk/configured.mk by ./configure))
ifneq "file" "$(origin hypogeal_twilight_compile_mk_included)"
#
# The whole of the functionality of EXTERNAL-PATHS.mk moves to .../mk/compile.mk
include $(hypogeal_twilight_datarootdir)/mk/compile.mk
endif
