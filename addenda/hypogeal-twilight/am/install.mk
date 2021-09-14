# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# [[REMOVEWHEN]] every single Makefile.am in the universes no longer references install.mk (i.e. when the sun grows cold?)
$(if $(VERBOSITY_CONDITION),\
$(info .../am/install.mk: automake include files using a '*.mk' are deprecated)\
$(info .../am/install.mk: instead use 'include $(at)hypogeal_twilight_datarootdir$(at)/am/install.am'))
$(if $(DEBUGGING_CONDITION),\
$(foreach makefile, $(MAKEFILE_LIST), \
          $(info .../am/install.mk: DEBUG check $(makefile))))
include mk/configured.mk
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir should have been defined in mk/configured.mk by ./configure))
include $(hypogeal_twilight_datarootdir)/mk/install.mk
