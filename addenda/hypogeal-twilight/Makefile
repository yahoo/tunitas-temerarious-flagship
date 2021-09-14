# This is a GNU -*- Makefile -*-, that is manually curated (sic)
#
# Building and Installing the Package (see the README, nearby)
#
#   ( ./buildconf && ./configure && make check && make install ) >& o.make.out
##

default:

# ... MOVING-FORWARD ... declare variables of SOURCES here
# they are mis-suffixed as *.mk (they are not GNU make)
__AUTOMAKE_FRAGMENT_FILES_being_INAPPROPRIATELY_NAMED = \
  am/archive.mk $(comment is deprecated into vernacular-doggerel) \
  am/compile.mk \
  am/distclean.mk \
  am/EXTERNAL-PATHS.mk $(comment is deprecating) \
  am/install.mk \
  $(end)
__AUTOMAKE_FRAGMENT_FILES_being_CORRECTLY_NAMED = \
  am/template.alternative-autotools-autoconf-Makefrag-inlined-on-site \
  am/autotools/autoconf/Makefrag.am \
  am/release/compile.am \
  $(end)
AUTOMAKE_FRAGMENT_FILES = \
  $(__AUTOMAKE_FRAGMENT_FILES_being_INAPPROPRIATELY_NAMED) \
  $(__AUTOMAKE_FRAGMENT_FILES_being_CORRECTLY_NAMED) \
  $(end)
GNUMAKE_FRAGMENT_FILES = \
  mk/autotools/autoconf/Makefrag.mk \
  mk/autotools/autoconf/a.Makefrag.mk \
  mk/autotools/autoconf/a.b.Makefrag.mk \
  mk/autotools/autoconf/a.b.c.Makefrag.mk \
  mk/autotools/autoconf/definitions.mk \
  mk/basic.mk \
  mk/check/eval_call_stanza.mk \
  mk/check/verbosity.mk \
  mk/compile.mk \
  mk/debugging.mk \
  mk/DISABLED-MOCK-BUILD.mk \
  mk/distclean.mk \
  mk/help2man.mk \
  mk/install.mk \
  mk/toolflags.mk \
  mk/verbosity.mk \
  $(end)
AUTOCONF_FRAGMENT_FILES = \
  ac/check-apache-httpd.m4 \
  ac/check-boost.m4 \
  ac/check-cppunit.m4 \
  ac/check-curl.m4 \
  ac/check-curlpp.m4 \
  ac/check-dc.m4 \
  ac/check-gcc.m4 \
  ac/check-half.m4 \
  ac/check-jsoncpp.m4 \
  ac/check-leveldb.m4 \
  ac/check-mysql.m4 \
  ac/check-package.m4 \
  ac/check-protoc.m4 \
  ac/check-remonstrate.m4 \
  ac/check-sqlite.m4 \
  ac/check-std-filesystem.m4 \
  ac/check-std-regex.m4 \
  ac/check-uuid.m4 \
  ac/check-yaml-cpp.m4 \
  ac/config-submodules.m4 \
  ac/enable-boost-layout.m4 \
  ac/enable-deprecation.m4 \
  ac/enable-debug.m4 \
  ac/enable-gcc.m4 \
  ac/enable-gdb.m4 \
  ac/enable-gnu.m4 \
  ac/enable-libtool-no-install.m4 \
  ac/enable-mock-build.m4 \
  ac/enable-rpm.m4 \
  ac/enable-static.m4 \
  ac/enable-verbose.m4 \
  ac/finalize.m4 \
  ac/indirect-GNUmakefrag.m4 \
  ac/init.m4 \
  ac/make-objdir.m4 \
  ac/metadirectory.m4 \
  ac/msg.m4 \
  ac/package-variables.m4 \
  ac/report-finally.m4 \
  ac/subconfigure.m4 \
  ac/notice-of.m4 \
  ac/with-herein.m4 \
  ac/with-cppunit.m4 \
  ac/with-common.m4 \
  ac/with-sibling.m4 \
  ac/with-subsystem.m4 \
  ac/with-component.m4 \
  ac/with-ambient-component.m4 \
  ac/with-hypogeal-twilight.m4 \
  ac/with-handoff.m4 \
  ac/with-incendiary-sophist.m4 \
  ac/with-module.m4 \
  ac/with-module-aliased.m4 \
  ac/with-nonstd.m4 \
  ac/with-rpmbuild-handoff.m4 \
  ac/with-std.m4 \
  ac/with-vernacular-doggerel.m4 \
  $(end)
BUILDCONF_TEMPLATE_FILES = \
  bc/template.autotools-style-buildconf \
  bc/template.boilerplate-style-buildconf \
  $(end)
LIBRARY_FILES = \
  lib/config.settings.function-library \
  $(end)
LIBEXEC_FILES = \
  libexec/autotools-local-preconfigure \
  libexec/boilerplate-simplistic-configure-for-untooled-packages \
  libexec/establish-config-settings \
  libexec/extract-rpm-specfile-value \
  libexec/generate-autotools-Config-module-from-config-header \
  libexec/insert-config-settings-in-configure \
  $(end)

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

distclean: distclean-configured
distclean-configured:
	rm -f mk/configured.mk
include ./mk/configured.mk # was created by ./configure
# establishes the $(prefix) $(hypogeal_twilight_datarootdir)
__perhaps = - perhaps you missed the steps: ./buildconf ./configure))
$(if $(prefix),$(__ok),$(error prefix is undefined $(__perhaps)))
$(if $(hypogeal_twilight_datarootdir),$(__ok),$(error hypogeal_twilight_datarootdir is undefined $(__perhaps)))
# MIGHT establish $(vernacular_doggerel_prefix) configured --without-vernacular-doggerel
$(if $(vernacular_doggerel_datarootdir),$(__ok),$(info notice: vernacular_doggerel_datarootdir is undefined, it was not defined in ./mk/configured.mk $(__perhaps)))

