# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# [[REMOVEWHEN]] every single Makefile.am in the universes no longer references compile.mk (i.e. when the sun grows cold?)
$(if $(VERBOSITY_CONDITION),\
$(info .../am/compile.mk: automake-directory include files using a '*.mk' are deprecated)\
$(info .../am/compile.mk: automake-directories are .../am/... path names)\
$(info .../am/compile.mk: GNUmake-directories are .../mk/... path names)\
$(info .../am/compile.mk: instead use 'include $(at)hypogeal_twilight_datarootdir$(at)/mk/compile.mk')\
$(info .../am/compile.mk: which has a .../mk/... pathname and a *.mk suffix for the GNU make fragment))
include mk/configured.mk
$(if $(hypogeal_twilight_datadir),$(__ok),$(warning hypogeal_twilight_datadir should have been defined in mk/configured.mk by ./configure))
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(warning hypogeal_twilight_datarootdir should have been defined in mk/configured.mk by ./configure))
$(if $(filter 0, $(words $(hypogeal_twilight_datarootdir) $(hypogeal_twilight_datarootdir))),$(error neither hypogeal_twilight_datarootdir nor hypogeal_twilight_datadir are defined, cannot continue))
include $(word 1,$(hypogeal_twilight_datadir) $(hypogeal_twilight_datarootdir))/mk/compile.mk
