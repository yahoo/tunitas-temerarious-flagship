dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_MSG_DEBUG only emits if --enable-configure-debug was turned on
dnl
dnl HT_ENABLE_CONFIGURE_DEBUG                         (no arguments)
dnl [[deprecated]] HGTW_ENABLE_CONFIGURE_DEBUG        (no arguments)
dnl [[deprecated]] SCOLD_ENABLE_CONFIGURE_DEBUG       (no arguments)
dnl
dnl    --enable-configure-debug ... turns on debug error messaging
dnl    --enable-config-debug ...... is an error (do not use it)
dnl
dnl HT_MSG_DEBUG(debug-message)
dnl HT_MSG_DEBUG(debug-message, non-debug-message)
dnl [[deprecated]] HGTW_MSG_DEBUG(debug-message)
dnl [[deprecated]] HGTW_MSG_DEBUG(debug-message, non-debug-message)
dnl [[deprecated]] SCOLD_MSG_DEBUG(debug-message)
dnl [[deprecated]] SCOLD_MSG_DEBUG(debug-message, non-debug-message)
dnl

dnl ----------------------------------------------------------------------------------------------------
 - 
dnl
dnl HT_ENABLE_CONFIGURE_DEBUG       (no arguments)
dnl
AC_DEFUN([SCOLD_ENABLE_CONFIGURE_DEBUG], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[ENABLE]_[CONFIGURE]_DEBUG], [HGTW_[ENABLE]_[CONFIGURE]_DEBUG])
    HT_ENABLE_CONFIGURE_DEBUG
])
AC_DEFUN([HGTW_ENABLE_CONFIGURE_DEBUG], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[ENABLE]_[CONFIGURE]_DEBUG], [HGTW_[ENABLE]_[CONFIGURE]_DEBUG])
    HT_ENABLE_CONFIGURE_DEBUG
])
AC_DEFUN([HT_ENABLE_CONFIGURE_DEBUG], [
    AC_ARG_ENABLE([config-debug],
                  [AS_HELP_STRING([--enable-config-debug], [ERROR use --enable-configure-debug instead])],
                  [AC_MSG_ERROR([do not use --enable-config-debug, rather use --enable-configure-debug])])
    AC_ARG_ENABLE([config-debugging],
                  [AS_HELP_STRING([--enable-config-debugging], [ERROR use --enable-configure-debug instead])],
                  [AC_MSG_ERROR([do not use --enable-config-debugging, rather use --enable-configure-debug])])
    AC_ARG_ENABLE([configure-debugging],
                  [AS_HELP_STRING([--enable-configure-debugging], [ERROR use --enable-configure-debugging instead])],
                  [AC_MSG_ERROR([do not use --enable-configure-debugging, rather use --enable-configure-debug])])
    AC_MSG_CHECKING([configuration-time debug messages])
    AC_ARG_ENABLE([configure-debug],
                  [AS_HELP_STRING([--enable-configure-debug], [enable configure-time debug messages])],
                  [: already set],
                  [enable_configure_debug=no])
    AC_MSG_RESULT([$enable_configure_debug]) 
])

dnl
dnl HT_MSG_DEBUG(debug-message)                      debug message only
dnl HT_MSG_DEBUG(debug-message, non-debug-message)   optional non-debug message
dnl
AC_DEFUN([SCOLD_MSG_DEBUG], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[MSG]_DEBUG], [HT_[MSG]_DEBUG])
    HT_MSG_DEBUG([$1], [$2])
])
AC_DEFUN([HGTW_MSG_DEBUG], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[MSG]_DEBUG], [HT_[MSG]_DEBUG])
    HT_MSG_DEBUG([$1], [$2])
])
AC_DEFUN([HT_MSG_DEBUG], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_DEBUG])
    if test xyes = x"${enable_configure_debug:-no}"
    then
        AC_MSG_NOTICE([debug: $1])
    elif test -n "$2"
    then
        AC_MSG_NOTICE([$2]) dnl the optional non-debug message
    fi
])