# theory https://fedoraproject.org/wiki/Packaging:RPMMacros?rd=Packaging/RPMMacros
# reminder: DESTDIR is non-empty in an rpmbuild environment
#           DESTDIR is already in $(prefix) from mk/configure.mk
bindir = $(prefix)/bindir
includedir = $(prefix)/include
modulesdir = $(prefix)/modules
libexecdir = $(prefix)/libexec
datarootdir = $(prefix)/share
datadir = $(datarootdir)
pkglibdir = $(prefix)/lib/hypogeal-twilight
pkglibexecdir = $(prefix)/libexec/hypogeal-twilight
pkgdatarootdir = $(prefix)/share/hypogeal-twilight
pkgdatadir = $(pkgdatarootdir)

dot.CHECKED = .checked
distclean realclean: distclean-dot.CHECKED
distclean-dot.CHECKED:
	rm -rf $(dot.CHECKED)

CHECKABLE_BASH_SOURCES = \
  libexec/autotools-local-preconfigure \
  libexec/boilerplate-simplistic-configure-for-untooled-packages \
  lib/config.settings.function-library \
  bc/template.autotools-style-buildconf \
  bc/template.boilerplate-style-buildconf \
  $(end)
all: $(CHECKABLE_BASH_SOURCES)
CHECKED_BASH_SEMAPHORES = $(addprefix $(dot.CHECKED)/,$(CHECKABLE_BASH_SOURCES))
check: check-CHECKED_BASH_SEMAPHORES
check-CHECKED_BASH_SEMAPHORES: $(CHECKED_BASH_SEMAPHORES)
check-basics: check-CHECKED_BASH_SEMAPHORES
clean: clean-CHECKED-BASH-SEMAPHORES
clean-CHECKED-BASH-SEMAPHORES:
	rm -f $(CHECKED_BASH_SEMAPHORES)
$(CHECKED_BASH_SEMAPHORES) : $(dot.CHECKED)/% : %
	mkdir -p $(@D)
	bash -n $<
	touch $@

CHECKABLE_PERL_SOURCES = \
  libexec/establish-config-settings \
  libexec/generate-autotools-Config-module-from-config-header \
  libexec/insert-config-settings-in-configure \
  $(end)
all: $(CHECKABLE_PERL_SOURCES)
CHECKED_PERL_SEMAPHORES = $(addprefix $(dot.CHECKED)/,$(CHECKABLE_PERL_SOURCES))
check: check-CHECKED_PERL_SEMAPHORES
check-CHECKED_PERL_SEMAPHORES: $(CHECKED_PERL_SEMAPHORES)
check-basics: check-CHECKED_PERL_SEMAPHORES
clean: clean-CHECKED_PERL_SEMAPHORES
clean-CHECKED_PERL_SEMAPHORES:
	rm -f $(CHECKED_PERL_SEMAPHORES)
$(CHECKED_PERL_SEMAPHORES) : $(dot.CHECKED)/% : %
	mkdir -p $(@D)
	perl -c $<
	touch $@

MODULE_FILES = $(wildcard modules/autotools.*[^~])
INSTALLED_MODULE_FILES = $(patsubst modules/%,$(modulesdir)/%, $(MODULE_FILES))
install: $(INSTALLED_MODULE_FILES)
$(INSTALLED_MODULE_FILES) : $(modulesdir)/% : modules/%
	install -D -c -m 444 $< $@

INSTALLED_LIBRARY_FILES = \
  $(addprefix $(pkglibdir)/, \
              $(notdir \
                $(LIBRARY_FILES))) \
  $(end)
install: $(INSTALLED_LIBRARY_FILES)
$(INSTALLED_LIBRARY_FILES) : $(pkglibdir)/% : lib/%
	install -D -c -m 444 $< $@

INSTALLED_LIBEXEC_FILES = \
  $(addprefix $(pkglibexecdir)/, \
              $(notdir \
                $(LIBEXEC_FILES))) \
  $(end)
install: $(INSTALLED_LIBEXEC_FILES)
$(INSTALLED_LIBEXEC_FILES) : $(pkglibexecdir)/% : libexec/%
	install -D -c -m 555 $< $@

INSTALLED_AUTOMAKE_FRAGMENT_FILES = $(patsubst am/%,$(pkgdatadir)/am/%, $(AUTOMAKE_FRAGMENT_FILES))
install: $(INSTALLED_AUTOMAKE_FRAGMENT_FILES)
$(INSTALLED_AUTOMAKE_FRAGMENT_FILES) : $(pkgdatadir)/am/% : am/%
	install -D -c -m 444 $< $@

INSTALLED_GNUMAKE_FRAGMENT_FILES = $(patsubst mk/%,$(pkgdatadir)/mk/%, $(GNUMAKE_FRAGMENT_FILES))
install: $(INSTALLED_GNUMAKE_FRAGMENT_FILES)
$(INSTALLED_GNUMAKE_FRAGMENT_FILES) : $(pkgdatadir)/mk/% : mk/%
	install -D -c -m 444 $< $@

INSTALLED_AUTOCONF_FRAGMENT_FILES = $(patsubst ac/%,$(pkgdatadir)/ac/%, $(AUTOCONF_FRAGMENT_FILES))
install: $(INSTALLED_AUTOCONF_FRAGMENT_FILES)
$(INSTALLED_AUTOCONF_FRAGMENT_FILES) : $(pkgdatadir)/ac/% : ac/%
	install -D -c -m 444 $< $@

INSTALLED_BUILDCONF_TEMPLATE_FILES = $(patsubst bc/%,$(pkgdatadir)/bc/%, $(BUILDCONF_TEMPLATE_FILES))
install: $(INSTALLED_BUILDCONF_TEMPLATE_FILES)
$(INSTALLED_BUILDCONF_TEMPLATE_FILES) : $(pkgdatadir)/bc/% : bc/%
	install -D -c -m 444 $< $@

# tests -----------------------------------------------------------------------------------------------

