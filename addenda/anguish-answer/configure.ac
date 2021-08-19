dnl -*- autoconf -*-
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl see ./buildconf which is nearby
dnl 
dnl recall:
dnl   autoreconf --force --verbose --install
dnl   autoreconf -vfi
dnl

AC_INIT([anguish-answer], [2.1.0], [administrator@scold-lang.org])
HGTW_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

AC_PREREQ([2.69])
AM_PROG_AR             dnl first
AC_PROG_LIBTOOL
AC_PROG_CXX
LT_PREREQ([2.4.2])
LT_INIT                dnl second
AC_LANG([C++])

HGTW_ENABLE_CONFIGURE_VERBOSE dnl first to --enable-configure-verbose
HGTW_COMPONENT_METADIRECTORY_TIERS
HGTW_ENABLE_GDB
HGTW_ENABLE_GNU
HGTW_ENABLE_GCC
HGTW_ENABLE_LIBTOOL_NO_INSTALL

# These must match the DEVELOPMENT_AREAS in Makefileam
HGTW_WITH_MODULE([half])
HGTW_WITH_MODULE([nonstd])
HGTW_WITH_MODULE([posix])
HGTW_WITH_MODULE([std])
HGTW_WITH_MODULE_ALIASED([string], [c-string])
HGTW_WITH_MODULE([sys])
HGTW_WITH_MODULE([uuid])

HGTW_WITH_MODULE_ALIASED([rigging], [rigging-unit], [unit-rigging])
HGTW_WITH_MODULE([cppunit])

HGTW_WITH_NONSTD([gcc], [gcc], [A GCC modernized C++20, C++2b, C++23, C++2c, and beyond])
HGTW_WITH_NONSTD([half], [half], [A Half-Precision (IEEE 754)])
HGTW_WITH_STD([scold], [scold], [The standard HGTW installation area])

HGTW_WITH_HYPOGEAL_TWILIGHT
HGTW_WITH_INCENDIARY_SOPHIST

AC_CONFIG_SRCDIR([src/app/dc/c.main.xcpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_FILES([Makefile tests/config.sh])
AC_CONFIG_HEADERS([config.h])

# not in alphabetical order, rather in the cryptic "you just have to know" order in which they have to be built
dnl Makefile.am:  SUBDIRS = @subdirs@
dnl configure.ac: HGTW_CONFIG_SUBMODULES([submodules], [ ...list...])

HGTW_PACKAGE_VARIABLES

HGTW_CHECK_GCC
HGTW_CHECK_BOOST
m4_ifdef([HGTW_WITH_BOOST_LAYOUT], [HGTW_WITH_BOOST_LAYOUT], [SCOLD_WITH_BOOST_LAYOUT])
HGTW_WITH_STD_REGEX

HGTW_CHECK_CPPUNIT
HGTW_CHECK_STD_FILESYSTEM
m4_ifdef([HGTW_CHECK_UUID], [HGTW_CHECK_UUID], [SCOLD_CHECK_UUID])

HGTW_FINALIZE
