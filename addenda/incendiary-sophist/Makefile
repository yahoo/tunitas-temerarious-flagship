# This is a -*- Makefile -*-, that is manually curated (sic)

default:

distclean: distclean-configured
distclean-configured:
	rm -f mk/configured.mk
include ./mk/configured.mk # was created by ./configure
# establishes the $(prefix) $(hypogeal_twilight_datarootdir)
$(if $(prefix),$(__ok),$(error prefix is undefined))
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir is undefined))

# theory https://fedoraproject.org/wiki/Packaging:RPMMacros?rd=Packaging/RPMMacros
_lib := $(shell if [ -f /lib64 ] ; then echo lib64 ; else echo lib; fi)
bindir = $(prefix)/bindir
libdir = $(prefix)/$(_lib)
libarchdir = $(libdir)
libpuredir = $(prefix)/lib
includedir = $(prefix)/include
modulesdir = $(prefix)/modules
libexecdir = $(prefix)/libexec
datarootdir = $(prefix)/share
datadir     = $(datarootdir)

# the package is incendiary-sophist; the test rigging is shared among many packages
pkglibexecdir  = $(libexecdir)/incendiary-sophist
pkglibpuredir  = $(libpuredir)/incendiary-sophist
pkglibarchdir  = $(libarchdir)/incendiary-sophist
pkgdatarootdir = $(datarootdir)/incendiary-sophist
pkgdatadir     = $(pkgdatarootdir)

# there are many test rigging contributors, not just incendiary-sophist
riglibpuredir  = $(libpuredir)/rigging
riglibarchdir  = $(libarchdir)/rigging
rigdatarootdir = $(datarootdir)/rigging
rigdatadir     = $(rigdatarootdir)

# mk/configured.mk must have already been made by ./buildconf && ./configure
mk/configured.mk:
include ./mk/configured.mk

dot.CHECKED = .checked
distclean: distclean-dot.CHECKED
distclean-dot.CHECKED:
	rm -rf $(dot.CHECKED)

CHECKABLE_LIBEXEC_SOURCES = \
  test-suite-summarizer \
  test-case-driver \
  $(end)
all: $(CHECKABLE_LIBEXEC_SOURCES)
CHECKED_LIBEXEC_SEMAPHORES = $(addprefix $(dot.CHECKED)/,$(CHECKABLE_LIBEXEC_SOURCES))
check: $(CHECKED_LIBEXEC_SEMAPHORES)
clean: clean-CHECKED_LIBEXEC_SEMAPHORES
clean-CHECKED_LIBEXEC_SEMAPHORES:
	rm -f $(CHECKED_LIBEXEC_SEMAPHORES)
$(CHECKED_LIBEXEC_SEMAPHORES) : $(dot.CHECKED)/% : %
	mkdir -p $(@D)
	bash -n $<
	touch $@
INSTALLED_LIBEXEC_FILES = \
  $(addprefix $(pkglibexecdir)/, \
              $(notdir \
                $(CHECKABLE_LIBEXEC_SOURCES))) \
  $(end)
install: $(INSTALLED_LIBEXEC_FILES)
$(INSTALLED_LIBEXEC_FILES) : $(pkglibexecdir)/% : %
	install -D -c -m 555 $< $@

# [[FIXTHIS]] can these be syntax checked anyway?
CHECKABLE_TEMPLATE_SOURCES = \
  sh/template.config.sh.in \
  $(end)
all: $(CHECKABLE_TEMPLATE_SOURCES)
CHECKED_TEMPLATE_SEMAPHORES = $(addprefix $(dot.CHECKED)/,$(CHECKABLE_TEMPLATE_SOURCES))
check: $(CHECKED_TEMPLATE_SEMAPHORES)
clean: clean-CHECKED_TEMPLATE_SEMAPHORES
clean-CHECKED_TEMPLATE_SEMAPHORES:
	rm -f $(CHECKED_TEMPLATE_SEMAPHORES)
$(CHECKED_TEMPLATE_SEMAPHORES) : $(dot.CHECKED)/% : %
	mkdir -p $(@D)
	bash -n $<
	touch $@
INSTALLED_TEMPLATE_FILES = \
  $(addprefix $(pkgdatadir)/, \
              $(CHECKABLE_TEMPLATE_SOURCES)) \
  $(end)
install: $(INSTALLED_TEMPLATE_FILES)
$(INSTALLED_TEMPLATE_FILES) : $(pkgdatadir)/sh/% : sh/%
	install -D -c -m 444 $< $@

CHECKABLE_RIGGING_SOURCES = \
  lib/rigging/compare_output.sh \
  lib/rigging/exiting.sh \
  lib/rigging/sysexits.sh \
  $(end)
all: $(CHECKABLE_RIGGING_SOURCES)
CHECKED_RIGGING_SEMAPHORES = $(addprefix $(dot.CHECKED)/,$(CHECKABLE_RIGGING_SOURCES))
check: $(CHECKED_RIGGING_SEMAPHORES)
clean: clean-CHECKED_RIGGING_SEMAPHORES
clean-CHECKED_RIGGING_SEMAPHORES:
	rm -f $(CHECKED_RIGGING_SEMAPHORES)
$(CHECKED_RIGGING_SEMAPHORES) : $(dot.CHECKED)/% : %
	mkdir -p $(@D)
	bash -n $<
	touch $@
INSTALLED_RIGGING_FILES = \
  $(addprefix $(riglibpuredir)/, \
              $(notdir \
                $(CHECKABLE_RIGGING_SOURCES))) \
  $(end)
install: $(INSTALLED_RIGGING_FILES)
$(INSTALLED_RIGGING_FILES) : $(riglibpuredir)/% : lib/rigging/%
	install -D -c -m 444 $< $@

default:
all:
check:
install:
usage:
clean:
realclean:
distclean:

check: all
default: all
distclean: clean
realclean: distclean

# When building inside of an rpm chroot, 'make install' is context-free
# When building outside of rpm, then 'make install' requires 'make check'.
$(if $(RPM_BUILD_ROOT),$(__install_no_check), install: check)
#end