AC_TESTS = \
  tests/ac/HGTW_WITH_COMMON/run.test \
  tests/ac/HGTW_WITH_HEREIN/run.test \
  tests/ac/HGTW_WITH_USR_LOCAL/run.test \
  tests/ac/HGTW_PROG_DC/run.test \
  tests/ac/AC_INIT/run.test \
  tests/ac/HGTW_AMBIENT_COMPONENT_SEARCHPATH/run.test \
  tests/ac/HGTW_APPEND_SUBCONFIGURE_ARGUMENT/run.test \
  tests/ac/HGTW_CHECK_APACHE_HTTPD/run.test \
  tests/ac/HGTW_CHECK_BOOST_LAYOUT/run.test \
  tests/ac/HGTW_CHECK_BOOST/run.test \
  tests/ac/HGTW_CHECK_CPPUNIT/run.test \
  tests/ac/HGTW_CHECK_CURLPP/run.test \
  tests/ac/HGTW_CHECK_CURL/run.test \
  tests/ac/HGTW_CHECK_DC/run.test \
  tests/ac/HGTW_CHECK_GCC/run.test \
  tests/ac/HGTW_CHECK_HALF/run.test \
  tests/ac/HGTW_CHECK_JSONCPP/run.test \
  tests/ac/HGTW_CHECK_LEVELDB/run.test \
  tests/ac/HGTW_CHECK_MARIADB/run.test \
  tests/ac/HGTW_CHECK_MYSQLPP/run.test \
  tests/ac/HGTW_CHECK_MYSQL/run.test \
  tests/ac/HGTW_CHECK_PACKAGE/run.test \
  tests/ac/HGTW_CHECK_PACKAGES/run.test \
  tests/ac/HGTW_CHECK_PACKAGES_WARN/run.test \
  tests/ac/HGTW_CHECK_PACKAGES_WARNING/run.test \
  tests/ac/HGTW_CHECK_PACKAGES_ERROR/run.test \
  tests/ac/HGTW_CHECK_PROTOC/run.test \
  tests/ac/HGTW_CHECK_REMONSTRATE/run.test \
  tests/ac/HGTW_CHECK_SQLITE/run.test \
  tests/ac/HGTW_CHECK_STD_FILESYSTEM/run.test \
  tests/ac/HGTW_CHECK_STD_REGEX/run.test \
  tests/ac/HGTW_CHECK_UUID/run.test \
  tests/ac/HGTW_COMPONENT_METADIRECTORY_TIERS/run.test \
  tests/ac/HGTW_CONFIG_SUBMODULES/run.test \
  tests/ac/HGTW_DEFAULT_STD_VALUES/run.test \
  tests/ac/HGTW_ENABLE_BOOST_LAYOUT/run.test \
  tests/ac/HGTW_ENABLE_CONFIGURE_DEBUG/run.test \
  tests/ac/HGTW_ENABLE_CONFIGURE_VERBOSE/run.test \
  tests/ac/HGTW_ENABLE_DEPRECATION_NOTIFICATION/run.test \
  tests/ac/HGTW_ENABLE_GCC/run.test \
  tests/ac/HGTW_ENABLE_GDB/run.test \
  tests/ac/HGTW_ENABLE_GNU/run.test \
  tests/ac/HGTW_ENABLE_LIBTOOL_NO_INSTALL/run.test \
  tests/ac/HGTW_ENABLE_MOCK_BUILD/run.test \
  tests/ac/HGTW_ENABLE_RPM_PACKAGE_CHECKING/run.test \
  tests/ac/HGTW_ENABLE_STATIC_EXECUTABLES/run.test \
  tests/ac/HGTW_FINALIZE_CONFIGURED/run.test \
  tests/ac/HGTW_FINALIZE/run.test \
  tests/ac/HGTW_INIT/run.test \
  tests/ac/HGTW_MSG_DEBUG/run.test \
  tests/ac/HGTW_MSG_DEPRECATED/run.test \
  tests/ac/HGTW_MSG_ERROR/run.test \
  tests/ac/HGTW_MSG_NOTICE/run.test \
  tests/ac/HGTW_MSG_VERBOSE/run.test \
  tests/ac/HGTW_MSG_WARNING/run.test \
  tests/ac/HGTW_MSG_WARN/run.test \
  tests/ac/HGTW_OUTPUT/run.test \
  tests/ac/HGTW_PACKAGE_VARIABLES/run.test \
  tests/ac/HGTW_PROG_DC/run.test \
  tests/ac/HGTW_REPORT_FINALIZE/run.test \
  tests/ac/HGTW_WITH_ALIASED_MODULE/run.test \
  tests/ac/HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST/run.test \
  tests/ac/HGTW_WITH_AMBIENT_COMPONENT/run.test \
  tests/ac/HGTW_WITH_AMBIENT_COMPONENT_WITHIN/run.test \
  tests/ac/HGTW_WITH_ANGUISH_ANSWER/run.test \
  tests/ac/HGTW_WITH_BALEFUL_BALLAD/run.test \
  tests/ac/HGTW_WITH_BOOST_LAYOUT/run.test \
  tests/ac/HGTW_WITH_COMMON/run.test \
  tests/ac/HGTW_WITH_COMPONENT/run.test \
  tests/ac/HGTW_WITH_HEREIN/run.test \
  tests/ac/HGTW_WITH_HYPOGEAL_TWILIGHT/run.test \
  tests/ac/HGTW_WITH_INCENDIARY_SOPHIST/run.test \
  tests/ac/HGTW_WITH_META_DIRECTORY/run.test \
  tests/ac/HGTW_WITH_MODULE_ALIASED/run.test \
  tests/ac/HGTW_WITH_MODULE/run.test \
  tests/ac/HGTW_WITH_NONSTD_BOOST/run.test \
  tests/ac/HGTW_WITH_NONSTD_CPPUNIT/run.test \
  tests/ac/HGTW_WITH_NONSTD_CURLPP/run.test \
  tests/ac/HGTW_WITH_NONSTD_CURL/run.test \
  tests/ac/HGTW_WITH_NONSTD_GCC/run.test \
  tests/ac/HGTW_WITH_NONSTD_HALF/run.test \
  tests/ac/HGTW_WITH_NONSTD_JSONCPP/run.test \
  tests/ac/HGTW_WITH_NONSTD_LEVELDB/run.test \
  tests/ac/HGTW_WITH_NONSTD_LIBHTTPSERVER/run.test \
  tests/ac/HGTW_WITH_NONSTD_MYSQLPP/run.test \
  tests/ac/HGTW_WITH_NONSTD_MYSQL/run.test \
  tests/ac/HGTW_WITH_NONSTD/run.test \
  tests/ac/HGTW_WITH_NONSTD_SQLITE/run.test \
  tests/ac/HGTW_WITH_NONSTD_UUID/run.test \
  tests/ac/HGTW_WITH_SIBLING/run.test \
  tests/ac/HGTW_WITH_STD_FILESYSTEM/run.test \
  tests/ac/HGTW_WITH_STD_REGEX/run.test \
  tests/ac/HGTW_WITH_STD/run.test \
  tests/ac/HGTW_WITH_STD_SCOLD/run.test \
  tests/ac/HGTW_WITH_SUBSYSTEM/run.test \
  tests/ac/HGTW_WITH_USR_LOCAL/run.test \
  tests/ac/HGTW_WITH_VERNACULAR_DOGGEREL/run.test \
  tests/ac/SCOLD_AMBIENT_COMPONENT_SEARCHPATH/run.test \
  tests/ac/SCOLD_CHECK_APACHE_HTTPD/run.test \
  tests/ac/SCOLD_CHECK_BOOST_LAYOUT/run.test \
  tests/ac/SCOLD_CHECK_BOOST/run.test \
  tests/ac/SCOLD_CHECK_CPPUNIT/run.test \
  tests/ac/SCOLD_CHECK_CURLPP/run.test \
  tests/ac/SCOLD_CHECK_CURL/run.test \
  tests/ac/SCOLD_CHECK_GCC/run.test \
  tests/ac/SCOLD_CHECK_JSONCPP/run.test \
  tests/ac/SCOLD_CHECK_JSON/run.test \
  tests/ac/SCOLD_CHECK_LEVELDB/run.test \
  tests/ac/SCOLD_CHECK_MARIADB/run.test \
  tests/ac/SCOLD_CHECK_MYSQLPP/run.test \
  tests/ac/SCOLD_CHECK_MYSQL/run.test \
  tests/ac/SCOLD_CHECK_REMONSTRATE/run.test \
  tests/ac/SCOLD_CHECK_SQLITE/run.test \
  tests/ac/SCOLD_CHECK_STD_FILESYSTEM/run.test \
  tests/ac/SCOLD_CHECK_UUID/run.test \
  tests/ac/SCOLD_COMPONENT_METADIRECTORY_TIERS/run.test \
  tests/ac/SCOLD_CONFIG_SUBMODULES/run.test \
  tests/ac/SCOLD_DEFAULT_STD_VALUES/run.test \
  tests/ac/SCOLD_ENABLE_BOOST_LAYOUT/run.test \
  tests/ac/SCOLD_ENABLE_CONFIGURE_DEBUG/run.test \
  tests/ac/SCOLD_ENABLE_CONFIGURE_VERBOSE/run.test \
  tests/ac/SCOLD_ENABLE_DEPRECATION_NOTIFICATION/run.test \
  tests/ac/SCOLD_ENABLE_GCC/run.test \
  tests/ac/SCOLD_ENABLE_GDB/run.test \
  tests/ac/SCOLD_ENABLE_GNU/run.test \
  tests/ac/SCOLD_ENABLE_MOCK_BUILD/run.test \
  tests/ac/SCOLD_ENABLE_RPM_PACKAGE_CHECKING/run.test \
  tests/ac/SCOLD_FINALIZE/run.test \
  tests/ac/SCOLD_INDIRECT_GNUmakefrag_FILES/run.test \
  tests/ac/SCOLD_INDIRECT_GNUmakefrag/run.test \
  tests/ac/SCOLD_INIT/run.test \
  tests/ac/SCOLD_MAKE_OBJ_DIRECTORIES/run.test \
  tests/ac/SCOLD_MOCK_BUILD/run.test \
  tests/ac/SCOLD_MSG_DEBUG/run.test \
  tests/ac/SCOLD_MSG_DEPRECATED/run.test \
  tests/ac/SCOLD_MSG_VERBOSE/run.test \
  tests/ac/SCOLD_OUTPUT/run.test \
  tests/ac/SCOLD_PACKAGE_VARIABLES/run.test \
  tests/ac/SCOLD_REPORT_FINALLY/run.test \
  tests/ac/SCOLD_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST/run.test \
  tests/ac/SCOLD_WITH_AMBIENT_COMPONENT/run.test \
  tests/ac/SCOLD_WITH_AMBIENT_COMPONENT_WITHIN/run.test \
  tests/ac/SCOLD_WITH_BOOST_LAYOUT/run.test \
  tests/ac/SCOLD_WITH_COMMON/run.test \
  tests/ac/SCOLD_WITH_COMPONENT/run.test \
  tests/ac/SCOLD_WITH_HEREIN/run.test \
  tests/ac/SCOLD_WITH_HYPOGEAL_TWILIGHT/run.test \
  tests/ac/SCOLD_WITH_INCENDIARY_SOPHIST/run.test \
  tests/ac/SCOLD_WITH_META_DIRECTORY/run.test \
  tests/ac/SCOLD_WITH_MODULE/run.test \
  tests/ac/SCOLD_WITH_NONSTD_BOOST/run.test \
  tests/ac/SCOLD_WITH_NONSTD_CPPUNIT/run.test \
  tests/ac/SCOLD_WITH_NONSTD_CURLPP/run.test \
  tests/ac/SCOLD_WITH_NONSTD_CURL/run.test \
  tests/ac/SCOLD_WITH_NONSTD_GCC/run.test \
  tests/ac/SCOLD_WITH_NONSTD_JSONCPP/run.test \
  tests/ac/SCOLD_WITH_NONSTD_LEVELDB/run.test \
  tests/ac/SCOLD_WITH_NONSTD_MYSQLPP/run.test \
  tests/ac/SCOLD_WITH_NONSTD_MYSQL/run.test \
  tests/ac/SCOLD_WITH_NONSTD/run.test \
  tests/ac/SCOLD_WITH_NONSTD_SQLITE/run.test \
  tests/ac/SCOLD_WITH_NONSTD_UUID/run.test \
  tests/ac/SCOLD_WITH_SIBLING/run.test \
  tests/ac/SCOLD_WITH_STD_FILESYSTEM/run.test \
  tests/ac/SCOLD_WITH_STD_REGEX/run.test \
  tests/ac/SCOLD_WITH_STD/run.test \
  tests/ac/SCOLD_WITH_SUBSYSTEM/run.test \
  tests/ac/SCOLD_WITH_VERNACULAR_DOGGEREL/run.test \
  $(end)

