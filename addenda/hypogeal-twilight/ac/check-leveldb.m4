dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_LEVELDB                    (no arguments)
dnl [[deprecated]] SCOLD_CHECK_LEVELDB    (no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HGTW_CHECK_LEVELDB      (and no arguments)
dnl
dnl Validates that leveldb-devel is available.
dnl Does not ensure that at least version v1.x.y is used (that isn't hard)
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_leveldb <-------- -DLEVELDB_LEVELDB_HAS_INT64 (WATCHOUT -- you need this)
dnl     CFLAGS_leveldb
dnl     CXXFLAGS_leveldb
dnl     LDFLAGS_leveldb
dnl
AC_DEFUN([SCOLD_CHECK_LEVELDB], [
    AC_MSG_ERROR([use [HGTW]_[CHECK]_[LEVELDB] instead of [SCOLD]_[CHECK]_[LEVELDB]])
])
AC_DEFUN([HGTW_CHECK_LEVELDB], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    AC_REQUIRE([HGTW_WITH_NONSTD_LEVELDB])
    if test xNONE != "x$nonstd_leveldb_prefix" && test x != "x$nonstd_leveldb_prefix"; then
        #
        # e.g.
        # --with-nonstd-leveldb=/opt/leveldb
        #
        # speculatively guess, then check that those directories actually exist
        # [[FIXTHIS]] test for /lib64 to see if this is even relevant
        for l in lib64 lib ; do
            nonstd_leveldb_libdir="$nonstd_leveldb_prefix/$l"
            if test -d $nonstd_leveldb_libdir ; then
                __pkgconfigdir="${nonstd_leveldb_libdir}/pkgconfig"
                HGTW_MSG_VERBOSE([using the leveldb libraries in ${nonstd_leveldb_libdir?} via ${__pkgconfigdir?}])
                HGTWinternal_CHECK_LEVELDB_PKG_CONFIG_INSTALLED_LEVELDB([PKG_CONFIG_PATH=${__pkgconfigdir?}])
                break
            fi
        done
        # check the libdir that we speculatively assigned, above
        for dir in "$nonstd_leveldb_prefix" "$nonstd_leveldb_libdir" ; do
            if  test ! -d "$dir" ; then
                AC_MSG_ERROR([missing directory $dir is required for leveldb])
            fi
        done
    else
        if test 0 == ${rpm_package_checking:-0}; then
            HGTW_MSG_WARNING([NOT checking for the presence of the rpm leveldb-devel])
            leveldb_VERSION=UNKNOWN
        else
            #
            # Must be the system-installed one, or the nonstd-installed one
            #
            if test -n "${nonstd_leveldb_prefix}" ; then
                if ! rpm -q nonstd-leveldb-devel 2>/dev/null ; then
                    AC_MSG_ERROR([nonstd-leveldb-devel is required])
                fi
                leveldb_VERSION=$(rpm -q nonstd-leveldb-devel)
            else
                if ! rpm -q leveldb-devel 2>/dev/null ; then
                    AC_MSG_ERROR([leveldb-devel is required])
                fi
                leveldb_VERSION=$(rpm -q leveldb-devel)
            fi
        fi
        #
        # You need at least leveldb-1.20
        #                   leveldb-1.19 is unknown
        #                   leveldb-1.18 will not do work
        #
        HGTWinternal_CHECK_LEVELDB_PKG_CONFIG_INSTALLED_LEVELDB([])
    fi
    # [[current]]
    AC_SUBST(CPPFLAGS_leveldb) 
    AC_SUBST(CFLAGS_leveldb) 
    AC_SUBST(CXXFLAGS_leveldb) 
    AC_SUBST(LDFLAGS_leveldb) 
])

dnl
dnl HGTWinternal_CHECK_LEVELDB_PKG_CONFIG_INSTALLED_LEVELDB of 1 argument, which may be empty
dnl run pkg-config to acquire the leveldb settings
dnl
dnl $1 - setting of PKG_CONFIG_PATH
dnl
dnl Examples:
dnl     $1 - []  (empty)
dnl     $1 - PKG_CONFIG_PATH=/opt/leveldb/lib64/pkgconfig
dnl
AC_DEFUN([HGTWinternal_CHECK_LEVELDB_PKG_CONFIG_INSTALLED_LEVELDB], [
    external_leveldb=
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    function __pkg_config() {
        local flag=[$][1]; shift
        # without print-errors, only an exit code is emitted when problems occur.
        $1 pkg-config --print-errors --$flag leveldb
    }
    if ! __pkg_config path ; then
        AC_MSG_ERROR([pkg-config cannot find leveldb])
    fi
    # WATCHOUT - pkg-config will exit nonzero but produce nothing when it encounters an error.
    # Countermeasure: do the work twice so we can examine error codes, then capture any output on the 2nd pass.
    if ! { # FIXME - get rid of the copied code herein
           __pkg_config cflags > /dev/null &&
           __pkg_config cflags-only-I > /dev/null &&
           __pkg_config cflags-only-other > /dev/null &&
           __pkg_config libs > /dev/null &&
           __pkg_config libs-only-l > /dev/null &&
           __pkg_config libs-only-other > /dev/null &&
           __pkg_config libs-only-L > /dev/null
    } then
        AC_MSG_ERROR([$1 pkg-config fails])
    fi 
    CPPFLAGS_leveldb=$(__pkg_config cflags-only-I)
    CFLAGS_leveldb=$(__pkg_config cflags-only-other)
    CXXFLAGS_leveldb="${CFLAGS_leveldb}"
    __libs_only_l=$(__pkg_config libs-only-l)
    __libs_only_other=$(__pkg_config libs-only-other)
    __libs_only_L=$(__pkg_config libs-only-L)
    # change -L/opt/nonstd/leveldb/lib64 -> (the pair) -L/opt/nonstd/leveldb/lib64 -Wl,-rpath=/opt/nonstd/leveldb/lib64
    __libs_only_L_with_rpath="$(for L in ${__libs_only_L} ; do echo "${L?} -Wl,-rpath=${L#-L}" ; done)"
    LDFLAGS_leveldb="${__libs_only_L_with_rpath} ${__libs_only_other} ${__libs_only_l}"
])
