dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_HALF                    (no arguments)
dnl
dnl [[deprecated]] SCOLD_CHECK_HALF    (no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_CHECK_HALF                    (no arguments)
dnl [[deprecated]] SCOLD_CHECK_HALF    (no arguments)
dnl
dnl Whereas there is no "standard" build of half, we require that nonstd be indicated
dnl
dnl Preconditions:
dnl     HGTW_WITH_NONSTD_HALF
dnl     HGTW_WITH_NONSTD([half], [half], [a non-standard Half-Float IEEE476])
dnl
AC_DEFUN([SCOLD_CHECK_HALF], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_[HALF]],
                        [HGTW_[CHECK]_[HALF]])
    HGTW_CHECK_HALF
])
AC_DEFUN([HGTW_CHECK_HALF], [
    AC_REQUIRE([HGTW_WITH_NONSTD_HALF])
    AC_REQUIRE([HGTWinternal_CHECK_HALF_REPROBE_WITH])
    if test xNONE == "x$nonstd_half_prefix" ||
       test x == "x$nonstd_half_prefix"
    then
        # pesky: must generate a single-quote character at runtime
        #        because the emacs bra-ket matching is confused by it in m4-mode
        q=$(printf "\x27") # pesky 
       __half_package_name="${q}half${q}"
        __nonstd_half_package_name="${q}nonstd-half${q}"
        __nonstd_half_devel_package_name="${q}nonstd-half-devel${q}"
        AC_MSG_NOTICE([there is no "standard" packaging of ${__half_package_name?}])
        AC_MSG_NOTICE([the use of ${__nonstd_half_package_name?} is required])
        AC_MSG_NOTICE([you may need to install ${__nonstd_half_devel_package_name?}])
        AC_MSG_ERROR([retry the configuration with --with-nonstd-half=ROOT])
    fi
])

AC_DEFUN([HGTWinternal_CHECK_HALF_REPROBE_WITH], [
    if test x = "x$with_nonstd_half"
    then
        dnl get to a sate of with_nonstd_half= { yes, no, ...fullpath... }
        HGTW_WITH_NONSTD([half], [half], [a non-standard Half-Float IEEE476])
    fi
])
