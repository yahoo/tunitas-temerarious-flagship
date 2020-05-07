dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_MSG_ERROR(message)
dnl TF_MSG_WARNING(message)
dnl TF_MSG_NOTICE(message)
dnl TF_MSG_VERBOSE(message)
dnl TF_MSG_DEBUG(message)
dnl
dnl Deprecations:
dnl
dnl    TF_MSG_WARN(message)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_MSG_ERROR(message)
dnl TF_MSG_WARNING(message)
dnl TF_MSG_NOTICE(message)
dnl TF_MSG_VERBOSE(message)
dnl TF_MSG_DEBUG(message)
dnl
dnl Also for compatibility with Autoconf, which inexplicably does not use the
dnl gerund form of "warning," but rather prefers "error" and "warn" but "notice"
dnl
dnl Deprecated:
dnl
dnl    TF_MSG_WARN(message)
dnl
dnl whereas "warn" (a verb) is always a surprise, we all expect the gerund form "warning."
dnl conjugation: the error, the warning, the notice, the verbose [message], the debug [message].
dnl

AC_DEFUN([TF_MSG_ERROR],   [ifdef([HGTW_MSG_ERROR],   [HGTW_MSG_ERROR([$1])],   [AC_MSG_ERROR([$1])])])
AC_DEFUN([TF_MSG_WARNING], [ifdef([HGTW_MSG_WARNING], [HGTW_MSG_WARNING([$1])], [AC_MSG_WARN([$1])])])
AC_DEFUN([TF_MSG_WARN],    [ifdef([HGTW_MSG_WARN],    [HGTW_MSG_WARN([$1])],    [AC_MSG_WARN([$1])])])
AC_DEFUN([TF_MSG_NOTICE],  [ifdef([HGTW_MSG_NOTICE],  [HGTW_MSG_NOTICE([$1])],  [AC_MSG_NOTICE([$1])])])
AC_DEFUN([TF_MSG_VERBOSE], [
    dnl prefer the new HGTW_-prefixed names to shut up the deprecation warnings
    AC_REQUIRE([TF_ENABLE_CONFIGURE_VERBOSE])
    ifdef([HGTW_MSG_VERBOSE], [HGTW_MSG_VERBOSE([$1])], [SCOLD_MSG_VERBOSE([$1])])
])
AC_DEFUN([TF_MSG_DEBUG], [
    dnl prefer the new HGTW_-prefixed names to shut up the deprecation warnings
    AC_REQUIRE([TF_ENABLE_CONFIGURE_DEBUG])
    ifdef([HGTW_MSG_DEBUG], [HGTW_MSG_DEBUG([$1])], [SCOLD_MSG_DEBUG([$1])])
])
