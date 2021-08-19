dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_APACHE_HTTPD      (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_APACHE_HTTPD      (and no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HGTW_CHECK_APACHE_HTTPD      (and no arguments)
dnl
dnl Validates that httpd-devel (httpd3) is available.
dnl Does not ensure that httpd v3.x is in use (that isn't hard, httpd2 is old)
dnl
dnl WATCHOUT the package name is 'httpd' the pkg-config is 'httpd3'
dnl
dnl Postcondition: (the following are set)
dnl
dnl SUBST for use in a Makefile
dnl
dnl     CPPFLAGS_apr
dnl     CFLAGS_apr
dnl     CXXFLAGS_apr
dnl     LDFLAGS_apr
dnl
dnl     CPPFLAGS_httpd
dnl     CFLAGS_httpd
dnl     CXXFLAGS_httpd
dnl     LDFLAGS_httpd
dnl
dnl     CPPFLAGS_apreq
dnl     CFLAGS_apreq
dnl     CXXFLAGS_apreq
dnl     LDFLAGS_apreq
dnl
dnl CPP definitions
dnl
dnl     _HTTPD_MAJOR__
dnl    __HTTPD_MINOR__
dnl    __HTTPD_PATCH__
dnl    HTTPD_VERSION
dnl    HTTPD_VERSION_STRING
dnl
AC_DEFUN([SCOLD_CHECK_APACHE_HTTPD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_[APACHE]_HTTPD],
                        [HGTW_[CHECK]_[APACHE]_HTTPD])
    HGTW_CHECK_APACHE_HTTPD
])
AC_DEFUN([HGTW_CHECK_APACHE_HTTPD], [
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTWinternal_CHECK_APR
    HGTWinternal_CHECK_APREQ
    HGTWinternal_CHECK_HTTPD
])

AC_DEFUN([HGTWinternal_CHECK_APR], [
    # Apache Runtime
    if test 1 = ${rpm_package_checking:-1} ; then
        if ! rpm -q apr-devel ; then
           AC_MSG_ERROR([need apr-devel])
        fi
    fi
    CPPFLAGS_apr=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --cflags-only-I apr-1)
    CFLAGS_apr=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --cflags-only-other apr-1)
    CXXFLAGS_apr=${CFLAGS_apr}
    LDFLAGS_apr=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --libs apr-1)
    AC_SUBST([CPPFLAGS_apr])
    AC_SUBST([CFLAGS_apr])
    AC_SUBST([CXXFLAGS_apr])
    AC_SUBST([LDFLAGS_apr])
])
AC_DEFUN([HGTWinternal_CHECK_APREQ], [
    #
    # Apache Request
    if test 1 = ${rpm_package_checking:-1} ; then
        if ! rpm -q libapreq2-devel ; then
           AC_MSG_ERROR([need libapreq2-devel])
        fi
    fi
    # WATCHOUT  WATCHOUT  WATCHOUT  WATCHOUT  WATCHOUT  WATCHOUT  WATCHOUT  WATCHOUT 
    # on Fedora 24 (libapreq2-2.13-22.fc24.x86_64)
    # the package is hardcoded with mention
    # of "redhat-hardened-cc1" which is not installed or installable.
    #
    # Oh my the horror, the horror.
    # That's way too much.  Stamp it out.
    #
    # to wit:
    #     -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
    #     -O2
    #     -g
    #     -pipe
    #
    if false; then
        #
        # pkg-config --cflags libapreq2
        # Fedora 19       libapreq2-2.13-11.fc19.x86_64     -DLINUX=2 -D_REENTRANT -D_GNU_SOURCE -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -fno-strict-aliasing -I/usr/include/apr-1  
        # Fedora 23       libapreq2-2.13-20.fc23.x86_64     -DLINUX -D_REENTRANT -D_GNU_SOURCE -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic -fno-strict-aliasing -I/usr/include/apr-1 
        # Fedora 24       libapreq2-2.13-22.fc24.x86_64     -DLINUX -D_REENTRANT -D_GNU_SOURCE -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector-strong --param=ssp-buffer-size=4 -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -m64 -mtune=generic -fno-strict-aliasing -I/usr/include/apr-1
        #
        CPPFLAGS_apr=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --cflags-only-I libapreq2)
        CFLAGS_apr=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --cflags-only-other libapreq2)
        CXXFLAGS_apr=${CFLAGS_apr}
        LDFLAGS_apreq=$(eval ${nonstd_apache_httpd_libdir:+PKG_CONFIG_PATH=${nonstd_apache_httpd_libdir}/pkgconfig} pkg-config --libs libapreq2)
    fi
    AC_SUBST([CPPFLAGS_apreq])
    AC_SUBST([CFLAGS_apreq])
    AC_SUBST([CXXFLAGS_apreq])
    AC_SUBST([LDFLAGS_apreq])
])
AC_DEFUN([HGTWinternal_CHECK_HTTPD], [
    #
    # Apache httpd
    if test 1 = ${rpm_package_checking:-1} ; then
        if ! rpm -q httpd-devel ; then
           AC_MSG_ERROR([need httpd-devel])
        fi
        # Specimen
        # $ rpm -q httpd-devel
        # httpd-devel-2.4.10-1.fc19.x86_64
        httpd_VERSION=$(rpm -q httpd-devel)
    else
        # How else would we guess?
        httpd_VERSION=0.0.0
    fi
    #--->NOT CPPFLAGS_httpd=-I/usr/include/httpd
    CPPFLAGS_httpd=
    LDFLAGS_httpd=
    AC_SUBST([CPPFLAGS_httpd])
    AC_SUBST([CFLAGS_httpd])
    AC_SUBST([CXXFLAGS_httpd])
    AC_SUBST([LDFLAGS_httpd])
    {
        # WATCHOUT - [ ] are the m4 quote characters which cannot be escaped
        # the { } do not affect m4, they only serve to document the extent of the quote reassignment need
        changequote(<,>)dnl
        httpd_MAJOR_NUMBER=$(expr "${httpd_VERSION}" : "^[^0-9]*-\([0-9][0-9]*\)\.[0-9][0-9]*\..*" || echo -n "FAIL ${httpd_VERSION:-empty}")
        httpd_MINOR_NUMBER=$(expr "${httpd_VERSION}" : "^[^0-9]*-[0-9][0-9]*\.\([0-9][0-9]*\)\..*" || echo -n "FAIL ${httpd_VERSION:-empty}")
        httpd_PATCH_NUMBER=$(expr "${httpd_VERSION}" : "^[^0-9]*-[0-9][0-9]*\.[0-9][0-9]*\.\([0-9][0-9]*\).*" || echo -n "FAIL ${httpd_VERSION:-empty}")
        changequote([,])dnl
        httpd_VERSION_REDERIVED="${httpd_MAJOR_NUMBER:-ERROR}.${httpd_MINOR_NUMBER:-ERROR}.${httpd_PATCH_NUMBER:-ERROR}"
        httpd_VERSION_STRING="v${httpd_VERSION_REDERIVED:-ERROR}"
    }
    HGTW_MSG_VERBOSE([the httpd version is ${httpd_VERSION_REDERIVED:-ERROR}])
    AC_DEFINE_UNQUOTED([__HTTPD_MAJOR__], $httpd_MAJOR_NUMBER, [httpd major version number])
    AC_DEFINE_UNQUOTED([__HTTPD_MINOR__], $httpd_MINOR_NUMBER, [httpd minor version number])
    AC_DEFINE_UNQUOTED([__HTTPD_PATCH__], $httpd_PATCH_NUMBER, [httpd patch version number])
    AC_DEFINE_UNQUOTED([HTTPD_VERSION], "$httpd_VERSION_REDERIVED", [httpd version as a string])
    AC_DEFINE_UNQUOTED([HTTPD_VERSION_STRING], "$httpd_VERSION_STRING", [httpd version as a v-string])
])
