dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_SQLITE                      (and no arguments)
dnl
dnl [[deprecated]] SCOLD_CHECK_SQLITE      (and no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Environment:
dnl   Expecting at least sqlite-devel-3.26.0-1.fc29.x86_64
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_CHECK_SQLITE                      (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_SQLITE      (and no arguments)
dnl
dnl Validates that sqlite-devel (sqlite3) is available.
dnl Does not ensure that sqlite v3.x is in use (that isn't hard, sqlite2 is old)
dnl
dnl WATCHOUT the package name is 'sqlite' the pkg-config is 'sqlite3'
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_sqlite
dnl     CFLAGS_sqlite
dnl     CXXFLAGS_sqlite
dnl     LDFLAGS_sqlite
dnl
AC_DEFUN([SCOLD_CHECK_SQLITE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_SQLITE], [HGTW_[CHECK]_SQLITE])
    HGTW_CHECK_SQLITE
])
AC_DEFUN([HGTW_CHECK_SQLITE], [
    AC_REQUIRE([HGTW_WITH_NONSTD_SQLITE])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    if test 1 = ${rpm_package_checking:-1} ; then
        if test -n "${nonstd_sqlite_prefix}" ; then
            if ! rpm -q nonstd-sqlite-devel 2>/dev/null ; then
                AC_MSG_ERROR([nonstd-sqlite-devel is required])
            fi
        else
            if ! rpm -q sqlite-devel 2>/dev/null ; then
                AC_MSG_ERROR([sqlite-devel is required])
            fi
        fi
    fi
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    CPPFLAGS_sqlite=$(eval ${nonstd_sqlite_libdir:+PKG_CONFIG_PATH=${nonstd_sqlite_libdir}/pkgconfig} pkg-config --cflags-only-I sqlite3)
    AC_SUBST(CPPFLAGS_sqlite) 
    CFLAGS_sqlite=$(eval ${nonstd_sqlite_libdir:+PKG_CONFIG_PATH=${nonstd_sqlite_libdir}/pkgconfig} pkg-config --cflags-only-other sqlite3)
    AC_SUBST(CFLAGS_sqlite) 
    CXXFLAGS_sqlite=${CFLAGS_sqlite}
    AC_SUBST(CXXFLAGS_sqlite) 
    LDFLAGS_sqlite=$(eval ${nonstd_sqlite_libdir:+PKG_CONFIG_PATH=${nonstd_sqlite_libdir}/pkgconfig} pkg-config --libs sqlite3)
    AC_SUBST(LDFLAGS_sqlite) 
])
