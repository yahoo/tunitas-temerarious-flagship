# -*- autoconf -*-test code; but see the LICENSE file nearby.
dnl
dnl WATCHOUT - you MUST NOT have the macro name HGTW_WITH_USR_LOCAL as the package name (unquoted)
AC_INIT([testy-mctestface], [0.0.0], [testy@scold-lang.org])
HGTW_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
AC_CONFIG_FILES([Makefile])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
SCOLD_OUTPUT dnl <----------------- test this, show it has correct shellcode and "is legal"
dnl
dnl This use of SCOLD_OUTPUT is a hard error.    See run.test nearby
dnl expect: exit 1
