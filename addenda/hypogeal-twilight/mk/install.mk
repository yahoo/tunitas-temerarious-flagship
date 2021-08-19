# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
hypogeal_twilight_install_mk = 1

#
# Position:
#
#    The include of .../mk/install.mk is used in Makefile.am at the top level
#    It MUST be placed AFTER all of the SOURCES and MODULES variables are defined
#    It CAN be placed last.
#
# Compatibilities:
#
#    INSTALL_MODULES variable captures the installed modules.
#    (ignored) MODULES variable captures ALL modules, even the modules which are not installable.
#       whereas noinst_LTLIBRARIES lists uninstalled convenience libraries that may have installable modules
#
# Usage: (in Makefile.am)
#
#    default:
#    DEVELOPMENT_AREAS = ...somehow...
#    TESTING_AREAS = ...somehow...
#    INSTALLATION_AREAS = ...somehow...
#    include $(hypogeal_twilight_datarootdir)/mk/compile.mk
#    ...etc...
#    include src/something/something/Makefrag.am
#    include src/dark/side/Makefrag.am
#    INSTALL_MODULES = $(lib_libsomething_something_la_MODULES) $(lib_libdark_side_la_MODULES)
#    include $(hypogeal_twilight_datarootdir)/mk/install.mk
#

# This rhymes with $(includedir) and $(libdir) 
# we wish it was provided for us by the autotools directly.
modulesdir = $(prefix)/modules

# [[deprecating]] ----------------------------------------------------------------------------------------------------
# [[maybe]] these definitions will be moving off to .../mk/install.mk for anguish-answer and baleful-ballad
# If, perhaps, anguish-answer and baleful-ballad each have different (yet mutually compatible) schemes for storing the modules
# then each of them should, inddpendently, supply their own rules so that their rules can evolve with them, each independently.

ifneq "undefined" "$(flavor anguish_answer_datarootdir)"
ifneq "" "$(wildcard $(anguish_answer_datarootdir)/mk/install.mk)"
$(if $(VERBOSITY_CONDITION),$(info loading $(anguish_answer_datarootdir)/mk/install.mk))
include $(anguish_answer_datarootdir)/mk/install.mk
endif
endif

ifneq "undefined" "$(flavor baleful_ballad_datarootdir)"
ifneq "" "$(wildcard $(baleful_ballad_datarootdir)/mk/install.mk)"
$(if $(VERBOSITY_CONDITION),$(info loading $(baleful_ballad_datarootdir)/mk/install.mk))
include $(baleful_ballad_datarootdir)/mk/install.mk
endif
endif

# [[continuing]] ----------------------------------------------------------------------------------------------------

#
# Publication of a module requires declaring the
#    INSTALL_MODULES
#
# or an older DC-agnostic set based on the sources
#    module_SOURCE_SET
#
# or older DC-specific rules
#    module_AA_SOURCE_SET
#    module_BB_SOURCE_SET
#
#     Usage:
#         INSTALL_MODULES = $(lib_libsomething_la_MODULES)
#
# Use of the published module(s) requires establishing the appropriate SEARCHPATH which is computed in .../mk/compile.mk
#

#
# Look for some backwards compatibility conflicts
# Look for some common mistakes.
#
# Look for explicit mention of anguish-answer or baleful-ballad.
#
# neither - is preferred
# both    - is wrong because it is inconsistent; you must choose zero or one.
# either  - is warned about and the mode is ignored
#

# https://www.gnu.org/software/make/manual/html_node/Origin-Function.html
__install_anguish_answer_defined = $(if $(filter 0, $(words $(anguish_answer_prefix))),undefined,unundefined)
__install_baleful_ballad_defined = $(if $(filter 0, $(words $(baleful_ballad_prefix))),undefined,unundefined)
ifeq "defined-defined" "$(__install_anguish_answer_defined)-$(__install_baleful-ballad_defined)"
$(error both anguish-answer and baleful-ballad cannot be selected)
else
ifeq "undefined-undefined" "$(__install_anguish_answer_defined)-$(__install_baleful_ballad_defined)"
# This is the preferred mode.
__install_default_disaggregation_compiler = defined
endif
endif

