dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl A consistent message emission API
dnl
dnl Whereas, I'm tired of tripping over AC_MSG_WARN (exists) versus AC_MSG_WARNING (no such)
dnl and whereas everyone else in the logging business uses "warning" not "warn"
dnl
dnl And whereas, the full cascade of ERROR, WARNING, NOTICE, VERBOSE, DEBUG
dnl should have a consistent prefix to keep the intellectual clutter down...
dnl
dnl The API
dnl
dnl    HGTW_MSG_ERROR(...)
dnl    HGTW_MSG_WARNING(...)      ... new...
dnl    HGTW_MSG_NOTICE(...)
dnl    HGTW_MSG_VERBOSE(...)
dnl    HGTW_MSG_DEBUG(...)
dnl
dnl Instantly-deprecated
dnl
dnl   HGTW_MSG_WARN(...)        ...deprecated...
dnl

dnl this is what we came for s/WARN/WARNING/g
AC_DEFUN([HGTW_MSG_WARN], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[MSG]_WARN], [HT_[MSG]_WARNING])
    AC_MSG_WARN([$1])
])

dnl deprecating
AC_DEFUN([HGTW_MSG_ERROR],   [AC_MSG_ERROR([$1])])
AC_DEFUN([HGTW_MSG_WARNING], [AC_MSG_WARN([$1])])
AC_DEFUN([HGTW_MSG_NOTICE],  [AC_MSG_NOTICE([$1])])
dnl HGTW_MSG_VERBOSE is in enable-verbose.m4
dnl HGTW_MSG_DEBUG   is in enable_debug.m4

AC_DEFUN([HT_MSG_ERROR],   [AC_MSG_ERROR([$1])])
AC_DEFUN([HT_MSG_WARNING], [AC_MSG_WARN([$1])])
AC_DEFUN([HT_MSG_NOTICE],  [AC_MSG_NOTICE([$1])])
dnl ibidem (see enable-verbose.m4, enable-debug.m4)