CONFIGURE_TESTS = \
  tests/configure/no-options.test \
  tests/configure/help.test \
  tests/configure/usage.test \
  tests/configure/without-hypogeal-twilight.test \
  tests/configure/without-incendiary-sophist.test \
  tests/configure/without-nonstd-boost.test \
  tests/configure/without-nonstd-curlpp.test \
  tests/configure/without-nonstd-curl.test \
  tests/configure/without-nonstd-gcc.test \
  tests/configure/without-nonstd-jsoncpp.test \
  tests/configure/without-nonstd-mysql.test \
  tests/configure/without-nonstd-mysql++.test \
  tests/configure/without-nonstd-sqlite.test \
  tests/configure/without-SOME-TOOLCHAIN-THING.test \
  tests/configure/without-vernacular-doggerel.test \
  tests/configure/enable-rpm-package-checking.test \
  tests/configure/disable-rpm-package-checking.test \
  $(end)

# WATCHOUT - these tests require many gratuitous rpm packages to be installed.
# as such, running these tests during rpmbuilds is contraindicated.
DEFUNS_HGTW_TESTS = \
  tests/defuns-hgtw/run.test \
  $(end)

DEFUNS_SCOLD_TESTS = \
  tests/defuns-scold/run.test \
  $(end)

UNIT_TESTS_boilerplate = \
  tests/unit/boilerplate/autoconf-compatibility.test \
  tests/unit/boilerplate/avoid-hypogeal-twilight.test \
  tests/unit/boilerplate/avoid-vernacular-doggerel.test \
  tests/unit/boilerplate/cache-file.test \
  tests/unit/boilerplate/dash_dash_more.test \
  tests/unit/boilerplate/dash_dash.test \
  tests/unit/boilerplate/debug-mode.test \
  tests/unit/boilerplate/debug.test \
  tests/unit/boilerplate/define-package-spec-file_empty.test \
  tests/unit/boilerplate/define-package-spec-file_nonexistent.test \
  tests/unit/boilerplate/define-package-spec-file.test \
  tests/unit/boilerplate/define-package-specfile.test \
  tests/unit/boilerplate/define-specfile.test \
  tests/unit/boilerplate/disable-configure-debug.test \
  tests/unit/boilerplate/disable-configure-verbose.test \
  tests/unit/boilerplate/disable-package-spec-file.test \
  tests/unit/boilerplate/disable-something_1.test \
  tests/unit/boilerplate/disable-something_2.test \
  tests/unit/boilerplate/disable-something_0.test \
  tests/unit/boilerplate/disable-specfile.test \
  tests/unit/boilerplate/disuse-hypogeal-twilight.test \
  tests/unit/boilerplate/disuse-vernacular-doggerel.test \
  tests/unit/boilerplate/dry-run-mode.test \
  tests/unit/boilerplate/dryrun-mode.test \
  tests/unit/boilerplate/dry-run.test \
  tests/unit/boilerplate/dryrun.test \
  tests/unit/boilerplate/empty.test \
  tests/unit/boilerplate/enable-configure-debug.test \
  tests/unit/boilerplate/enable-configure-verbose.test \
  tests/unit/boilerplate/enable-package-spec-file.test \
  tests/unit/boilerplate/enable-package-specfile.test \
  tests/unit/boilerplate/enable-something_1.test \
  tests/unit/boilerplate/enable-something_2.test \
  tests/unit/boilerplate/enable-specfile.test \
  tests/unit/boilerplate/h.test \
  tests/unit/boilerplate/hypogeal-twilight.test \
  tests/unit/boilerplate/ignore-hypogeal-twilight.test \
  tests/unit/boilerplate/ignore-vernacular-doggerel.test \
  tests/unit/boilerplate/mock_cfg_name.test \
  tests/unit/boilerplate/mock-cfg-name.test \
  tests/unit/boilerplate/mock_git_branch.test \
  tests/unit/boilerplate/mock-git-branch.test \
  tests/unit/boilerplate/much_1.test \
  tests/unit/boilerplate/much_2.test \
  tests/unit/boilerplate/package_spec_1.test \
  tests/unit/boilerplate/package_spec_2.test \
  tests/unit/boilerplate/package_spec_3.test \
  tests/unit/boilerplate/prefix_empty.test \
  tests/unit/boilerplate/prefix_nonexistent.test \
  tests/unit/boilerplate/prefix.test \
  tests/unit/boilerplate/rpm_spec_file.test \
  tests/unit/boilerplate/rpm-spec-file.test \
  tests/unit/boilerplate/spec_file_1.test \
  tests/unit/boilerplate/spec_file_2.test \
  tests/unit/boilerplate/spec_file_3.test \
  tests/unit/boilerplate/specfile.test \
  tests/unit/boilerplate/srcdir.test \
  tests/unit/boilerplate/undefine-package-spec-file.test \
  tests/unit/boilerplate/undefine-spec-file.test \
  tests/unit/boilerplate/undefine-specfile.test \
  tests/unit/boilerplate/undef-package-spec-file.test \
  tests/unit/boilerplate/undef-spec-file.test \
  tests/unit/boilerplate/undef-specfile.test \
  tests/unit/boilerplate/usage.test \
  tests/unit/boilerplate/use-hypogeal-twilight.test \
  tests/unit/boilerplate/use-vernacular-doggerel.test \
  tests/unit/boilerplate/using-hypogeal-twilight.test \
  tests/unit/boilerplate/using-vernacular-doggerel.test \
  tests/unit/boilerplate/verbose-mode.test \
  tests/unit/boilerplate/verbose.test \
  tests/unit/boilerplate/vernacular-doggerel.test \
  tests/unit/boilerplate/version.test \
  tests/unit/boilerplate/V.test \
  tests/unit/boilerplate/with-hypogeal-twilight_empty.test \
  tests/unit/boilerplate/with-hypogeal-twilight_nonexistent.test \
  tests/unit/boilerplate/with-hypogeal_twilight.test \
  tests/unit/boilerplate/with-hypogeal-twilight.test \
  tests/unit/boilerplate/with-nonstd_empty.test \
  tests/unit/boilerplate/with-nonstd-gcc_empty.test \
  tests/unit/boilerplate/with-nonstd-gcc_nonexistent.test \
  tests/unit/boilerplate/with-nonstd-gcc.test \
  tests/unit/boilerplate/without-hypogeal_twilight.test \
  tests/unit/boilerplate/without-hypogeal-twilight.test \
  tests/unit/boilerplate/without-something_1.test \
  tests/unit/boilerplate/without-something_2.test \
  tests/unit/boilerplate/without-something_0.test \
  tests/unit/boilerplate/without-vernacular_doggerel.test \
  tests/unit/boilerplate/without-vernacular-doggerel.test \
  tests/unit/boilerplate/with-something_1.test \
  tests/unit/boilerplate/with-something_2.test \
  tests/unit/boilerplate/with-std-scold.test \
  tests/unit/boilerplate/with-vernacular-doggerel_empty.test \
  tests/unit/boilerplate/with-vernacular-doggerel_nonexistent.test \
  tests/unit/boilerplate/with-vernacular_doggerel.test \
  tests/unit/boilerplate/with-vernacular-doggerel.test \
  tests/unit/boilerplate/good_0.test \
  tests/unit/boilerplate/good_1.test \
  tests/unit/boilerplate/good_2.test \
  tests/unit/boilerplate/good_3.test \
  $(end)

