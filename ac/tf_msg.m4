dnl Copyright 2019, Oath Inc. Licensed under the terms of the Apache-2.0 license. See LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.
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
dnl whereas "warn" is always a surprise, we all expect the gerund form "warning."
dnl

AC_DEFUN([TF_MSG_ERROR],   [AC_MSG_ERROR([$1])])
AC_DEFUN([TF_MSG_WARNING], [AC_MSG_WARN([$1])])
AC_DEFUN([TF_MSG_WARN],    [AC_MSG_WARN([$1])])
AC_DEFUN([TF_MSG_NOTICE],  [AC_MSG_NOTICE([$1])])
AC_DEFUN([TF_MSG_VERBOSE], [
    AC_REQUIRE([SCOLD_ENABLE_CONFIGURE_VERBOSE])
    SCOLD_MSG_VERBOSE([$1])
])
AC_DEFUN([TF_MSG_DEBUG], [
    AC_REQUIRE([SCOLD_ENABLE_CONFIGURE_DEBUG])
    SCOLD_MSG_DEBUG([$1])
])
