# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
hypogeal_twilight_distclean_mk = 1

# The make (automake) definitions needed to use the scaffolding of
#   anguish-answer
#   baleful-ballad (bootstrap-remonstrate)
# in and around the distclean hook.
#
# Usage:
#
#     automake needs to see the ::-sense of these (not being occluded in GNUmake include)
#     clean-local::
#     distclean-local::
#     maintainer-clean-local::
#     mostlyclean-local::
#     include @hypogeal_twilight_datarootdir@/am/distclean.mk
#

# WATCHOUT WATCHOUT WATCHOUT WATCHOUT WATCHOUT WATCHOUT WATCHOUT WATCHOUT 
# any declaration of these dependencies obviates automake's rule synthesis
# all, check, clean, distclean, install
#
# implicitly there is a mapping to the "-local" suffix form
#
#   clean: clean-local
#   distclean: distclean-local
#
.PHONY: clean-local
clean-local::
.PHONY: distclean-local
distclean-local::
	rm -rf $(scold_cxxdir)

# and what else?

# These are our invention, for the .../Makefrag.am
# to have automake refresh the SOURCES list, but not rebuild all, 'make clean-dependencies'
#
# Example:
#
#   $(scold_cxxdir)/something/dependencies.mk: Makefile
#   	$(AM_V_BB1ST) $(call bbSCOLD_DISAGGREGATE_COMPILE, $(bin_something_SOURCES))
#   	$(AM_V_BB2ND) $(call bbSCOLD_DEPENDENCIES_COMPILE, $(bin_something_SOURCES))
#   include $(scold_cxxdir)/something/dependencies.mk
#   clean-dependencies::
#   	rm -f $(scold_cxxdir)/something/dependencies.mk
#
.PHONY: clean-dependencies
clean-dependencies::
clean-local:: clean-dependencies

# idiomatic command-line usage
#   1. change a Makefrag.am to add a new C++ SOURCE file; e.g. in a SOURCES variable
#   2. make redepend all
#   3. profit!
redepend: clean-dependencies

# A documentariat
#
# https://www.gnu.org/software/automake/manual/html_node/Clean.html
# Concept of the heuristic of cleandliness
#
# make mostlyclean
# make clean
# make distclean
# make maintainer-clean
#
#    If make built it,
#        if it is commonly something that one would want to rebuild
#            (for instance, a .o file),
#            then mostlyclean should delete it.
#        else
#            then clean should delete it.
#    If configure built it,
#        then distclean should delete it.
#    If the maintainer built it
#        (for instance, a .info file),
#        then maintainer-clean should delete it.
#
# Of course, maintainer-clean should not delete anything that needs to exist in order to run ‘./configure && make’. 
#
# let's pretend that 'configure' made dependencies.mk, even though make creates it.
