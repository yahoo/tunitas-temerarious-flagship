dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_BOOST                   (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_BOOST   (and no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HGTW_CHECK_BOOST      (and no arguments)
dnl
dnl Validates that boost-devel (boost3) is available.
dnl Does not ensure that boost v3.x is in use (that isn't hard, boost2 is old)
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_boost
dnl     CFLAGS_boost
dnl     CXXFLAGS_boost
dnl     LDFLAGS_boost
dnl
AC_DEFUN([SCOLD_CHECK_BOOST], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_BOOST], [HGTW_[CHECK]_BOOST])
    HGTW_CHECK_BOOST
])

AC_DEFUN([HGTW_CHECK_BOOST], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    AC_REQUIRE([HGTW_WITH_NONSTD_BOOST])
    AC_REQUIRE([HGTW_ENABLE_BOOST_LAYOUT]) dnl as promised in enable-boost-layout.m4
    if test 1 = ${rpm_package_checking:-1} ; then
        if test -n "${nonstd_boost_prefix}" ; then
            if ! rpm -q nonstd-boost-devel 2>/dev/null ; then
                AC_MSG_ERROR([nonstd-boost-devel is required])
            fi
        else
            if ! rpm -q boost-devel 2>/dev/null ; then
                AC_MSG_ERROR([boost-devel is required])
            fi
        fi
    fi
    dnl FIXME - another correct implementation for [SCOLD]_[CHECK]_[BOOST] is available on branch baleful_ballad
    CPPFLAGS_boost="${nonstd_boost_CPPFLAGS}"
    AC_SUBST(CPPFLAGS_boost) 
    CFLAGS_boost="${nonstd_boost_CFLAGS}"
    AC_SUBST(CFLAGS_boost) 
    CXXFLAGS_boost="${nonstd_boost_CXXFLAGS}"
    AC_SUBST(CXXFLAGS_boost) 
    # you must choose the boost library that you will be using on your own
    # e.g. -lboost_program_options or -lboost_system or -lboost_signal
    LDFLAGS_boost="${nonstd_boost_LDFLAGS}"
    AC_SUBST(LDFLAGS_boost) 
])
