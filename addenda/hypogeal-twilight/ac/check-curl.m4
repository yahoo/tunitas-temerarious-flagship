dnl
dnl HT_CHECK_CURL                      (and no arguments)
dnl
dnl [[deprecating]] HGTW_CHECK_CURL    (and no arguments)
dnl  [[deprecated]] SCOLD_CHECK_CURL   (and no arguments)
dnl
dnl Hacks:
dnl
dnl   See the curlpp hacks.
dnl
dnl Deprecations:
dnl   The 'HGTW' prefix.
dnl   The 'SCOLD' prefix.
dnl
dnl Side-Effects (definitions of)
dnl
dnl   @CPPFLAGS_curl@
dnl    @CFLAGS_curl@
dnl   @CXXFLAGS_curl@
dnl    @LDFLAGS_curl@
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_CHECK_CURL                      (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_CURL      (and no arguments)
dnl
dnl Validates that curl-devel is available.
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_curl    (not libcurl, though that is the rpm name and the pkg-config name)
dnl     CFLAGS_curl
dnl     CXXFLAGS_curl
dnl     LDFLAGS_curl
dnl
AC_DEFUN([SCOLD_CHECK_CURL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_CURL], [HT_[CHECK]_CURL])
    HT_CHECK_CURL
])
AC_DEFUN([HGTW_CHECK_CURL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_CURL], [HT_[CHECK]_CURL])
    HT_CHECK_CURL
])
AC_DEFUN([HT_CHECK_CURL], [
    AC_REQUIRE([HGTW_WITH_NONSTD_CURL])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    AC_REQUIRE([HGTW_MSG_WARNING])
    dnl AC_REQUIRE([HGTW_MSG_ERROR])
    if test 1 = ${rpm_package_checking:-1} ; then
        if test -n "${nonstd_curl_prefix}" ; then
            if ! rpm -q nonstd-curl-devel 2>/dev/null ; then
                HGTW_MSG_WARNING([nonstd-curl-devel is required])
            fi
        else
            if ! rpm -q libcurl-devel 2>/dev/null ; then
                HGTW_MSG_WARNING([libcurl-devel is required])
            fi
        fi
    fi
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    CPPFLAGS_curl=$(eval ${nonstd_curl_libdir:+PKG_CONFIG_PATH=${nonstd_curl_libdir}/pkgconfig} pkg-config --cflags-only-I libcurl)
    CFLAGS_curl=$(eval ${nonstd_curl_libdir:+PKG_CONFIG_PATH=${nonstd_curl_libdir}/pkgconfig} pkg-config --cflags-only-other libcurl)
    CXXFLAGS_curl=${CFLAGS_curl}
    LDFLAGS_curl=$(eval ${nonstd_curl_libdir:+PKG_CONFIG_PATH=${nonstd_curl_libdir}/pkgconfig} pkg-config --libs libcurl)
    AC_SUBST(CPPFLAGS_curl)
    AC_SUBST(CFLAGS_curl)
    AC_SUBST(CXXFLAGS_curl)
    AC_SUBST(LDFLAGS_curl)
])
