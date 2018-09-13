dnl
dnl TF_ENABLE_<that>
dnl
dnl Some basic well-understood enablements
dnl

dnl the -D_GNU_SOURCE flags
AC_DEFUN([TF_ENABLE_GNU], [SCOLD_ENABLE_GNU])

dnl the -gdb flags
AC_DEFUN([TF_ENABLE_GDB], [SCOLD_ENABLE_GDB])

dnl the C++17 flags
AC_DEFUN([TF_ENABLE_GCC], [SCOLD_ENABLE_GCC])

AC_DEFUN([TF_ENABLE_MOCK_BUILD], [
    AC_REQUIRE([SCOLD_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([TF_WITH_HYPOGEAL_TWILIGHT])
    AC_REQUIRE([TF_WITH_TEMERARIOUS_FLAGSHIP])
    SCOLD_MSG_VERBOSE([[TF]_[ENABLE]_[MOCK]_[BUILD] is unimplemented, do you really need mock building at this point?])
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
# but a stub is needed because hypogeal-twilight expects it.
#
__EOF__
])

dnl end
