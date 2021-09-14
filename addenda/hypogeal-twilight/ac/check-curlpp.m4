dnl
dnl HT_CHECK_CURLPP                      (and no arguments)
dnl
dnl [[deprecating]] HGTW_CHECK_CURLPP    (and no arguments)
dnl  [[deprecated]] SCOLD_CHECK_CURLPP   (and no arguments)
dnl
dnl Hacks:
dnl
dnl   The Fedora-series builds of curlpp.pc has unusable LDFLAGS.
dnl
dnl Deprecations:
dnl   The 'HGTW' prefix.
dnl   The 'SCOLD' prefix.
dnl
dnl Side-Effects (definitions of)
dnl
dnl   @CPPFLAGS_curlpp@
dnl     @CFLAGS_curlpp@
dnl   @CXXFLAGS_curlpp@
dnl    @LDFLAGS_curlpp@
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_CHECK_CURLPP                      (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_CURLPP      (and no arguments)
dnl
dnl Validates that curlpp-devel is available.
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_curlpp
dnl     CFLAGS_curlpp
dnl     CXXFLAGS_curlpp
dnl     LDFLAGS_curlpp
dnl
AC_DEFUN([SCOLD_CHECK_CURLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_CURLPP], [HGTW_[CHECK]_CURLPP])
    HT_CHECK_CURLPP
])
AC_DEFUN([HGTW_CHECK_CURLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_CURLPP], [HGTW_[CHECK]_CURLPP])
    HT_CHECK_CURLPP
])
AC_DEFUN([HT_CHECK_CURLPP], [
    AC_REQUIRE([HGTW_CHECK_CURL])
    AC_REQUIRE([HGTW_WITH_NONSTD_CURLPP])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    dnl AC_REQUIRE([HGTW_MSG_ERROR])
    AC_REQUIRE([HGTW_MSG_WARNING])
    AC_REQUIRE([HGTW_MSG_NOTICE])
    AC_REQUIRE([HGTW_MSG_VERBOSE])
    if test 1 = ${rpm_package_checking:-1} ; then
        if test -n "${nonstd_curlpp_prefix}" ; then
            if ! rpm -q nonstd-curlpp-devel 2>/dev/null ; then
                HGTW_MSG_WARNING([nonstd-curlpp-devel is required to remediate an unworkable curlpp.pc])
                HTinternal_DELEGATED_REMEDIATION_NOTICE
            fi
        else
            if ! rpm -q curlpp-devel 2>/dev/null ; then
                HGTW_MSG_WARNING([curlpp-devel is required])
                HTinternal_DELEGATED_REMEDIATION_NOTICE
            fi
        fi
    fi
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    HTinternal_HACK_MKDIR_BROKEN_PKGCONFIG
    CPPFLAGS_curlpp=$(eval ${nonstd_curlpp_libdir:+PKG_CONFIG_PATH=${nonstd_curlpp_libdir}/pkgconfig} pkg-config --cflags-only-I curlpp)
    AC_SUBST(CPPFLAGS_curlpp) 
    __clike_flags=$(eval ${nonstd_curlpp_libdir:+PKG_CONFIG_PATH=${nonstd_curlpp_libdir}/pkgconfig} pkg-config --cflags-only-other curlpp)
    CFLAGS_curlpp=${__clike_flags?}
    AC_SUBST(CFLAGS_curlpp) 
    CXXFLAGS_curlpp=${__clike_flags?}
    AC_SUBST(CXXFLAGS_curlpp) 
    LDFLAGS_curlpp=$(eval ${nonstd_curlpp_libdir:+PKG_CONFIG_PATH=${nonstd_curlpp_libdir}/pkgconfig} pkg-config --libs curlpp)
    # Cannot (yet) filter out the badness here.  see filter-out.curlpp.LDFLAGS.mk
    AC_SUBST(LDFLAGS_curlpp) 
])

dnl
dnl WATCHOUT - the use of nonstd-curlpp is basically REQUIRED because libcryptpp.la is botched, having an embedded -Llib64
dnl Witness:
dnl
dnl    $ make check -j1 V=1
dnl    /bin/sh ./libtool  --tag=CXX --verbose  --mode=link g++ ...somehow... -lcurl  -Llib64 -lcurlpp -Wl,-z,relro -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -lcurl ...somehow...
dnl    ./libtool: line 7486: cd: lib64: No such file or directory
dnl    libtool:   error: cannot determine absolute directory name of 'lib64'
dnl
dnl Be loud about this because ... we're doing something (very) ugly and if it doesn't work it will be surprising.
dnl Here use a symlink so that lib and lib64 are "the same thing" because later the LOADPATH computation in .../mk/compile.mk will prefer lib64 over lib when both are available.
dnl That's usually the correct choice, except in the development area where only ./lib is populated.
dnl
AC_DEFUN([HTinternal_HACK_MKDIR_BROKEN_PKGCONFIG], [
    if test -e /usr/lib64 ; then
        HGTW_MSG_NOTICE([making the linking hack around the broken curlpp.pc of many many generations of Fedora builds])
        HGTW_MSG_NOTICE([preferring the lib64 directory right here in ${PWD}])
        if false ; then
            __Gerund=Mkdiring # is that a verb, rly?
            __verb=mkdir
            mkdir -p lib64
        else
            __Gerund=Symlinking
            __verb=symlink
            rmdir lib64 || rm lib64 || : no error on failure
            ln --force --symbolic lib lib64
        fi
        if test 0 != $? ; then
           HGTW_MSG_ERROR([Could not ${__verb} lib and lib64 right here in ${PWD}])
        else
           HGTW_MSG_NOTICE([${__Gerund} lib and lib64 right here in ${PWD}])
        fi
    fi
])

dnl because it is uttered twice
AC_DEFUN([HTinternal_DELEGATED_REMEDIATION_NOTICE], [
    HGTW_MSG_NOTICE([absent a correct curlpp.pc then include .../mk/curlpp.filter-out.LDFLAGS.mk MUST appear in Makefile.am])
])
