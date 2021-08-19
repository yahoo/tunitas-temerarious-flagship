dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_CHECK_CPPUNIT                      (and no arguments)
dnl
dnl [[deprecated]] HGTW_CHECK_CPPUNIT     (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_CPPUNIT    (and no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Purpose:
dnl   derives SUBST and shell variables
dnl   CPPFLAGS_cppunit, CFLAGS_cppunit, CXXFLAGS_cppunit, LDFLAGS_cppunit.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HT_CHECK_CPPUNIT                      (and no arguments)
dnl
dnl [[deprecated]] HGTW_CHECK_CPPUNIT     (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_CPPUNIT    (and no arguments)
dnl
dnl Validates that cppunit-devel (cppunit3) is available.
dnl Does not ensure that cppunit v3.x is in use (that isn't hard, cppunit2 is old)
dnl
dnl Inputs: (the following are considered)
dnl
dnl     nonstd_cppunit_CPPFLAGS
dnl     nonstd_cppunit_CFLAGS
dnl     nonstd_cppunit_CXXFLAGS
dnl     nonstd_cppunit_LDFLAGS
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_cppunit
dnl     CFLAGS_cppunit
dnl     CXXFLAGS_cppunit
dnl     LDFLAGS_cppunit
dnl
AC_DEFUN([SCOLD_CHECK_CPPUNIT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_CPPUNIT], [HT_[CHECK]_CPPUNIT])
    HT_CHECK_CPPUNIT
])
AC_DEFUN([HGTW_CHECK_CPPUNIT], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED([SCOLD_[CHECK]_CPPUNIT], [HT_[CHECK]_CPPUNIT])
    HT_CHECK_CPPUNIT
])
AC_DEFUN([HT_CHECK_CPPUNIT], [
    AC_REQUIRE([HT_WITH_CPPUNIT])
    AC_REQUIRE([HT_WITH_NONSTD_CPPUNIT])
    AC_REQUIRE([HT_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    if test no = ${with_cppunit:-no} ; then
        AC_MSG_NOTICE([not compiling with CppUnit at all])
    else
        if test 1 = ${rpm_package_checking:-1} ; then
            if test -n "$nonstd_cppupnit_prefix" ; then
                HGTW_MSG_VERBOSE([using nonstandard CppUnit at ${nonstd_cppupnit_prefix:-unset}])
                # see  nonstd_cppunit_${TOOL}FLAGS for $TOOL in { CPP, C, CXX, LD } area already set
                # also nonstd_cppunit_PKG_CONFIG_PATH is set
            else
                if test -n "${nonstd_cppunit_prefix}" ; then
                    if ! rpm -q nonstd-cppunit-devel 2>/dev/null ; then
                        AC_MSG_ERROR([nonstd-cppunit-devel is required])
                    fi
                else
                    if ! rpm -q cppunit-devel 2>/dev/null ; then
                        AC_MSG_ERROR([cppunit-devel is required])
                    fi
                fi
            fi
        fi
        AC_MSG_NOTICE([CppUnit provides compilation options via the pkgconfig system])
        if ! type -p pkg-config > /dev/null 2>&1 ; then
            AC_MSG_ERROR([pkg-config is missing])
        fi
        function __cppunit_pkg_config() {
            # And yet, this still does not recover -I or -L settings for nonstd-cppunit
            #          so we have to establish those ourselves, separately
            # Whereas lib or lib64?  There is no "safe" default value for PKG_CONFIG_PATH so just choose '.'
            dnl WATCHOUT - "$@" gets substituted down to "" unless m4-quoted
            local value="${nonstd_cppunit_PKG_CONFIG_PATH:+$nonstd_cppunit_PKG_CONFIG_PATH:}${PKG_CONFIG_PATH:-.}"
            PKG_CONFIG_PATH="$value" pkg-config "[$][@]"
        }
        #
        # The expectation is that pkg-config is "almost" a solution
        #
        # 'pkg-config --cflags'
        #     produces all relevant compiler and searchpath
        #     these options are suitable for C and also C++
        #     this output SHOULD contain at least the value in ${nonstd_cppunit_CPPFLAGS}
        #
        # 'pkg-config --libs'
        #     produces ALMOST all relevant linker flags
        #     it omits "-Wl,-rpath=${libdir}"
        #              because <strike>they focused on Windows portability, not modern Linux shared library gymnastics</strike>
        #              because they expect you to install in standard areas and use ldconfig
        #     this output SHOULD contain at least the value in ${nonstd_cppunit_LDFLAGS}
        #
        CPPFLAGS_cppunit=$(__cppunit_pkg_config --cflags-only-I cppunit) 
        CFLAGS_cppunit="${nonstd_cppunit_CFLAGS}" dnl ERROR ... cppunit is C++ only
        CXXFLAGS_cppunit=$(__cppunit_pkg_config --cflags-only-other cppunit)
        LDFLAGS_cppunit=$(__cppunit_pkg_config --libs cppunit)
    fi
    AC_SUBST(CPPFLAGS_cppunit) 
    AC_SUBST(CFLAGS_cppunit) 
    AC_SUBST(CXXFLAGS_cppunit) 
    AC_SUBST(LDFLAGS_cppunit) 
])
