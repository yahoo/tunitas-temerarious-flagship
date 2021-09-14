dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_APPEND_SUBCONFIGURE_ARGUMENT(key, value)
dnl HGTW_APPEND_SUBCONFIGURE_ARGUMENT(key)
dnl
dnl Appends " key=value" to the subconfigure argument(s) string.
dnl
dnl No shell quoting should be applied to key and value.
dnl Single quoting inside double quoting is applied to both values to affect the append.
dnl
dnl The capability acts in concert with the self-editing of the our .../libexec/autotools-local-preconfigure.
dnl
dnl Normally the ./configure resets the ac_sub_configure_args variable to empty
dnl before developing a subset of the arguments which should be passed downward for
dnl the recursive configurations.  Crudely, the editing stops that, marking that it was done.
dnl
dnl in .../libexec/autotools-local-preconfigure, find a line amounting to...
dnl
dnl     sed -i -e '/eval.*SHELL.*ac_sub_configure.*ac_sub_configure_args/ a\\;...something..." configure
dnl
dnl ./configure is "old sh" so there are no array variables to be had; only quoted strings.
dnl
AC_DEFUN([HGTW_APPEND_SUBCONFIGURE_ARGUMENT], [
  dnl beware the quoting here
  dnl beware the leading space to separate the arguments from each other
  dnl
  dnl here ---------------------------\ (here)
  dnl                                 |
  dnl                                 v
  as_fn_append hgtw_sub_configure_args " 'ifelse([$2], [], [$1], [$1=$2])'"
  HGTW_MSG_DEBUG([now hgtw_sub_configure_args=$hgtw_sub_configure_args])
])
