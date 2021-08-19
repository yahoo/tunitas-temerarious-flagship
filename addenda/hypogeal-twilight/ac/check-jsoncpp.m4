dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_JSONCPP                    (no arguments)
dnl
dnl [[deprecated]] SCOLD_CHECK_JSONCPP    (no arguments)
dnl [[deprecated]] SCOLD_CHECK_JSON       (no arguments)
dnl
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl prevent avoidable confusion
AC_DEFUN([SCOLD_CHECK_JSON], [
    AC_MSG_ERROR([use [HGTW]_[CHECK]_[JSONCPP] instead of [SCOLD]_[CHECK]_[JSON]])
])

dnl HGTW_CHECK_JSONCPP      (and no arguments)
dnl
dnl Validates that jsoncpp-devel is available.
dnl Ensures the 64-bit API is available.
dnl Does not ensure that at least version v1.x.y is used (that isn't hard)
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_jsoncpp <-------- -DJSONCPP_JSON_HAS_INT64 (WATCHOUT -- you need this)
dnl     CFLAGS_jsoncpp
dnl     CXXFLAGS_jsoncpp
dnl     LDFLAGS_jsoncpp
dnl
AC_DEFUN([SCOLD_CHECK_JSONCPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_JSONCPP], [HGTW_[CHECK]_JSONCPP])
    HGTW_CHECK_JSONCPP
])
AC_DEFUN([HGTW_CHECK_JSONCPP], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    AC_REQUIRE([HGTW_WITH_NONSTD_JSONCPP])
    if test xNONE != "x$nonstd_jsoncpp_prefix" && test x != "x$nonstd_jsoncpp_prefix"; then
        #
        # e.g.
        # --with-nonstd-jsoncpp=/opt/jsoncpp
        #
        # speculatively guess, then check that those directories actually exist
        # [[FIXTHIS]] test for /lib64 to see if this is even relevant
        for l in lib64 lib ; do
            nonstd_jsoncpp_libdir="$nonstd_jsoncpp_prefix/$l"
            if test -d $nonstd_jsoncpp_libdir ; then
                __pkgconfigdir="${nonstd_jsoncpp_libdir}/pkgconfig"
                HGTW_MSG_VERBOSE([using the jsoncpp libraries in ${nonstd_jsoncpp_libdir?} via ${__pkgconfigdir?}])
                HGTWinternal_CHECK_JSONCPP_PKG_CONFIG_INSTALLED_JSONCPP([PKG_CONFIG_PATH=${__pkgconfigdir?}])
                break
            fi
        done
        # check the libdir that we speculatively assigned, above
        for dir in "$nonstd_jsoncpp_prefix" "$nonstd_jsoncpp_libdir" ; do
            if  test ! -d "$dir" ; then
                AC_MSG_ERROR([missing directory $dir is required for jsoncpp])
            fi
        done
    else
        if test 0 == ${rpm_package_checking:-0}; then
            HGTW_MSG_WARNING([NOT checking for the presence of the rpm jsoncpp-devel])
            jsoncpp_VERSION=UNKNOWN
        else
            #
            # Must be the system-installed one, or the nonstd-installed one
            #
            if test -n "${nonstd_jsoncpp_prefix}" ; then
                if ! rpm -q nonstd-jsoncpp-devel 2>/dev/null ; then
                    AC_MSG_ERROR([nonstd-jsoncpp-devel is required])
                fi
                jsoncpp_VERSION=$(rpm -q nonstd-jsoncpp-devel)
            else
                if ! rpm -q jsoncpp-devel 2>/dev/null ; then
                    AC_MSG_ERROR([jsoncpp-devel is required])
                fi
                jsoncpp_VERSION=$(rpm -q jsoncpp-devel)
            fi
        fi
        #
        # FIXME - some but not all of this belongs in vernacular-doggerel rpm/macros.nonstd_jsoncpp
        # WATCHOUT you want jsoncpp-1.x
        #
        # Fedora 19 has problematic   jsoncpp-devel-0.6.0-0.9.rc2.fc19.x86_64
        # Fedora 24 has acceptable    jsoncpp-devel-1.7.2-3.fc24.x86_64
        #
        # <strike>One has to turn on 64-bit aspect forcibly; it doesn't "just detect it."</strike>
        #
        # <json/config.h>
        # json-0.x series has /usr/include/jsoncpp/json/config.h  but -I/usr/include/jsoncpp/ from pkg-config
        # json-1.x series has /usr/include/json/config.h          and no special -I from pkg-config
        #
        # And internally the jsoncpp-1.7 series has -DJSON_HAS_RVALUE_REFERENCES
        #                the jsoncpp-1.6 series does not support rvalue references
        #
        # You need at least jsoncpp-1.7
        #
        HGTWinternal_CHECK_JSONCPP_PKG_CONFIG_INSTALLED_JSONCPP([])
    fi
    # [[current]]
    AC_SUBST(CPPFLAGS_jsoncpp) 
    AC_SUBST(CFLAGS_jsoncpp) 
    AC_SUBST(CXXFLAGS_jsoncpp) 
    AC_SUBST(LDFLAGS_jsoncpp) 
    # [[deprecated]] always set the 'external' variables, even if unused and empty
    # [[deprecated]] nobody should be using these any more
    AC_SUBST(external_jsoncpp) 
    AC_SUBST(CPPFLAGS_external_jsoncpp) 
    AC_SUBST(CFLAGS_external_jsoncpp) 
    AC_SUBST(CXXFLAGS_external_jsoncpp) 
    AC_SUBST(LDFLAGS_external_jsoncpp) 
])

dnl
dnl HGTWinternal_CHECK_JSONCPP_PKG_CONFIG_INSTALLED_JSONCPP of 1 argument, which may be empty
dnl run pkg-config to acquire the jsoncpp settings
dnl
dnl $1 - setting of PKG_CONFIG_PATH
dnl
dnl Examples:
dnl     $1 - []  (empty)
dnl     $1 - PKG_CONFIG_PATH=/opt/jsoncpp/lib64/pkgconfig
dnl
AC_DEFUN([HGTWinternal_CHECK_JSONCPP_PKG_CONFIG_INSTALLED_JSONCPP], [
    external_jsoncpp=
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    function __pkg_config() {
        local flag=[$][1]; shift
        # without print-errors, only an exit code is emitted when problems occur.
        $1 pkg-config --print-errors --$flag jsoncpp
    }
    if ! __pkg_config path jsoncpp ; then
        AC_MSG_ERROR([pkg-config cannot find jsoncpp])
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
    CPPFLAGS_jsoncpp=$(__pkg_config cflags-only-I)
    CFLAGS_jsoncpp=$(__pkg_config cflags-only-other)
    CXXFLAGS_jsoncpp="${CFLAGS_jsoncpp}"
    __libs_only_l=$(__pkg_config libs-only-l)
    __libs_only_other=$(__pkg_config libs-only-other)
    __libs_only_L=$(__pkg_config libs-only-L)
    # change -L/opt/nonstd/jsoncpp/lib64 -> (the pair) -L/opt/nonstd/jsoncpp/lib64 -Wl,-rpath=/opt/nonstd/jsoncpp/lib64
    __libs_only_L_with_rpath="$(for L in ${__libs_only_L} ; do echo "${L?} -Wl,-rpath=${L#-L}" ; done)"
    LDFLAGS_jsoncpp="${__libs_only_L_with_rpath} ${__libs_only_other} ${__libs_only_l}"
])
