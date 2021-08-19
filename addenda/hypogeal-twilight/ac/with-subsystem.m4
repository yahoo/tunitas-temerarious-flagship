dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl [[deprecated]] HT_WITH_SUBSYSTEM(name-dashes, name_underscores, [explanation])
dnl [[deprecated]] HGTW_WITH_SUBSYSTEM(name-dashes, name_underscores, [explanation])
dnl [[deprecated]] SCOLD_WITH_SUBSYSTEM(name-dashes, name_underscores, [explanation])
dnl
dnl     $1 - argument name-with-dashes          required e.g. module-c-string
dnl     $2 - argument name_with_underscores     optional  e.g. module_c_string
dnl     $3 - explanation fragment               optional  e.g. C language module
dnl
dnl The word SUBSYSTEM came-and-went in but a few releases.
dnl also a deprecated usage
dnl

AC_DEFUN([SCOLD_WITH_SUBSYSTEM], [
    HTfriend_NOTICE_OF_USER_ERROR_NEVER_WAS([SCOLD_[WITH]_SUBSYSTEM], [HT_[WITH]_COMPONENT], [$1], [$2], [$3])
    HT_WITH_COMPONENT([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_SUBSYSTEM], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([HGTW_[WITH]_SUBSYSTEM], [HT_[WITH]_COMPONENT])
    HT_WITH_COMPONENT([$1], [$2], [$3])
])
AC_DEFUN([HT_WITH_SUBSYSTEM], [
    HTfriend_NOTICE_OF_USER_ERROR_NEVER_WILL_BE([HT_[WITH]_SUBSYSTEM], [HT_[WITH]_COMPONENT], [$1], [$2], [$3])
    HT_WITH_COMPONENT([$1], [$2], [$3])
])