UNIT_TESTS_preconfigure = \
  tests/unit/preconfigure/minusI_case-01.test \
  tests/unit/preconfigure/minusI_case-02.test \
  tests/unit/preconfigure/minusI_case-03.test \
  tests/unit/preconfigure/minusI_case-04.test \
  tests/unit/preconfigure/include_case-01.test \
  tests/unit/preconfigure/include_case-02.test \
  tests/unit/preconfigure/include_case-03.test \
  tests/unit/preconfigure/aclocal_case-01.test \
  tests/unit/preconfigure/aclocal_case-02.test \
  tests/unit/preconfigure/autoconf_case-01.test \
  tests/unit/preconfigure/autoconf_case-02.test \
  tests/unit/preconfigure/system-acdir.test \
  tests/unit/preconfigure/system-acdir_case-01.test \
  tests/unit/preconfigure/system-acdir_case-02.test \
  tests/unit/preconfigure/automake-acdir.test \
  tests/unit/preconfigure/is-recursive.test \
  tests/unit/preconfigure/recursive.test \
  tests/unit/preconfigure/is-toplevel.test \
  tests/unit/preconfigure/is-top-level.test \
  tests/unit/preconfigure/is-top_level.test \
  tests/unit/preconfigure/toplevel.test \
  tests/unit/preconfigure/top-level.test \
  tests/unit/preconfigure/top_level.test \
  tests/unit/preconfigure/version.test \
  tests/unit/preconfigure/V.test \
  tests/unit/preconfigure/usage.test \
  tests/unit/preconfigure/help.test \
  tests/unit/preconfigure/h.test \
  tests/unit/preconfigure/quiet.test \
  tests/unit/preconfigure/q.test \
  tests/unit/preconfigure/verbose.test \
  tests/unit/preconfigure/v.test \
  tests/unit/preconfigure/dryrun.test \
  tests/unit/preconfigure/dry-run.test \
  tests/unit/preconfigure/extra_case-01.test \
  tests/unit/preconfigure/extra_case-02.test \
  tests/unit/preconfigure/extra_case-03.test \
  $(end)