ifneq "0" "$(words $(INSTALLED_MODULES))"
$(info notice: past tense is invalid $(origin INSTALLED_MODULES) words=$(words $(INSTALLED_MODULES)) INSTALLED_MODULES=$(INSTALLED_MODULES))
$(info notice: present tense is valid $(origin INSTALL_MODULES) INSTALL_MODULES=$(INSTALL_MODULES))
$(error INSTALL_MODULES [present] is the expected usage, yet INSTALLED_MODULES [past tense] is used)
endif

ifneq "0" "$(words $(module_SOURCES_SET))"
$(info notice: plural is invalid $(origin module_SOURCES_SET) words=$(words $(module_SOURCES_SET)) module_SOURCES_SET=$(module_SOURCES_SET))
$(info notice: singular is valid $(origin module_SOURCE_SET) module_SOURCE_SET=$(module_SOURCE_SET))
$(warning module_SOURCE_SET [singular] is the expected usage, yet module_SOURCES_SET [invalid-plural] is used)
endif
ifneq "0" "$(words $(module_AA_SOURCES_SET))"
$(info notice: plural is invalid $(origin module_AA_SOURCES_SET) words=$(words $(module_AA_SOURCES_SET)) module_AA_SOURCES_SET=$(module_AA_SOURCES_SET))
$(info notice: singular is valid $(origin module_SOURCE_SET) module_SOURCE_SET=$(module_AA_SOURCE_SET))
$(warning module_AA_SOURCE_SET [singular] is the expected usage, yet module_AA_SOURCES_SET [invalid-plural] is used)
endif
ifneq "0" "$(words $(module_BB_SOURCES_SET))"
$(info notice: plural is invalid $(origin module_BB_SOURCES_SET) words=$(words $(module_BB_SOURCES_SET)) module_BB_SOURCES_SET=$(module_BB_SOURCES_SET))
$(info notice: singular is valid $(origin module_BB_SOURCE_SET) module_BB_SOURCE_SET=$(module_BB_SOURCE_SET))
$(warning module_BB_SOURCE_SET [singular] is the expected usage, yet module_BB_SOURCES_SET [invalid-plural] is used)
endif

# prefer INSTALL_MODULES
# complain about the old ways
ifeq "1" "$(__install_module_AA_SOURCE_SET_defined)"
$(info notice: module_AA_SOURCE_SET=$(module_AA_SOURCE_SET))
$(info notice: whereas the use of module_AA_SOURCE_SET is deprecating)
$(info notice: prefer the use of INSTALL_MODULES)
$(warning baleful-ballad was selected, yet the deprecating module_AA_SOURCE_SET is still in use)
endif
ifeq "1" "$(__install_module_BB_SOURCE_SET_defined)"
$(info notice: module_BB_SOURCE_SET=$(module_BB_SOURCE_SET))
$(info notice: whereas the use of module_BB_SOURCE_SET is deprecating)
$(info notice: prefer the use of INSTALL_MODULES)
$(warning baleful-ballad was selected, yet the deprecating module_BB_SOURCE_SET is still in use)
endif
ifeq "1" "$(__install_module_SOURCE_SET_defined)"
$(info notice: module_SOURCE_SET=$(module_SOURCE_SET))
$(info notice: whereas the use of module_SOURCE_SET is deprecating)
$(info notice: prefer the use of INSTALL_MODULES)
$(warning baleful-ballad was selected, yet the deprecating module_SOURCE_SET is still in use)
endif

