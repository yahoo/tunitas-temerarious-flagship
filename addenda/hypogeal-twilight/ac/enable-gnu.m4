dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_GNU                 (no macro) arguments
dnl [[deprecated]] SCOLD_ENABLE_GNU                 (no macro) arguments
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_ENABLE_GNU                (no arguments)
dnl
AC_DEFUN([SCOLD_ENABLE_GNU], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[ENABLE]_GNU], [HGTW_[ENABLE]_GNU])
    HGTW_ENABLE_GNU
])
AC_DEFUN([HGTW_ENABLE_GNU], [
  AC_MSG_CHECKING([to enable the use of the GNU API extensions])
  AC_ARG_ENABLE([gnu],
                [AS_HELP_STRING([--disable-gnu], [disable the GNU API extensions (foolish)])],
                [AS_IF([test "x$enable_gnu" != "xno"],
                       [: enable _GNU_SOURCE],
                       [: disable _GNU_SOURCE])],
                [enable_gnu=yes])
  AC_MSG_RESULT([$enable_gnu])
  if test xno != x$enable_gnu ; then
      dnl https://ftp.gnu.org/old-gnu/Manuals/glibc-2.2.3/html_chapter/libc_1.html
      dnl https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html
      AC_DEFINE([_GNU_SOURCE], [1], [Yes, enable the GNU APIs])
  fi
])
