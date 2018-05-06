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
dnl TF_MSG_WARN(message)
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