UNIT_TESTS = \
  $(UNIT_TESTS_boilerplate) \
  tests/unit/establish/usage.test \
  tests/unit/establish/version.test \
  tests/unit/generate/usage.test \
  tests/unit/generate/version.test \
  tests/unit/insert/usage.test \
  tests/unit/insert/version.test \
  $(UNIT_TESTS_preconfigure) \
  $(end)

include mk/check/eval_call_stanza.mk
$(eval $(call check_make_stanza, tests/autotools))
check-tests/case-01: test_Makefile=driver.Makefile
$(eval $(call check_make_stanza, tests/case-01))
check-tests/case-02: test_Makefile=driver.Makefile
$(eval $(call check_make_stanza, tests/case-02))
$(eval $(call check_driver_stanza, tests/configure, $(CONFIGURE_TESTS)))
$(eval $(call check_driver_stanza, tests/defuns-scold, $(DEFUNS_SCOLD_TESTS)))
$(eval $(call check_driver_stanza, tests/defuns-hgtw, $(DEFUNS_HGTW_TESTS)))
$(eval $(call check_driver_stanza, tests/preconfigure, $(PRECONFIGURE_TESTS)))
$(eval $(call check_driver_stanza, tests/unit, $(UNIT_TESTS)))

# these are long in the tooth so they go last
$(eval $(call check_driver_stanza, tests/ac, $(AC_TESTS)))

