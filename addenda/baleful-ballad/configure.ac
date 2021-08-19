dnl This is an -*- autoconf -*- script. For terms, see the LICENSE file at the top of the repository.
dnl
dnl see ./buildconf which is nearby
dnl see ./maintenance/nearby which is (um) nearby
dnl 
dnl usage
dnl   ./buildconf
dnl   ./configure [ --prefix=PREFIX ] [ --with-static-executables ]
dnl   make check
dnl   make install
dnl
dnl recall:
dnl   autoreconf --force --verbose --install
dnl   autoreconf -vfi
dnl

AC_INIT([baleful-ballad], [1.1.0], [operator@scold-lang.org])
HGTW_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

HGTW_COMPONENT_METADIRECTORY_TIERS

HGTW_ENABLE_CONFIGURE_VERBOSE dnl first to --enable-configure-verbose
HGTW_ENABLE_STATIC_EXECUTABLES dnl --enable-static-executables
HGTW_ENABLE_GCC
HGTW_ENABLE_GDB
HGTW_ENABLE_GNU
HGTW_ENABLE_LIBTOOL_NO_INSTALL
HGTW_ENABLE_MOCK_BUILD

HGTW_MSG_VERBOSE([development subsystems (alphabetical)])
HGTW_WITH_MODULE([boost]) dnl [[FIXTHIS]] shall we remove the dependence upon boost?
HGTW_WITH_MODULE([c])
HGTW_WITH_MODULE_ALIASED([slurp], [file-slurp])
HGTW_WITH_MODULE([format])
HGTW_WITH_MODULE([nonstd])
HGTW_WITH_MODULE([options])
HGTW_WITH_MODULE([posix])
dnl HGTW_WITH_MODULE([sqlite])
HGTW_WITH_MODULE([std])
HGTW_WITH_MODULE_ALIASED([string], [c-string])
HGTW_WITH_MODULE([sys])
HGTW_WITH_MODULE([uuid])

HGTW_MSG_VERBOSE([testing subsystems (alphabetical)])
HGTW_WITH_MODULE([cppunit])
HGTW_WITH_MODULE_ALIASED([rigging], [rigging-unit], [unit-rigging])

HGTW_MSG_VERBOSE([compiler-specific subsystems (alphabetical)])
dnl --with-std-scold is entailed above
HGTW_WITH_NONSTD_GCC
HGTW_WITH_NONSTD([boost])
HGTW_WITH_NONSTD([cppunit])

HGTW_MSG_VERBOSE([system-side subsystems (alphabetical)])
HGTW_WITH_SUBSYSTEM([hypogeal-twilight], [hypogeal_twilight], [SCOLD autotools scaffolding])
HGTW_WITH_SUBSYSTEM([incendiary-sophist], [incendiary_sophist], [SCOLD test rigging])
HGTW_WITH_SUBSYSTEM([vernacular-doggerel], [vernacular_doggerel], [SCOLD rpmbuild scaffolding])

AC_CONFIG_SRCDIR([src/remonstrate/main.xcpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_HEADERS([config.h])

# not in alphabetical order, rather in the cryptic "you just have to know" order in which they have to be built
# also add meintons here into config.settings.in
#
# Makefile.am:  SUBDIRS = @subdirs@
# configure.ac: HGTW_CONFIG_SUBMODULES([submodules], [ ... list ... ])

AC_PREREQ([2.69])
AM_PROG_AR             dnl first
AC_PROG_LIBTOOL
AC_PROG_CXX
LT_PREREQ([2.4.2])
LT_INIT                dnl second
AC_LANG([C++])
HGTW_PACKAGE_VARIABLES
HGTW_CHECK_GCC
HGTW_CHECK_BOOST
HGTW_WITH_BOOST_LAYOUT    dnl FIXTHIS ... "CHECK"
HGTW_WITH_STD_REGEX       dnl FIXTHIS ... "CHECK"
HGTW_CHECK_CPPUNIT
HGTW_CHECK_UUID

dnl              dnf install module-boost-devel
dnl                          |
dnl         #import boost    |
dnl                 |        |
dnl                 v        v
HGTW_CHECK_PACKAGE([boost], [module-boost-devel])
HGTW_CHECK_PACKAGE([c], [module-c-devel])
HGTW_CHECK_PACKAGE([slurp], [module-slurp-devel]) dnl does not handle older file-slurp-devel, but only a warning is issued
HGTW_CHECK_PACKAGE([format], [module-format-devel])
HGTW_CHECK_PACKAGE([nonstd], [module-nonstd-devel])
HGTW_CHECK_PACKAGE([options], [module-options-devel])
HGTW_CHECK_PACKAGE([posix], [module-posix-devel])
dnl NOT YET---> HGTW_CHECK_PACKAGE([sqlite], [module-sqlite-devel])
HGTW_CHECK_PACKAGE([std], [module-std-devel])
HGTW_CHECK_PACKAGE([string], [module-string-devel]) dnl ibidem.  c-string-devel
HGTW_CHECK_PACKAGE([sys], [module-sys-devel])
HGTW_CHECK_PACKAGE([uuid], [module-uuid-devel])
HGTW_CHECK_PACKAGE([cppunit], [module-cppunit-devel])
HGTW_CHECK_PACKAGE([rigging], [module-rigging-devel]) dnl ibidem.  rigging-unit-devel, unit-rigging-devel

# Specimen
#
#     obj/modules/fpp/sqar.CONFIG : src/sqar/CONFIG.xcpp
#     	$(bbDC) $(bbDC_OPTIONS) $(SEARCHPATH) $<  <------------------- this line
#     ^
#     |
#     \---------- \t (tab)
#
# AM_V_BB1ST is defined in hypogeal-twilight/am/compiler.mk
# it provides the chatter or silence against V=0, V=1
#
dnl https://www.gnu.org/software/autoconf/manual/autoconf.html#Forbidden-Patterns
m4_pattern_allow([AM_V_BB1ST])
script='$(AM_V_BB1ST) $(bbDC) $(bbDC_OPTIONS) $(SEARCHPATH) $<'
AC_DEFINE_UNQUOTED([MAKE_DEPEND_SCRIPT], ["$script"], [make depend recomputation script])

HGTW_FINALIZE
