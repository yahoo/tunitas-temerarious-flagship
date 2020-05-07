dnl -*- autoconf -*-test code; but see the LICENSE file nearby.
dnl Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE
dnl For terms, see the LICENSE file at the top of this repository
dnl
dnl WATCHOUT - you MUST NOT have the macro name that you are testing (e.g. TF_WITH_NONSTD_LEVELDB be the AC_INIT package name (unquoted)
AC_INIT([testy-mctestface], [0.0.0], [testy@tunitas.technology])
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
AC_CONFIG_FILES([Makefile])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
TF_CHECK_PACKAGES([std], [module-std-devel], [The Standard C++ Library]) dnl <----------- test this
TF_FINALIZE
