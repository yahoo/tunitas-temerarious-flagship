dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc. 2021
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl TF_INIT(package, version, bugreport)

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_INIT(package, version, bugreport)
dnl
dnl Whereas AC_INIT does not like to be disintermediated.
dnl but someone has to initialize automake, libtool and do
dnl some basic preamble stuff...
dnl
dnl Usage:
dnl
dnl     AC_INIT([mypackage], [1.2.3], [/dev/null@example.com])
dnl     TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
dnl
AC_DEFUN([TF_INIT], [
    ifdef([HGTW_INIT], dnl shutup the deprecation warnings
          [HGTW_INIT([$1], [$2], [$3])],
          [SCOLD_INIT([$1], [$2], [$3])])
])