# self-checks ----------------------------------------------------------------------------------------------------

__NOMINATE_AUTOMAKE_FRAGMENT_FILES = AUTOMAKE_FRAGMENT_FILES
__DECLARED_AUTOMAKE_FRAGMENT_FILES = $($(__NOMINATE_AUTOMAKE_FRAGMENT_FILES))
__OBSERVED_AUTOMAKE_FRAGMENT_FILES = $(foreach ss, mk am, $(wildcard am/*.$(ss) am/*/*.$(ss) am/*/*/*.$(ss) am/*/*/*/*.$(ss) am/*/*/*/*/*.$(ss)))
__UNLISTED_AUTOMAKE_FRAGMENT_FILES = \
  $(filter-out $(__DECLARED_AUTOMAKE_FRAGMENT_FILES), \
               $(__OBSERVED_AUTOMAKE_FRAGMENT_FILES))
$(if $(__UNLISTED_AUTOMAKE_FRAGMENT_FILES), \
     $(error the variable $(__NOMINATE_AUTOMAKE_FRAGMENT_FILES) does not list $(__UNLISTED_AUTOMAKE_FRAGMENT_FILES)))

__NOMINATE_GNUMAKE_UNINSTALLABLE_FILES = GNUMAKE_FRAGMENT_FILES
__DECLARED_GNUMAKE_UNINSTALLABLE_FILES = \
  mk/buildconfed.mk \
  mk/configured.mk \
  mk/extracted.base.mk \
  mk/extracted.check.mk \
  mk/extracted.mk \
  $(end)
# these files are to be observed not in the filesystem, but in a list of installable entities (do not install these)
__OBSERVED_GNUMAKE_UNINSTALLABLE_FILES = $(GNUMAKE_FRAGMENT_FILES)
__RESERVED_GNUMAKE_UNINSTALLABLE_FILES = \
  $(filter $(__DECLARED_GNUMAKE_UNINSTALLABLE_FILES), \
           $(__OBSERVED_GNUMAKE_UNINSTALLABLE_FILES))
$(if $(__RESERVED_GNUMAKE_UNINSTALLABLE_FILES), \
     $(error the variable $(__NOMINATE_GNUMAKE_UNINSTALLABLE_FILES) must not contain $(__RESERVED_GNUMAKE_UNINSTALLABLE_FILES)))

