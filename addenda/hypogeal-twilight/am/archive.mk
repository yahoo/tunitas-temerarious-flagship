# included via automake, not really a -*- Makefile -*- but a fragment of one
$(info deprecating: avoid .../am/archive.mk of hypogeal-twilight)
$(info deprecating: instead use .../mk/build.mk of vernacular-doggerel)

# Usage
#
#   "The caller" is the top-level Makefile (Makefile.am).
#
#   The caller MAY choose to institutionalize RPMBUILD_OPTIONS
#   e.g. RPMBUILD_OPTIONS = $(RPMBUILD_OPTIONS.Fedora)
#
#   The caller MUST choose a "to the packaging" production
#   in the Makefile (Makefile.am) is responsible for declaring one of
#     1. rpm-package: git_archive-rpmbuild-mock
#                     common, especially for automake-managed packages
#     2. rpm-package: tar_there-rpmbuild-mock
#                     rare, note the 'tar_there', not 'tar_here', c.f. bootstrap-remonstrate
#
#   The caller MAY choose to have a "trial-the-packaging" production
#     1.  trial-rpm-package: tar_here-rpmbuild-mock
#                            note the use of 'tar_here', see trial='t99'
#
#   The caller MAY choose to have a "check-the-already-packaged" production
#     1.  check-rpm-package: CHECK_rpmbuild-mock
#                            with CHECK_rpmbuild-mock being define elsewhere
#
# Usage #1 in an handcoded package (not managed by automake)
#
#    in Makefile
#       ...etc...
#       SPECFILE = hypogeal-twilight.spec
#       mk/configured.mk: Makefile $(SPECFILE)
#       	./configure <------------------------- as a convenience, auto-generate in place.
#       include ./mk/configured.mk
#       RPMBUILD_OPTIONS = $(RPMBUILD_OPTIONS.Fedora)
#       rpm-package: tar_there-rpmbuild-mock
#       trial-rpm-package: exit 1
#       check-rpm-package: exit 1
#       include $(hypogeal_twilight_datarootdir)/am/archive.mk
#
# Usage #2 in an automake-managed package
#
#    in Makefile.am (automake)
#       ...etc...
#       include mk/configured.mk ..................................... is created during ./configure
#       RPMBUILD_OPTIONS = $(RPMBUILD_OPTIONS.Fedora)
#       rpm-package: git_archive-rpmbuild-mock
#       trial-rpm-package: tar_here-rpmbuild-mock
#       check-rpm-package: CHECK_rpmbuild-mock
#       include @hypogeal_twilight_datarootdir@/am/archive.mk ........ AFTER 
#
#     in configure.ac
#       SCOLD_ENABLE_MOCK_BUILD             which creates mk/configured.mk and --enable-specfile=SPECFILE
#

# The make (automake) definitions needed to export a buildable archive.
# when the code should be built for an rpm, e.g. in mock

ifeq "undefined" "$(origin hypogeal_twilight_prefix)"
ifneq "undefined" "$(origin HYPOGEAL_TWILIGHT)"
# hypogeal_twilight_prefix should not be undefined, but if it is then maybe HYPOGEAL_TWILIGHT is not
# HYPOGEAL_TWILIGHT arrives from the user on the command line
# hypogeal_twilight_prefix should arrive from @hypogeal_twilight_prefix@
hypogeal_twilight_prefix = $(HYPOGEAL_TWILIGHT)
endif
endif
# Also defined in ./mk/configured.mk via ./configure
ifeq "undefined" "$(origin hypogeal_twilight_prefix)"
# If it is undefined then how did you get to include this fragment?
$(error hypogeal_twilight_prefix is not defined in mk/configured.mk as was expected from ./configure)
endif

#
# NOT HERE, but rather in the Makefile.am
# DO NOT include mk/configured.mk
# DO NOT mk/configured.mk: $(RPM_SPEC_FILE) Makefile.am configure.ac
#
# If not already defined, then give it a default value. This value is ALWAYS wrong in a mock build.
RPM_SPEC_FILE ?= $(addsuffix .spec, $(notdir $(PWD)))

