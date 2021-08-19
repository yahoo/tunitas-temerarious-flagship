dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_UUID                      (and no arguments)
dnl [[deprecated]] SCOLD_CHECK_UUID      (and no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Purpose:
dnl   derives SUBST and shell variables
dnl   CPPFLAGS_uuid, CFLAGS_uuid, CXXFLAGS_uuid, LDFLAGS_uuid.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_CHECK_UUID                     (and no arguments)
dnl [[deprecated]] HGTW_CHECK_UUID      (and no arguments)
dnl
dnl Validates that uuid-devel is available.
dnl Ensures the 64-bit API is available.
dnl Does not ensure that at least version v1.x.y is used (that isn't hard)
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_uuid <-------- -Duuid_JSON_HAS_INT64 (WATCHOUT -- you need this)
dnl     CFLAGS_uuid
dnl     CXXFLAGS_uuid
dnl     LDFLAGS_uuid
dnl
AC_DEFUN([SCOLD_CHECK_UUID], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_UUID], [HGTW_[CHECK]_UUID])
    HGTW_CHECK_UUID
])
AC_DEFUN([HGTW_CHECK_UUID], [
    AC_REQUIRE([HGTW_WITH_NONSTD_UUID])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    if test 1 = ${rpm_package_checking:-1} ; then
        #
        # the "nonstd-uuid" package is our invention
        # as such it doesn't follow the "uuid" vs "libuuid" battle.
        #
        if test -n "${nonstd_uuid_prefix}" ; then
            if ! rpm -q nonstd-uuid-devel 2>/dev/null ; then
                AC_MSG_ERROR([nonstd-uuid-devel is required])
            fi
        else
            #
            # USE -----> libuuid-devel has uuid.pc
            # USE -----> libuuid-devel-2.24.2-1.fc20.x86_64
            #
            # AVOID ---> uuid-devel does not have uuid.pc or any pkgconfig support
            # AVOID ---> uuid-devel-1.6.2-21.fc20.x86_64
            #
            # WATCHOUT - package 'libuuid' has pkgconfig named 'uuid.pc' (not libuuid.pc)
            # rpm -q -f /usr/lib64/pkgconfig/uuid.pc 
            # libuuid-devel-2.24.2-1.fc20.x86_64
            #
            if ! rpm -q libuuid-devel 2>/dev/null ; then
                AC_MSG_ERROR([libuuid-devel is required])
            fi
        fi
    fi
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    # peskily, this will supply -I/usr/include/uuid ... they pollute the space with their own
    CPPFLAGS_uuid=$(eval ${nonstd_uuid_libdir:+PKG_CONFIG_PATH=${nonstd_uuid_libdir}/pkgconfig} pkg-config --cflags-only-I uuid)
    CFLAGS_uuid=$(eval ${nonstd_uuid_libdir:+PKG_CONFIG_PATH=${nonstd_uuid_libdir}/pkgconfig} pkg-config --cflags-only-other uuid)
    CXXFLAGS_uuid=${CFLAGS_uuid}
    LDFLAGS_uuid=$(eval ${nonstd_uuid_libdir:+PKG_CONFIG_PATH=${nonstd_uuid_libdir}/pkgconfig} pkg-config --libs uuid)
    AC_SUBST(CPPFLAGS_uuid) 
    AC_SUBST(CFLAGS_uuid) 
    AC_SUBST(CXXFLAGS_uuid) 
    AC_SUBST(LDFLAGS_uuid) 
])
