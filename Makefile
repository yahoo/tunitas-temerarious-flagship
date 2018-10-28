# This is a GNU -*- Makefile -*-
default:

# defines prefix; e.g. prefix=/opt/tunitas
include mk/configured.mk
$(if $(prefix),$(__ok),$(error prefix was not defined by ./configure))
clean: clean-mk/configured.mk
clean-mk/configured.mk:
distclean: distclean-mk/configured.mk
distclean-mk/configured.mk: ; rm -f mk/configured.mk

libdir = $(DESTDIR)$(prefix)/lib
libexecdir = $(DESTDIR)$(prefix)/libexec
datadir = $(DESTDIR)$(prefix)/share

pkglibexecdir = $(libexecdir)/temerarious-flagship
pkgdatadir    = $(datadir)/temerarious-flagship

ac_FILES = \
  ac/tf_check.m4 \
  ac/tf_enable.m4 \
  ac/tf_finalize.m4 \
  ac/tf_init.m4 \
  ac/tf_msg.m4 \
  ac/tf_prog.m4 \
  ac/tf_submodules.m4 \
  ac/tf_tiers.m4 \
  ac/tf_with.m4 \
  $(end)
ac_CHECK = $(filter-out $(ac_FILES), $(wildcard ac/*.m4))
$(if $(ac_CHECK),$(error unlisted files: $(ac_CHECK)))

am_FILES = \
  am/build.mk \
  am/build.am \
  am/compile.am \
  am/install.am \
  $(end)
am_CHECK = $(filter-out $(am_FILES), $(wildcard am/*.mk am/*.am))
$(if $(am_CHECK),$(error unlisted files: $(am_CHECK)))

mk_FILES = \
  mk/build.mk \
  $(end)
# these are known synthetic files which aren't used herein
mk_KNOWN_FILES = mk/buildconfed.mk mk/configured.mk mk/extracted.mk
mk_CHECK = $(filter-out $(mk_FILES) $(mk_KNOWN_FILES), $(wildcard mk/*.mk))
$(if $(mk_CHECK),$(error unlisted files: $(mk_CHECK)))

FILES = \
  $(ac_FILES) \
  $(am_FILES) \
  $(mk_FILES) \
  $(end)
INSTALL_ac_FILES = $(addprefix $(pkgdatadir)/, $(ac_FILES))
INSTALL_am_FILES = $(addprefix $(pkgdatadir)/, $(am_FILES))
INSTALL_mk_FILES = $(addprefix $(pkgdatadir)/, $(mk_FILES))
INSTALL_FILES = \
  $(INSTALL_ac_FILES) \
  $(INSTALL_am_FILES) \
  $(INSTALL_mk_FILES) \
  $(end)

# [[FIXTHIS]] can we syntax-check makefile fragments or autoconf fragments?
check-am:
check-ac:
check-mk:
check-tests: check-tests-simple
check-tests-simple:
	cd tests/simple && ./maintenance/e2e

$(INSTALL_ac_FILES) : $(pkgdatadir)/% : %
	install -D -c -m 444 $< $@
$(INSTALL_am_FILES) : $(pkgdatadir)/% : %
	install -D -c -m 444 $< $@
$(INSTALL_mk_FILES) : $(pkgdatadir)/% : %
	install -D -c -m 444 $< $@

all: $(FILES)
clean:
check: check-ac check-am check-mk check-tests
distlean:
install: $(INSTALL_FILES)
default: all