#
# Preference Ordering
#
#   INSTALL_MODULES    is a list of modules as computed by HT_SOURCEStoMODULES
#   (compatibility, newest scheme first, but all are deprecated)
#      modules_SOURCE_SET      is a list of SOURCES from the SOURCES variables
#      modules_BB_SOURCE_SET   ibidem.
#      modules_AA_SOURCE_SET   ibidem.
# 
__install_module_SOURCE_SET = \
  $(if $(filter defined, $(__install_default_disaggregation_compiler)), \
       $(module_SOURCE_SET), \
  $(if $(filter defined, $(__install_module_SOURCE_SET_defined)), \
       $(module_SOURCE_SET), \
  $(if $(filter defined, $(__install_module_BB_SOURCE_SET_defined)), \
       $(module_BB_SOURCE_SET), \
  $(if $(filter defined, $(__install_module_AA_SOURCE_SET_defined)), \
       $(module_AA_SOURCE_SET), \
       $(warning there is nothing to install)))))

# these will be installed into $(DESTDIR)/$(modulesdir)
__install_module_MODULE_SET = \
  $(if $(filter defined, $(MODULES)), \
       $(INSTALL_MODULES), \
       $(patsubst $(scold_cxx_modulesdir)/%,%, \
                  $(call HT_SOURCEStoMODULES,$(__install_module_SOURCE_SET)))) \
  $(end)
# DO NOT install hang off of 'install' (that causes automake to drop the install rule)
install-data-am: install-module_MODULE_SET
__install_INSTALLED_MODULE_SET = \
  $(foreach slash,/ /ipp/ /hpp/ /fpp/, \
            $(addprefix $(DESTDIR)$(modulesdir)$(slash),$(__install_module_MODULE_SET))) \
  $(end)
install-module_MODULE_SET: $(__install_INSTALLED_MODULE_SET)
$(__install_INSTALLED_MODULE_SET) : MODE=444
$(__install_INSTALLED_MODULE_SET) : $(DESTDIR)$(modulesdir)/% : $(scold_cxx_modulesdir)/%
	$(V_INSTALL) install -D -m $(MODE) $< $@

__install_Makefile := $(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))
$(if $(DEBUGGING_CONDITION),\
$(info $(__install_Makefile): DEBUG, [[internal]] __install_default_disaggregation_compiler=$(__install_default_disaggregation_compiler))\
$(info $(__install_Makefile): DEBUG, [[deprecating]] __install_anguish_answer_defined=$(__install_anguish_answer_defined))\
$(info $(__install_Makefile): DEBUG, [[deprecating]] __install_baleful_ballad_defined=$(__install_baleful_ballad_defined))\
$(info $(__install_Makefile): DEBUG, [[deprecating]] anguish_answer_prefix=[$(anguish_answer_prefix)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] baleful_ballad_prefix=[$(baleful_ballad_prefix)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] anguish_answer_datadir=[$(anguish_answer_datadir)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] baleful_ballad_datadir=[$(baleful_ballad_datadir)])\
$(info $(__install_Makefile): DEBUG, INSTALL_MODULES=[$(INSTALL_MODULES)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] module_SOURCE_SET=[$(module_SOURCE_SET)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] module_AA_SOURCE_SET=[$(module_AA_SOURCE_SET)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] module_BB_SOURCE_SET=[$(module_BB_SOURCE_SET)])\
$(info $(__install_Makefile): DEBUG, [[deprecating]] __install_module_SOURCE_SET_defined=$(__install_module_SOURCE_SET_defined))\
$(info $(__install_Makefile): DEBUG, [[deprecating]] __install_module_AA_SOURCE_SET_defined=$(__install_module_AA_SOURCE_SET_defined))\
$(info $(__install_Makefile): DEBUG, [[deprecating]] __install_module_BB_SOURCE_SET_defined=$(__install_module_BB_SOURCE_SET_defined))\
$(info $(__install_Makefile): DEBUG, [[internal]] __install_module_SOURCE_SET=[$(__install_module_SOURCE_SET)])\
$(info $(__install_Makefile): DEBUG, [[internal]] __install_module_MODULE_SET=[$(__install_module_MODULE_SET)]))
# end