__NOMINATE_GNUMAKE_INSTALLABLE_FILES = GNUMAKE_FRAGMENT_FILES
__DECLARED_GNUMAKE_INSTALLABLE_FILES = $($(__NOMINATE_GNUMAKE_INSTALLABLE_FILES))
__OBSERVED_GNUMAKE_INSTALLABLE_FILES = $(wildcard mk/*.mk mk/*/*.mk mk/*/*/*.mk mk/*/*/*/*.mk mk/*/*/*/*/*.mk mk/*/*/*/*/*/*.mk)
__UNLISTED_GNUMAKE_INSTALLABLE_FILES = \
  $(filter-out $(__DECLARED_GNUMAKE_INSTALLABLE_FILES) $(__DECLARED_GNUMAKE_UNINSTALLABLE_FILES) $(wildcard mk/j99.* mk/*/j99.*), \
               $(__OBSERVED_GNUMAKE_INSTALLABLE_FILES))
$(if $(__UNLISTED_GNUMAKE_INSTALLABLE_FILES), \
     $(error the variable $(__NOMINATE_GNUMAKE_INSTALLABLE_FILES) does not list $(__UNLISTED_GNUMAKE_INSTALLABLE_FILES)))

__NOMINATE_AUTOCONF_FRAGMENT_FILES = AUTOCONF_FRAGMENT_FILES
__DECLARED_AUTOCONF_FRAGMENT_FILES = $($(__NOMINATE_AUTOCONF_FRAGMENT_FILES))
__OBSERVED_AUTOCONF_FRAGMENT_FILES = $(wildcard ac/*.m4)
__UNLISTED_AUTOCONF_FRAGMENT_FILES = \
  $(filter-out $(__DECLARED_AUTOCONF_FRAGMENT_FILES) $(wildcard ac/j99.*), \
               $(__OBSERVED_AUTOCONF_FRAGMENT_FILES))
$(if $(__UNLISTED_AUTOCONF_FRAGMENT_FILES), \
     $(error the variable $(__NOMINATE_AUTOCONF_FRAGMENT_FILES) does not list $(__UNLISTED_AUTOCONF_FRAGMENT_FILES)))

__NOMINATE_BUILDCONF_TEMPLATE_FILES = BUILDCONF_TEMPLATE_FILES
__DECLARED_BUILDCONF_TEMPLATE_FILES = $($(__NOMINATE_BUILDCONF_TEMPLATE_FILES))
__OBSERVED_BUILDCONF_TEMPLATE_FILES = $(wildcard bc/*[^~])
__UNLISTED_BUILDCONF_TEMPLATE_FILES = \
  $(filter-out $(__DECLARED_BUILDCONF_TEMPLATE_FILES) $(wildcard bc/j99.*), \
               $(__OBSERVED_BUILDCONF_TEMPLATE_FILES))
$(if $(__UNLISTED_BUILDCONF_TEMPLATE_FILES), \
     $(error the variable $(__NOMINATE_BUILDCONF_TEMPLATE_FILES) does not list $(__UNLISTED_BUILDCONF_TEMPLATE_FILES)))

__NOMINATE_LIBRARY_FILES = LIBRARY_FILES
__DECLARED_LIBRARY_FILES = $($(__NOMINATE_LIBRARY_FILES))
__OBSERVED_LIBRARY_FILES = $(wildcard lib/*[^~]) 
__UNLISTED_LIBRARY_FILES = \
  $(filter-out $(__DECLARED_LIBRARY_FILES) $(wildcard lib/j99.*), \
               $(__OBSERVED_LIBRARY_FILES))
$(if $(__UNLISTED_LIBRARY_FILES), \
     $(error the variable $(__NOMINATE_LIBRARY_FILES) does not list $(__UNLISTED_LIBRARY_FILES)))

__NOMINATE_LIBEXEC_FILES = LIBEXEC_FILES
__DECLARED_LIBEXEC_FILES = $($(__NOMINATE_LIBEXEC_FILES))
__OBSERVED_LIBEXEC_FILES = $(wildcard libexec/*[^~])
__UNLISTED_LIBEXEC_FILES = \
  $(filter-out $(__DECLARED_LIBEXEC_FILES) $(wildcard libexec/j99.*), \
               $(__OBSERVED_LIBEXEC_FILES))
$(if $(__UNLISTED_LIBEXEC_FILES), \
     $(error the variable $(__NOMINATE_LIBEXEC_FILES) does not list $(__UNLISTED_LIBEXEC_FILES)))

# begin duplicate ... see defines

__NOMINATE_AC_TEST_FILES = AC_TESTS
__DECLARED_AC_TEST_FILES = $($(__NOMINATE_AC_TEST_FILES))
__OBSERVED_AC_TEST_FILES = $(wildcard tests/ac/run.test)
__UNLISTED_AC_TEST_FILES = \
  $(filter-out $(__DECLARED_AC_TEST_FILES), \
               $(__OBSERVED_AC_TEST_FILES))
$(if $(__UNLISTED_AC_TEST_FILES), \
     $(error the variable $(__NOMINATE_AC_TEST_FILES) does not list $(__UNLISTED_AC_TEST_FILES)))
# end ---

__NOMINATE_CONFIGURE_TEST_FILES = CONFIGURE_TESTS
__DECLARED_CONFIGURE_TEST_FILES = $($(__NOMINATE_CONFIGURE_TEST_FILES))
__OBSERVED_CONFIGURE_TEST_FILES = \
  $(wildcard \
    $(addprefix tests/configure/, \
                $(addsuffix /*.test, \
                            * */* */*/*))) \
  $(end)
__UNLISTED_CONFIGURE_TEST_FILES = \
  $(filter-out $(__DECLARED_CONFIGURE_TEST_FILES), \
               $(__OBSERVED_CONFIGURE_TEST_FILES))
$(if $(__UNLISTED_CONFIGURE_TEST_FILES), \
     $(error the variable $(__NOMINATE_CONFIGURE_TEST_FILES) does not list $(__UNLISTED_CONFIGURE_TEST_FILES)))
# end ---

__NOMINATE_UNIT_TEST_FILES = UNIT_TESTS
__DECLARED_UNIT_TEST_FILES = $($(__NOMINATE_UNIT_TEST_FILES))
__OBSERVED_UNIT_TEST_FILES = \
  $(wildcard \
    $(addprefix tests/unit/, \
                $(addsuffix /*.test, \
                            * */* */*/*))) \
  $(end)
__UNLISTED_UNIT_TEST_FILES = \
  $(filter-out $(__DECLARED_UNIT_TEST_FILES), \
               $(__OBSERVED_UNIT_TEST_FILES))
$(if $(__UNLISTED_UNIT_TEST_FILES), \
     $(error the variable $(__NOMINATE_UNIT_TEST_FILES) does not list $(__UNLISTED_UNIT_TEST_FILES)))
# end ---

__NOMINATE_ANY_OTHER_TEST_FILES = CONFIGURE_TESTS and UNIT_TESTS
__DECLARED_ANY_OTHER_TEST_FILES = $(CONFIGURE_TESTS) $(UNIT_TESTS)
__OBSERVED_ANY_OTHER_TEST_FILES = \
  $(wildcard \
    $(addprefix tests/unit/, \
                $(addsuffix /*.test, \
                            * */* */*/*))) \
  $(end)
__UNLISTED_ANY_OTHER_TEST_FILES = \
  $(filter-out $(__DECLARED_ANY_OTHER_TEST_FILES), \
               $(__OBSERVED_ANY_OTHER_TEST_FILES))
$(if $(__UNLISTED_ANY_OTHER_TEST_FILES), \
     $(error the variables $(__NOMINATE_ANY_OTHER_TEST_FILES) do not list $(__UNLISTED_ANY_OTHER_TEST_FILES)))
# end ---

# end duplicates

define TEST_SELF_CHECK
__NOMINATE_$(strip $1)_TEST_FILES = $1
__DECLARED_$(strip $1)_TEST_FILES = $3
__OBSERVED_$(strip $1)_TEST_FILES = \
  $(wildcard \
    $(addprefix $2, \
                $(addsuffix /*.test, \
                            * */* */*/*))) \
  $(end)
__UNLISTED_$(strip $1)_TEST_FILES = \
  $(filter-out $(__DECLARED_$(strip $1)_TEST_FILES), \
               $(__OBSERVED_$(strip $1)_TEST_FILES))
$(if $(__UNLISTED_$(strip $1)_TEST_FILES), \
     $(error the variable $(__NOMINATE_$(strip $1)_TEST_FILES) does not list $(__UNLISTED_$(strip $1)_TEST_FILES)))
endef
$(eval $(call TEST_SELF_CHECK, AC,        tests/ac,        $(AC_TESTS)))
$(eval $(call TEST_SELF_CHECK, CONFIGURE, tests/configure, $(CONFIGURE_TESTS)))
$(eval $(call TEST_SELF_CHECK, UNIT,      tests/unit,      $(UNIT_TESTS)))
$(eval $(call TEST_SELF_CHECK, ALL_OTHER, tests,           $(CONFIGURE_TESTS) $(UNIT_TESTS)))
