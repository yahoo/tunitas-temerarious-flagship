dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright Yahoo Inc, 2021.
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/basics/temerarious-flagship/LICENSE
dnl
dnl Build Instructions are in the nearby README.md
dnl
dnl ./maintenance/nearby is a developer-centric build recipe; it guesses about nearby source trees
dnl
dnl ./buildconf && ./configure --prefix=$(dirname $(pwd)) && make check
dnl also see ${prefix}/etc/config.site
dnl
dnl autoreconf --force --verbose --install
dnl autoreconf -vfi
dnl
AC_INIT([temerarious-flagship], [2.0.2], [tunitas@tunitas.technology])
dnl and yes there are other flagships and other toolings (packages-named "flagship" and packages named "tooling")
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

dnl See the AUTOMAKE_OPTIONS in the Makefile.am
AM_INIT_AUTOMAKE
AM_SILENT_RULES([yes])

AC_CONFIG_SRCDIR([src/app/namespace.xcpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])

# To get submodules to build in place, these go as a pair
#   configure.ac declares TF_CONFIG_SUBMODULES(directory, ...list...)
#   Makefile.am  declares SUBDIRS = @subdirs@
# there are no submodules

TF_COMPONENT_METADIRECTORY_TIERS
TF_ENABLE_GNU
TF_ENABLE_GDB
TF_ENABLE_GCC
TF_ENABLE_LIBTOOL_NO_INSTALL dnl gives @LDFLAGS_no_install@
TF_ENABLE_MOCK_BUILD dnl [[FIXTHIS]] is required for install; creates mk/configured.mk (can't not have it)

TF_WITH_SUBSYSTEM([hypogeal-twilight], [], [The SCOLD Build System])
TF_WITH_SUBSYSTEM([temerarious-flagship], [], [The Tunitas Build System])
TF_WITH_SUBSYSTEM([tunitas-basics], [], [The Tunitas Basics])

dnl Minimize these (tunitas-basics holds many of the upper-level library facilities)
TF_WITH_MODULE([langu]) dnl langu::age::q, langu::age::braket
TF_WITH_MODULE([nonstd])
TF_WITH_MODULE([options])
TF_WITH_MODULE([sys])

dnl [[deprecating]] being subsumed into module-langu, nonstd, options or sys
TF_WITH_MODULE([c])
TF_WITH_MODULE([format]) dnl format::q, format::braket
TF_WITH_MODULE([posix])
TF_WITH_MODULE([std])
TF_WITH_MODULE([string])

TF_WITH_MODULE([rigging-app]) dnl TESTING_AREAS only
TF_WITH_MODULE([rigging]) dnl TESTING_AREAS only
TF_WITH_MODULE([cppunit]) dnl TESTING_AREAS only and not needed when using module-rigging >= 2.0
TF_WITH_NONSTD([cppunit]) dnl ibidem

TF_WITH_STD([scold])
TF_WITH_STD([tunitas])

LT_PREREQ([2.4.2])
AM_PROG_AR dnl must be first
LT_INIT    dnl must be second
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O

TF_PROG_DC dnl the S.C.O.L.D. disaggregation compiler
TF_PROG_GCC dnl the correct enfreshend gcc ... we want the one closest to C++23 ...   gcc11 or gcc12 or gcc13
TF_CHECK_STD_FILESYSTEM dnl defines @libstd_filesystem@
TF_CHECK_CPPUNIT dnl defines toolflags of cppunit, @CPPFLAGS_cppunit@, @CXXFLAGS_cppunit@, @LDFLAGS_cppunit@, etc.

TF_CHECK_PACKAGES([tunitas.Optional tunitas.Tuple], [tunitas-basics-devel], [Basics of the Tunitas Technologies >= 2.0])
TF_CHECK_PACKAGES([tests.cppunit.Test tests.cppunit.test.Fixture rigging.suite.io], [module-rigging-devel], [Test Rigging of S.C.O.L.D., module-rigging >= 1.0])

TF_CHECK_PACKAGES([langu.age], [module-langu-devel], [The Langu.age Quoting, module-langu >= 1.0])

dnl Whereas These are just warnings at this point ... we can check for more and we can warn of future compatibilities
dnl only available in module-rigging >= 2.0
TF_CHECK_PACKAGES_WARNING([rigging.io],       [module-rigging-devel], [Test Rigging of S.C.O.L.D., module-rigging >= 2.0])
TF_CHECK_PACKAGES_WARNING([rigging.suite.io], [module-rigging-devel], [Test Rigging of S.C.O.L.D., module-rigging >= 1.0])

TF_PACKAGE_VARIABLES

dnl WATCHOUT if AC_OUTPUT is not called (transitively from TF_FINALIZE) then
dnl you will see the fantastically cryptic error
dnl
dnl    Error .../am/check2.am: error: am__EXEEXT does not appear in AM_CONDITIONAL
dnl
dnl See http://silas.net.br/tech/devel/autotools.html
dnl <best-estimate>add the required AC_OUTPUT macro to configure.ac (or configure.in)?</best-estimate>
TF_FINALIZE