# FIXME - there is code in the various Makefile.am that almost does the same thing
# see .../ac/with-mock.m4
# see .../ac/with-sibling.m4
#
# newer
#     hypogeal_twilight_libexec = @hypogeal_twilight_libexec@
#     hypogeal_twilight_libexec_ac = @hypogeal_twilight_libexec_ac@
#     hypogeal_twilight_libexec_rpm = @hypogeal_twilight_libexec_rpm@
# older
#     hypogeal_twilight_prefix = @hypogeal_twilight_prefix@
#     and we must compute where "libexec" ought to be
#     but it might be a development-shaped area or an installation-shaped area
#     $(hypogeal_twilight_prefix)/libexec/hypogeal-twilight/extract-rpm-specfile-value
#     $(hypogeal_twilight_prefix)/rpm/extract-rpm-specfile-value
extract = \
  $(addsuffix /extract-rpm-specfile-value, \
             $(if $(hypogeal_twilight_libexec), \
                  $(hypogeal_twilight_libexec), \
                  $(foreach candidate, $(word 1, \
                                         $(wildcard \
                                           $(hypogeal_twilight_libexec_rpm), \
                                           $(hypogeal_twilight_prefix)/libexec/hypogeal-twilight \
                                           $(hypogeal_twilight_prefix)/rpm)), \
                            $(if $(candidate), $(candidate), $(error Cannot guess where hypogeal-twilight might exist)))))
ifeq "" "$(wildcard $(extract))"
$(info extract=$(extract))
$(info hypogeal_twilight_prefix=$(hypogeal_twilight_prefix))
$(info hypogeal_twilight_libexec=$(hypogeal_twilight_libexec))
$(info hypogeal_twilight_libexec_ac=$(hypogeal_twilight_libexec_ac))
$(info hypogeal_twilight_libexec_rpm=$(hypogeal_twilight_libexec_rpm))
$(info hypogeal_twilight_datarootdir=$(hypogeal_twilight_datarootdir))
$(error no extract-rpm-specfile-value in hypogeal-twilight in $(hypogeal_twilight_prefix) as $(extract))
endif
ifeq "" "$(wildcard $(RPM_SPEC_FILE))"
$(error missing specfile $(RPM_SPEC_FILE))
endif

MODULE_NAME ?= $(shell $(extract) Name $(RPM_SPEC_FILE))
MODULE_VERSION ?= $(shell $(extract) Version $(RPM_SPEC_FILE))
MODULE_RELEASE ?= $(shell $(extract) Release $(RPM_SPEC_FILE))

# these values are for mock, but also defined in ./mk/configured.mk
# WATCHOUT - they are *also* evaluated in the mock chroot environment, which is not in a git repo
MOCK_GIT_BRANCH ?= $(shell set -o pipefail ; git branch -l 2>/dev/null | sed -ne '/^\* / {; s/^..//p; }' || echo none)
# By convention /etc/mock/$hostname.cfg is a variant of /etc/movk/default.cfg.
# But see site-defaults.cfg which specifies /build/scold/repo for the as-built rpms
MOCK_CFG_NAME ?= $(shell hostname -s)
# expect /build/mock/{SOURCES,SRPMS}
MOCK_RPMBUILD_ROOT ?= $(shell rpm --eval '%_topdir')

# derived from the values defined above
MODULE_MOCK = $(MODULE_NAME).mock
MODULE_NAME_VERSION = $(MODULE_NAME)-$(MODULE_VERSION)
TAR_BALL = $(addsuffix .tar.gz, $(MODULE_NAME))
RPM_SRC_FILE = $(MODULE_NAME)-$(MODULE_VERSION)-$(MODULE_RELEASE).src.rpm

# matches '%define trial t99.' in the specfile
THRM_TRIAL_TOKEN = t99

FINAL_SRC_RPM_FILE = $(MODULE_NAME)-$(MODULE_VERSION)-$(MODULE_RELEASE).src.rpm
TRIAL_SRC_RPM_FILE = $(MODULE_NAME)-$(MODULE_VERSION)-$(THRM_TRIAL_TOKEN).$(MODULE_RELEASE).src.rpm
MOCK_RPMBUILD_TAR_BALL_PATH = $(MOCK_RPMBUILD_ROOT)/SOURCES/$(TAR_BALL)
MOCK_RPMBUILD_FINAL_SRC_RPM_PATH = $(MOCK_RPMBUILD_ROOT)/SRPMS/$(FINAL_SRC_RPM_FILE)
MOCK_RPMBUILD_TRIAL_SRC_RPM_PATH = $(MOCK_RPMBUILD_ROOT)/SRPMS/$(TRIAL_SRC_RPM_FILE)

# deprecating
MODULE_PREFIX = $(MODULE_NAME_VERSION)

garm git_archive-rpmbuild-mock:
	git archive --format=tar.gz --prefix=$(MODULE_PREFIX)/ --output=$(MOCK_RPMBUILD_TAR_BALL_PATH) $(MOCK_GIT_BRANCH)
	rpmbuild -bs $(RPMBUILD_OPTIONS) $(RPM_SPEC_FILE)
	mock -r $(MOCK_CFG_NAME) $(RPMBUILD_OPTIONS) $(MOCK_RPMBUILD_FINAL_SRC_RPM_PATH)

