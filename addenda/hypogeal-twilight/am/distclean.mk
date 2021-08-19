# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# [[REMOVEWHEN]] every single Makefile.am in the universes no longer references distclean.mk (i.e. when the sun grows cold?)
$(if $(VERBOSITY_CONDITION),\
$(info .../am/distclean.mk: automake include files using a '*.mk' are deprecated)\
$(info .../am/distclean.mk: instead use 'include $(at)hypogeal_twilight_datarootdir$(at)/am/distclean.am'))
include mk/configured.mk
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir should have been defined in mk/configured.mk by ./configure))
$(if $(wildcard mk/configured.mk),$(__ok),$(warning mk/configured.mk is missing ... did you forget ENABLE_MOCK_BUILD in configure.ac))
include $(hypogeal_twilight_datarootdir)/mk/distclean.mk
