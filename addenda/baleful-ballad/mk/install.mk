# included via automake, not really a GNU -*- Makefile -*- fragment; For terms, see the LICENSE file at the top of the repository.
baleful_ballad_install_mk = 1

$(if $(modulesdir),$(__ok),$(error modulesdir is not defined))

# these will be installed into $(DESTDIR)/$(modulesdir)
module_BB_INTERFACES = \
  $(patsubst $(scold_cxx_modulesdir)/%,%, \
             $(call SCOLD_SOURCEStoMODULES,$(module_BB_SOURCE_SET))) \
  $(end)
# DO NOT install hang off of 'install' (that causes automake to drop the install rule)
install-data-am: install-module_BB_INTERFACES
INSTALLED_module_BB_INTERFACES = \
  $(foreach slash,/ /ipp/ /hpp/ /fpp/, \
            $(addprefix $(DESTDIR)$(modulesdir)$(slash),$(module_BB_INTERFACES))) \
  $(end)
install-module_BB_INTERFACES: $(INSTALLED_module_BB_INTERFACES)
$(INSTALLED_module_BB_INTERFACES) : MODE=444
$(INSTALLED_module_BB_INTERFACES) : $(DESTDIR)$(modulesdir)/% : $(scold_cxx_modulesdir)/%
	$(V_INSTALL) install -D -m $(MODE) $< $@


# end
