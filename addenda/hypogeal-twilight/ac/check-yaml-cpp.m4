dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_CHECK_YAML_CPP      (and no arguments)
dnl
dnl [[deprecating("the prefix 'HGTW_' in favor of 'HT_'")]]
dnl
dnl   HGTW_CHECK_YAML_CPP      (and no arguments)
dnl
dnl avoid mis-naming
dnl
dnl   {HT,HGTW}_CHECK_YAML{,CPP}
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl prevent avoidable confusion
dnl in-the-wild packages names are "yaml-cpp" but "jsoncpp" and "cbor-cpp"
AC_DEFUN([HT_CHECK_YAML],      [AC_MSG_ERROR([use [HT]_[CHECK]_[YAML_CPP] not [HGTW]_[CHECK]_[YAML]])])
AC_DEFUN([HT_CHECK_YAMLCPP],   [AC_MSG_ERROR([use [HT]_[CHECK]_[YAML_CPP] not [HGTW]_[CHECK]_[YAMLCPP]])])
dnl
AC_DEFUN([HGTW_CHECK_YAML],    [AC_MSG_ERROR([use [HT]_[CHECK]_[YAML_CPP] not [HGTW]_[CHECK]_[YAML]])])
AC_DEFUN([HGTW_CHECK_YAMLCPP], [AC_MSG_ERROR([use [HT]_[CHECK]_[YAML_CPP] not [HGTW]_[CHECK]_[YAMLCPP]])])
dnl
AC_DEFUN([HGTW_CHECK_YAML_CPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_YAML_CPP], [HT_[CHECK]_YAML_CPP])
    HT_CHECK_YAML_CPP
])

dnl HGTW_CHECK_YAML_CPP      (and no arguments)
dnl
dnl Validates that yaml-cpp-devel is available.
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_yaml_cpp
dnl     CFLAGS_yaml_cpp
dnl     CXXFLAGS_yaml_cpp
dnl     LDFLAGS_yaml_cpp
dnl
AC_DEFUN([HT_CHECK_YAML_CPP], [
    AC_REQUIRE([SCOLD_ENABLE_CONFIGURE_VERBOSE])
    dnl the prefix is expected from an earlier invocation of HGTW_WITH_MODULE([yaml-cpp])
    if test xNONE != "x$nonstd_yaml_cpp_prefix" && test x != "x$nonstd_yaml_cpp_prefix"; then
        #
        # e.g.
        # --with-nonstd-yaml-cpp=/opt/nonstd/yaml-cpp
        #
        # speculatively guess, then check that those directories actually exist
        for l in lib64 lib ; do
            nonstd_yaml_cpp_libdir="${nonstd_yaml_cpp_prefix?}/$l"
            if test -d $nonstd_yaml_cpp_libdir ; then
                __pkgconfigdir="${nonstd_yaml_cpp_libdir}/pkgconfig"
                SCOLD_MSG_VERBOSE([using the yaml-cpp libraries in ${nonstd_yaml_cpp_libdir?} via ${__pkgconfigdir?}])
                HGTWinternal_CHECK_YAML_CPP_PKG_CONFIG_INSTALLED_YAML_CPP([PKG_CONFIG_PATH=${__pkgconfigdir?}])
                break
            fi
        done
        # check the libdir that we speculatively assigned, above
        for dir in "$nonstd_yaml_cpp_prefix" "$nonstd_yaml_cpp_libdir" ; do
            if  test ! -d "$dir" ; then
                AC_MSG_ERROR([missing directory $dir is required for yaml-cpp])
            fi
        done
    else
        #
        # Must be the system-installed one
        #
        if ! rpm -q yaml-cpp-devel 2>/dev/null ; then
            AC_MSG_ERROR([yaml-cpp-devel is required])
        fi
        yaml_cpp_VERSION=$(rpm -q yaml-cpp-devel)
        #
        # FIXME - some but not all of this belongs in vernacular-doggerel rpm/macros.nonstd_yaml_cpp
        # WATCHOUT you want yaml-cpp-0.6.x, but may have to live with yaml-cpp-0.5.x
        #
        #    Fedora 27 yaml-cpp-0.5.x
        #    Fedora 28 yaml-cpp-0.5.x
        #    HEAD      past yaml-cpp-0.6   at https://github.com/jbeder/yaml-cpp/
        #
        # You need at least yaml-cpp-0.5
        #
        HGTWinternal_CHECK_YAML_CPP_PKG_CONFIG_INSTALLED_YAML_CPP([])
    fi
    AC_SUBST(CPPFLAGS_yaml_cpp)
    AC_SUBST(CFLAGS_yaml_cpp) 
    AC_SUBST(CXXFLAGS_yaml_cpp) 
    AC_SUBST(LDFLAGS_yaml_cpp)
])

dnl
dnl HGTWinternal_CHECK_YAML_CPP_PKG_CONFIG_INSTALLED_YAML_CPP of 1 argument, which may be empty
dnl run pkg-config to acquire the yaml-cpp settings
dnl
dnl $1 - setting of PKG_CONFIG_PATH
dnl
dnl Examples:
dnl     $1 - []  (empty)
dnl     $1 - PKG_CONFIG_PATH=/opt/yaml-cpp/lib64/pkgconfig
dnl
AC_DEFUN([HGTWinternal_CHECK_YAML_CPP_PKG_CONFIG_INSTALLED_YAML_CPP], [
    if ! type -p pkg-config > /dev/null 2>&1 ; then
        AC_MSG_ERROR([pkg-config is missing])
    fi
    if ! pkg-config --print-errors yaml-cpp ; then
        AC_MSG_ERROR([pkg-config cannot find yaml-cpp])
    fi
    function __pkg_config() {
        local flag=[$][1]; shift
        # without print-errors, only an exit code is emitted when problems occur.
        $1 pkg-config --print-errors --$flag yaml-cpp
    }
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
    CPPFLAGS_yaml_cpp=$(__pkg_config cflags-only-I)
    CFLAGS_yaml_cpp=$(__pkg_config cflags-only-other)
    CXXFLAGS_yaml_cpp="${CFLAGS_yaml_cpp}"
    __libs_only_l=$(__pkg_config libs-only-l)
    __libs_only_other=$(__pkg_config libs-only-other)
    __libs_only_L=$(__pkg_config libs-only-L)
    # change -L/opt/nonstd/yaml_cpp/lib64 -> (the pair) -L/opt/nonstd/yaml_cpp/lib64 -Wl,-rpath=/opt/nonstd/yaml_cpp/lib64
    __libs_only_L_with_rpath="$(for L in ${__libs_only_L} ; do echo "${L?} -Wl,-rpath=${L#-L}" ; done)"
    LDFLAGS_yaml_cpp="${__libs_only_L_with_rpath} ${__libs_only_other} ${__libs_only_l}"
])
