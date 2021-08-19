dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_LIBTOOL_NO_INSTALL                 (no macro) arguments
dnl
dnl Default: enabled
dnl          (requires the overt action of --disable-libtool-no-install to disable)
dnl
dnl Interface: (in configure)
dnl
dnl   --enable-libtool-no-install=yes
dnl   --enable-libtool-no-install=no
dnl   --disable-libtool-no-install
dnl
dnl Enable / disable the -no-install option for libtool
dnl This is really only useful for the CHECK builds.
dnl
dnl Deprecations:
dnl   none
dnl
dnl Usage: (in Makefile.am)
dnl
dnl    Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_no_install@
dnl    Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_no_install@
dnl    Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_no_install@
dnl    Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_no_install@
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_ENABLE_LIBTOOL_NO_INSTALL                (no arguments)
dnl
AC_DEFUN([HGTW_ENABLE_LIBTOOL_NO_INSTALL], [
  AC_MSG_CHECKING([to disable the use of the libtool -no-install in check builds])
  AC_ARG_ENABLE([libtool-no-install],
                [AS_HELP_STRING([--disable-libtool-no-install], [disable the libtool -no-install during check builds])],
                [AS_IF([test "x$enable_libtool_no_install" != "xno"],
                       [: enable libtool_-no-install in the check build LDFLAGS],
                       [: disable libtool -no-install in the check build LDFLAGS])],
                [enable_libtool_no_install=yes])
  AC_MSG_RESULT([$enable_libtool_no_install])
  if test xno != x$enable_libtool_no_install ; then
      dnl https://wiki.scold-lang.org/
      LDFLAGS_no_install=-no-install
  fi
  AC_SUBST([CPPFLAGS_no_install]) dnl for symmetry
  AC_SUBST([CFLAGS_no_install])
  AC_SUBST([CXXFLAGS_no_install])
  AC_SUBST([LDFLAGS_no_install])  dnl only this one could ever have a value
])
