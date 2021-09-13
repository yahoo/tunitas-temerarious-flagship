dnl -*- autoconf -*-test code; but see the LICENSE file nearby.
dnl Yahoo Inc. 2021.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.
dnl See the LICENSE file at the top of this repository.
dnl
dnl WATCHOUT - you MUST NOT have the macro name that you are testing (e.g. TF_WITH_NONSTD_LEVELDB be the AC_INIT package name (unquoted)
AC_INIT([testy-mctestface], [0.0.0], [testy@tunitas.technology])
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
AC_CONFIG_FILES([Makefile])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
TF_CHECK_MYSQLPP dnl <----------- test this
TF_FINALIZE
