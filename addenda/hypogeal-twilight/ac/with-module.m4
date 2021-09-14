dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_WITH_MODULE(name-dashes)
dnl [[deprecated]] HGTW_WITH_MODULE(name-dashes)
dnl [[deprecated]] SCOLD_WITH_MODULE ... had 3 arguments; had a different semantic...
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HT_WITH_MODULE(name-dashes)
dnl HT_WITH_MODULE(name-dashes, name_with_underscores)
dnl
dnl $1 - argument name-with-dashes         required    e.g. c, regex, rigging-unit, std, string
dnl $2 - argument name with underscores    optional    e.g. rigging_unit, apache_httpd_api
dnl
dnl Disallow the the "module-" prefix on $2
dnl Synthesize $3 from $1
dnl Too much redundancy, not enough information.
dnl
dnl See also HT_WITH_MODULE_ALIASED(oldname, newname)
dnl
dnl SCOLD_WTIH_MODULE(3-arg) <---> HT_WITH_MODULE(1-arg]
dnl SCOLD_WTIH_MODULE(3-arg) <---> HT_WITH_MODULE(2-arg]
dnl
dnl     SCOLD_WITH_MODULE([module-something], [module-something], [The Something Module])
dnl   becomes
dnl     HTGTW_WITH_MODULE([something])
dnl   becomes
dnl     HT_WITH_MODULE([something])
dnl
AC_DEFUN([SCOLD_WITH_MODULE], [
    HTfriend_NOTICE_OF_BREAKING_CHANGE_SCOLD_PREFIX([MODULE], [$1], [$2], [$3])
    HT_WITH_COMPONENT([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_MODULE], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([HGTW_[WITH]_MODULE], [HT_[WITH]_MODULE])
    HT_WITH_MODULE([$1], [$2])
])
AC_DEFUN([HT_WITH_MODULE], [
    ifelse(m4_bpatsubst([$1], [module-.*], [module]), [module], [
        AC_MSG_ERROR([[Ht]_[WITH]_[MODULE] does not accept the "module-" prefix, rather, it is now implicit])
    ], [m4_ifblank([$2], [
        HT_WITH_COMPONENT([module-$1], m4_bpatsubst([module_$1], [-], [_]), [The $1 module of S.C.O.L.D.])
    ], [
        AC_MSG_ERROR([[HT]_[WITH]_[MODULE] only accepts a single argument])
    ])])
])