# put the archive in a NV-named place
# tar ........... --transform='s,^\./,$(MODULE_NAME_VALUE)/,'
# git archive ... --prefix=$(MODULE_NAME_VALUE)/
#
# WATCHOUT #1 - do not use an empty transform pattern, --transform='s,^,$(MODULE_NAME_VALUE)/,'
#                                                                  |
# this ----------------------------------------------------------- /
# because that will transform the values of the symlinks and break the shared library symlinks
# e.g.  (concept: ls -l)
#
#     /opt/scold/bootstrap/lib/libsys-time-module.a
#     /opt/scold/bootstrap/lib/libsys-time-module.la
#     /opt/scold/bootstrap/lib/libsys-time-module.so -> bootstrap-remonstrate-0.2.0/libsys-time-module.so.1.0.0
#     /opt/scold/bootstrap/lib/libsys-time-module.so.1 -> bootstrap-remonstrate-0.2.0/libsys-time-module.so.1.0.0
#     /opt/scold/bootstrap/lib/libsys-time-module.so.1.0.0   ^
#                                                            |
# bad -------------------------------------------------------/
#
# we must have the "normal" symlinks, so that the shared libraries will work
#
#     /opt/scold/bootstrap/lib/libsys-time-module.so -> libsys-time-module.so.1.0.0
#     /opt/scold/bootstrap/lib/libsys-time-module.so.1 -> libsys-time-module.so.1.0.0
#
# WATCHOUT #2 - extracting debug info is non-deterministic, sometimes it fails, but succeeds subsequently
#
#    + /usr/lib/rpm/find-debuginfo.sh --strict-build-id -m --run-dwz --dwz-low-mem-die-limit 10000000 --dwz-max-die-limit 110000000 $BUILDDIR
#    extracting debug info from $BUILDROOTDIR/opt/scold/lib64/libPACKAGE.so.0.0.0
#    *** ERROR: No build ID note found in $BUILDROOTDIR/opt/scold/lib64/libPACKAGE.so.0.0.0
#    error: Bad exit status from /var/tmp/rpm-tmp.zbWhYB (%install)
#
# this is designed for trial rpmbuilds before using git_archive-rpmbuild-mock
RPMBUILD_OPTIONS.thrm = --with=thrm
thrm: tar_here-rpmbuild-mock
tar_here-rpmbuild-mock:
	dotslash='./' ; dotslash_regex='\./'; \
	tar -C . \
	    -zcf $(MOCK_RPMBUILD_TAR_BALL_PATH) \
	    --transform="s,^$${dotslash_regex},$(MODULE_NAME_VERSION)/," "$${dotslash}"
	rpmbuild -bs $(RPMBUILD_OPTIONS.thrm) $(RPMBUILD_OPTIONS) $(RPM_SPEC_FILE)
	{ mock -r $(MOCK_CFG_NAME) $(RPMBUILD_OPTIONS.thrm) $(RPMBUILD_OPTIONS) $(MOCK_RPMBUILD_TRIAL_SRC_RPM_PATH) && \
	  echo "OK (make $@)"; } || \
	{ echo "FAILure (make $@): failed to build in mock"; exit 1; }

2.tar_here-rpmbuild-mock:
	dotslash='./' ; dotslash_regex='\./'; \
	tar -C . \
	    -zcf $(MOCK_RPMBUILD_TAR_BALL_PATH) \
	    --transform="s,^$${dotslash_regex},$(MODULE_NAME_VERSION)/," "$${dotslash}"
	rpmbuild -bs $(RPMBUILD_OPTIONS.thrm) $(RPMBUILD_OPTIONS) $(RPM_SPEC_FILE)
	{ mock -r $(MOCK_CFG_NAME) $(RPMBUILD_OPTIONS.thrm) $(RPMBUILD_OPTIONS) $(MOCK_RPMBUILD_TRIAL_SRC_RPM_PATH) && \
	  echo "OK on try #1 of 2 (make $@)"; } || \
	{ echo "FAILure on try #1 of 2 (make $@): failed to build in mock twice now"; \
	  mock -r $(MOCK_CFG_NAME) $(RPMBUILD_OPTIONS.thrm) $(RPMBUILD_OPTIONS) $(MOCK_RPMBUILD_TRIAL_SRC_RPM_PATH) && \
	  echo "OK on try #2 of 2 (make $@)"; } || \
	{ echo "FAILure on try #2 of 2 (make $@): failed to build in mock twice now"; exit 1; }

# end
