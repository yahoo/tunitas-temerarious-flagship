dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_MSG_VERBOSE only emits if --enable-configure-verbose was turned on
dnl
dnl
dnl HT_ENABLE_CONFIGURE_VERBOSE                         (no arguments)
dnl [[deprecated]] HGTW_ENABLE_CONFIGURE_VERBOSE        (no arguments)
dnl [[deprecated]] SCOLD_ENABLE_CONFIGURE_VERBOSE       (no arguments)
dnl
dnl    --enable-configure-verbose ... turns on verbose error messaging
dnl    --enable-config-verbose ...... is an error (do not use it)
dnl
dnl HT_MSG_VERBOSE(verbose-message)
dnl HT_MSG_VERBOSE(verbose-message, non-verbose-message)
dnl [[deprecated]] HGTW_MSG_VERBOSE(verbose-message)
dnl [[deprecated]] HGTW_MSG_VERBOSE(verbose-message, non-verbose-message)
dnl [[deprecated]] SCOLD_MSG_VERBOSE(verbose-message)
dnl [[deprecated]] SCOLD_MSG_VERBOSE(verbose-message, non-verbose-message)
dnl

dnl ----------------------------------------------------------------------------------------------------
 - 
dnl
dnl HT_ENABLE_CONFIGURE_VERBOSE       (no arguments)
dnl
AC_DEFUN([SCOLD_ENABLE_CONFIGURE_VERBOSE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[ENABLE]_[CONFIGURE]_VERBOSE], [HT_[ENABLE]_[CONFIGURE]_VERBOSE])
    HT_ENABLE_CONFIGURE_VERBOSE
])
AC_DEFUN([HGTW_ENABLE_CONFIGURE_VERBOSE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([HGTW_[ENABLE]_[CONFIGURE]_VERBOSE], [HT_[ENABLE]_[CONFIGURE]_VERBOSE])
    HT_ENABLE_CONFIGURE_VERBOSE
])
AC_DEFUN([HT_ENABLE_CONFIGURE_VERBOSE], [
    AC_ARG_ENABLE([config-verbose],
                  [AS_HELP_STRING([--enable-config-verbose], [ERROR use --enable-configure-verbose instead])],
                  [AC_MSG_ERROR([do not use --enable-config-verbose, rather use --enable-configure-verbose])])
    AC_MSG_CHECKING([configuration-time verbose messages])
    AC_ARG_ENABLE([configure-verbose],
                  [AS_HELP_STRING([--enable-configure-verbose], [enable configure-time verbose messages])],
                  [: already set],
                  [enable_configure_verbose=no])
    AC_MSG_RESULT([$enable_configure_verbose]) 
])

dnl
dnl HT_MSG_VERBOSE(verbose-message)                        verbose message only
dnl HT_MSG_VERBOSE(verbose-message, non-verbose-message)   optional non-verbose message
dnl
AC_DEFUN([SCOLD_MSG_VERBOSE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[MSG]_VERBOSE], [HT_[MSG]_VERBOSE])
    HT_MSG_VERBOSE([$1], [$2])
])
AC_DEFUN([HGTW_MSG_VERBOSE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[MSG]_VERBOSE], [HT_[MSG]_VERBOSE])
    HT_MSG_VERBOSE([$1], [$2])
])
AC_DEFUN([HT_MSG_VERBOSE], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    if test xyes = x"${enable_configure_verbose:-no}"
    then
        AC_MSG_NOTICE([$1])
    elif test -n "$2"
    then
        AC_MSG_NOTICE([$2])
    fi
])
