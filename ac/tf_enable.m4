dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc. 2021
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_ENABLE_<that> for GNU, GDB, GCC, MOCK_BUILD
dnl
dnl TF_ENABLE_GNU           -D_GNU_SOURCE
dnl TF_ENABLE_GDB           -ggdb
dnl TF_ENABLE_GCC           C++17, C++2a, etc.
dnl
dnl Deprecating:
dnl    TF_ENABLE_MOCK_BUILD    /etc/mock, /build/mock for the rpm package(s)
dnl
dnl Some basic well-understood enablements
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([TF_ENABLE_CONFIGURE_VERBOSE], [
  ifdef([HGTW_ENABLE_CONFIGURE_VERBOSE], dnl prefer the newer names to shutup the deprecation warnings
        [HGTW_ENABLE_CONFIGURE_VERBOSE],
        [ifdef([SCOLD_ENABLE_CONFIGURE_VERBOSE],
               [SCOLD_ENABLE_CONFIGURE_VERBOSE],
               [TF_MSG_WARNING([[TF]_[ENABLE]_[CONFIGURE]_[VERBOSE] is not implemented, ignoring it])])])
])
AC_DEFUN([TF_ENABLE_CONFIGURE_DEBUG], [
  ifdef([HGTW_ENABLE_CONFIGURE_DEBUG], dnl ibidem (prefer the newer)
        [HGTW_ENABLE_CONFIGURE_DEBUG],
        [ifdef([SCOLD_ENABLE_CONFIGURE_DEBUG],
               [SCOLD_ENABLE_CONFIGURE_DEBUG],
               [TF_MSG_WARNING([[TF]_[ENABLE]_[CONFIGURE]_[DEBUG] is not implemented, ignoring it])])])
])

dnl The -D_GNU_SOURCE flags
AC_DEFUN([TF_ENABLE_GNU], [ifdef([HGTW_ENABLE_GNU], [HGTW_ENABLE_GNU], [SCOLD_ENABLE_GNU])])

dnl The -gdb flags
AC_DEFUN([TF_ENABLE_GDB], [ifdef([HGTW_ENABLE_GDB], [HGTW_ENABLE_GDB], [SCOLD_ENABLE_GDB])])

dnl The C++17, C++2a flags
AC_DEFUN([TF_ENABLE_GCC], [ifdef([HGTW_ENABLE_GCC], [HGTW_ENABLE_GCC], [SCOLD_ENABLE_GCC])])

dnl
dnl You will still need this as late as hypgeal-twilight >= 0.45
dnl It sets up something in ./mk, e.g. buildconfed.mk, configured.mk or extracted.mk
dnl But with the policy of "project separated from packaging", it serves no other purpose.
dnl
dnl Usage: (yes, you must utter it)
dnl
AC_DEFUN([TF_ENABLE_MOCK_BUILD], [
    AC_REQUIRE([TF_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([TF_WITH_HYPOGEAL_TWILIGHT])
    AC_REQUIRE([TF_WITH_TEMERARIOUS_FLAGSHIP])
    TF_MSG_VERBOSE([[TF]_[ENABLE]_[MOCK]_[BUILD] is unimplemented, do you really need mock building at this point?])
    dnl
    dnl ENABLE_MOCK_BUILD__ACTIONS_WHEN_DISABLED
    dnl ... still responsible for creating ./mk/configured.mk with stub entries
    dnl ... some of the ./am/*.mk files still expect it (transitively)
    dnl
    declare CONFIGFILE=mk/configured.mk
    declare tCONFIGFILE="${CONFIGFILE%/*}/t99.${CONFIGFILE##*/}.$$.mk~"
    TF_MSG_VERBOSE([configuring ${CONFIGFILE?} as disabled])
    mkdir -p ${tCONFIGFILE%/*} && tee ${tCONFIGFILE?} <<__EOF__ | sed -e "s,^,${CONFIGFILE##*/}-> ," && mv -f "${tCONFIGFILE?}" "${CONFIGFILE?}"
# prefix, includedir, modulesdir, libdir, _lib are all expected to have been set in the containing Makefile
#
# This file is substantially unused in temerarious-flagship,
# but a stub is needed because hypogeal-twilight expects it to exist.
#
__EOF__
])

dnl
dnl TF_ENABLE_LIBTOOL_NO_INSTALL                 (no macro) arguments
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
dnl   This is new. There never was a SCOLD_ variant, so compatibility is not warranted
dnl
dnl Usage: (in Makefile.am)
dnl
dnl    Makefile_CHECK_CPPFLAGS_SET = @CPPFLAGS_no_install@
dnl    Makefile_CHECK_CFLAGS_SET   =   @CFLAGS_no_install@
dnl    Makefile_CHECK_CXXFLAGS_SET = @CXXFLAGS_no_install@
dnl    Makefile_CHECK_LDFLAGS_SET  =  @LDFLAGS_no_install@
dnl
AC_DEFUN([TF_ENABLE_LIBTOOL_NO_INSTALL], [HGTW_ENABLE_LIBTOOL_NO_INSTALL])
