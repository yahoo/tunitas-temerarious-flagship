# -*- autoconf -*-
# For terms and provenance see the LICENSE file at the top of this repository.

AC_INIT(hypogeal-twilight-case-02, 0.0.0, operator@scold-lang.org)
SCOLD_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

# --with-external=DIRECTORY     e.g. /build/scold                        an areas of many other modules
# --with-submodules=DIRECTORY   e.g. ./submodules (older: ./exteranl)    the submodules area (is misnamed)
# --with-std-scold=ROOT         e.g. /opt/scold, /usr/local/scold        the single directory tree
SCOLD_COMPONENT_METADIRECTORY_TIERS

SCOLD_ENABLE_CONFIGURE_VERBOSE dnl first so that SCOLD_MSG_VERBOSE works
SCOLD_ENABLE_GCC
SCOLD_ENABLE_GDB
SCOLD_ENABLE_GNU
SCOLD_ENABLE_MOCK_BUILD

# for the defaults for these values
#   see .../etc/config.site.in

SCOLD_MSG_VERBOSE([system-side subsystems (alphabetical)])
SCOLD_WITH_MODULE([hypogeal-twilight], [hypogeal_twilight], [SCOLD autotools scaffolding])
SCOLD_WITH_MODULE([incendiary-sophist], [incendiary_sophist], [SCOLD test scaffolding])
SCOLD_WITH_MODULE([vernacular-doggerel], [vernacular_doggerel], [SCOLD rpmbuild scaffolding])

AC_CONFIG_SRCDIR([okay.cpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_HEADER([config.h]) dnl via autoheader via ./buildconf

AC_PREREQ([2.69])
AM_PROG_AR             dnl first
AC_PROG_LIBTOOL
AC_PROG_CXX
LT_PREREQ([2.4.2])
LT_INIT                dnl second
AC_LANG([C++])
# Checks for tools
dnl NO NEW TOOLS - e.g. no nonstd-gcc (not in this tester)
# Checks for packages
dnl NO NEW PACKAGES - e.g. no nonstd-cppunit (not in this tester)
# Checks for libraries.
# Checks for header files.
# Checks for typedefs, structures, and compiler characteristics.
# Checks for library functions.

dnl e.g. PACKAGE_APPDATADIR (.../share), PACKAGE_SITECONFIGDIR (.../etc)
SCOLD_PACKAGE_VARIABLES

SCOLD_MOCK_BUILD
SCOLD_MAKE_OBJ_DIRECTORIES
AC_OUTPUT
