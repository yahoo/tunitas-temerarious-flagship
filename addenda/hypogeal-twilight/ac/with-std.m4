dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_DEFAULT_STD_VALUES                      (no arguments)
dnl [[deprecated]] SCOLD_DEFAULT_STD_VALUES      (no arguments)
dnl
dnl HGTW_WITH_STD(name-dashes, name_underscores, [explanation])
dnl [[deprecated]] SCOLD_WITH_STD(name-dashes, name_underscores, [explanation])
dnl
dnl HGTW_WITH_STD_SCOLD          (no arguments)
dnl
dnl Possible usages:
dnl
dnl    HGTW_WITH_STD_SCOLD
dnl    HGTW_WITH_STD(scold, scold, [The standard SCOLD toolset and module areas])
dnl
dnl the word 'std' is prefixed to the names; e.g. std-scold
dnl
dnl The expectation is that there is but one "standard" area exists
dnl as a unified ROOT or $prefix sort of an areas.
dnl
dnl It is, e.g. /opt/scold, and it has the usual subdirectories of a ROOT.
dnl e.g. /opt/scold/{bin,include,lib,lib64,share/doc,share/man} and so forth.
dnl
dnl There is no way to NOT have a "standard" area.
dnl e.g. there is no meaning for --without-std-scold, it is disallowed.
dnl
dnl --with-nearby
dnl     The disaggregated /build/scold area is the "nearby area"
dnl     it is specified as --with-nearby=/build/scold
dnl --with-siblings
dnl     The disaggregated ${PWD%/*} is the "sibling area", it is expected to be ".."
dnl     it is specified as --with-siblings or --with-siblings=${PWD%/*}
dnl --with-submodules
dnl     The disaggregated ${PWD}/submodules is the "submodules area", it is expected to be "./submodules"
dnl     it is specified as --with-submodules or --with-submodules=${PWD}/submodules
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_DEFAULT_STD_VALUES              (no arguments)
dnl
AC_DEFUN([SCOLD_DEFAULT_STD_VALUES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[DEFAULT]_[STD]_VALUES], [HGTW_[DEFAULT]_[STD]_VALUES])
    HGTW_DEFAULT_STD_VALUES
])
AC_DEFUN([HGTW_DEFAULT_STD_VALUES], [
    AC_REQUIRE([AC_PREFIX_DEFAULT])
    default_default_prefix=$ac_default_prefix
    default_std_scold_prefix=/opt/scold
    : default_std_EXAMPLE_prefix=$default_default_prefix
])

dnl HGTW_WITH_STD_SCOLD        (no arguments)
dnl
dnl A zero-argument macros so that it can be used in AC_DEFUN
dnl
AC_DEFUN([HGTW_WITH_STD_SCOLD], [
    HGTW_WITH_STD([scold], [scold], [standard S.C.O.L.D. toolset and modules])
])
AC_DEFUN([HGTW_WITH_ANGUISH_ANSWER], [
    dnl anguish-answer is definitely deprecated.
    with_anguish_answer=no
    HGTW_WITH_COMPONENT([anguish-answer], [anguish_answer], [the Anguish Answer of the S.C.O.L.D. toolset])
])
AC_DEFUN([HGTW_WITH_BALEFUL_BALLAD], [
    dnl explicit reference to --with-baleful-baleful=DIRECTORY is considered deprecated at this point.
    with_baleful_ballad=no
    HGTW_WITH_COMPONENT([baleful-ballad], [baleful_ballad], [the Baleful Ballad generation of the S.C.O.L.D. toolset])
])

dnl HGTW_WITH_STD(name-dashes, name_underscores, [explanation])
dnl HGTW_WITH_STD($1, $2, $3)
dnl    $1 - argument name-with-dashes          e.g. scold
dnl    $2 - argument name_with_underscores     e.g. scold
dnl    $3 - explanation fragment               e.g. Scalable Object Location Disaggregation (SCOLD), Generation One
dnl
dnl
dnl WATCHOUT - the use of --with-X and --with-std-X is ambiguous and not handled well at all here.
dnl
dnl ... and any other compatibility enhancements that might be relevant
dnl
dnl Examples:
dnl
dnl    HGTW_WITH_STD([scold]) .............................. ambiguous with HGTW_WITH_SUBSYSTEM([scold]] ................ but fortunately there isn't one
dnl    HGTW_WITH_STD([hyperledger-fabric])   ............... ambiguous with HGTW_WITH_SUBSYSTEM([hyperledger-fabric]) ... unfortunately there are both
dnl
AC_DEFUN([SCOLD_WITH_STD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[with]_[STD]], [HGTW_[with]_[STD]])
    HGTW_WITH_STD([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_STD], [
    AC_ARG_ENABLE([$1],
                  [AS_HELP_STRING([--enable-$1], [ERROR use --with-std-$1=ROOT])],
                  [AC_MSG_ERROR([use --with-std-$1=$enableval, check ${CONFIG_SITE:-CONFIG_SITE}])])
    AC_ARG_WITH([$1],
                [AS_HELP_STRING([--with-$1], [ERROR use --with-std-$1=ROOT])],
                [AC_MSG_ERROR([instead of --with-$1=$withval, use --with-std-$1=$withval, check CONFIG_SITE=\$${CONFIG_SITE:-unset} or ./config.settings (deprecated)])])
    dnl if you need to remap $1, $2 then use m4_ifelse(...)
    HGTWinternal_WITH_NAMED_STD([std-$1], [std_$2], [$3])
])

dnl HGTWinternal_WITH_NAMED_STD(name-dashes, name_underscores, [explanation])
dnl HGTWinternal_WITH_NAMED_STD($1, $2, $3)
dnl    $1 - argument name-with-dashes          e.g. std-name-pattern
dnl    $2 - argument name_with_underscores     e.g. std-name_pattern
dnl    $3 - explanation fragment               e.g. Non-Standard NAME stuff
dnl
AC_DEFUN([HGTWinternal_WITH_NAMED_STD], [
    AC_REQUIRE([AC_PREFIX_DEFAULT])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_DEFAULT_STD_VALUES])
    AC_ARG_ENABLE([$1],
                  [AS_HELP_STRING([--enable-$1], [ERROR use --with-$1=ROOT])],
                  [AC_MSG_ERROR([use --with-$1=$withval])])
    AC_ARG_WITH([$1],
                [AS_HELP_STRING([--without-$1], [without the $3 development area])])
    AC_MSG_CHECKING([standard subsystem $1])
    if test "x${with_$2}" = "xyes"
    then
        AC_MSG_RESULT([FAIL])
        AC_MSG_ERROR([the option --with-$1=ROOT must specify a path but --with-$1=${with_$2} appears])
    elif test "x${with_$2}" == "xno"
    then
        AC_MSG_RESULT([FAIL])
        AC_MSG_ERROR([the option --with-$1=ROOT must specify a path but --without-$1 or --with-$1=${with_$2:-unset} appears])
    elif test "xNONE" = "x$with_$2" ||
       test "x" = "x$with_$2"
    then
        AC_MSG_RESULT([yes])
        with_$2=${default_$2_prefix:-$default_default_prefix}
        HGTW_MSG_VERBOSE([using the default value ${default_$2_prefix:-unset}, acting as if presented with --with-$1=${with_$2?}])
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1], [${with_$2?}])
    else
        AC_MSG_RESULT([yes])
        HGTW_MSG_VERBOSE([acting as if presented with --with-$1=${with_$2?}, making that choice explicit for possible recursion])
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1], [${with_$2?}])
    fi
    dnl
    dnl FIXME - ensure that --without-std-scold works flawlessly
    dnl
    $2_prefix=${with_$2?}
    dnl
    dnl FIXME - make --without-std-scold actually work
    dnl
    if test -z "${$2_prefix}" || ! test -d ${$2_prefix} ; then
        AC_MSG_ERROR([no directory ${$2_prefix:-unset} exists for --with-$1=${$2_prefix:-unset}])
    fi
    std_include=${$2_prefix}/include
    if test ! -d $std_include
    then
        AC_MSG_WARN([the directory ${std_include} is missing])
    fi
    std_modules=${$2_prefix}/modules
    if test ! -d $std_modules
    then
        AC_MSG_WARN([the directory ${std_modules} is missing])
    fi
    {
        $2_bindir=${$2_prefix}/bin
        if test ! -d ${$2_bindir?}
        then
            # just a notice, not a warning
            AC_MSG_NOTICE([the directory ${$2_bindir?} is missing])
        fi
        HGTW_MSG_VERBOSE([the (executable) path is ${$2_bindir?}])
    }; {
        $2_includedir=${$2_prefix}/include
        if test ! -d ${$2_includedir?}
        then
            AC_MSG_WARN([the directory ${$2_includedir?} is missing])
        fi
        HGTW_MSG_VERBOSE([the searchpath will include ${$2_includedir?}])
        }; {
        $2_modulesdir=${$2_prefix?}/modules
        if test ! -d ${$2_modulesdir?}
        then
            AC_MSG_WARN([the directory ${$2_modulesdir?} is missing])
        fi
        HGTW_MSG_VERBOSE([the searchpath will include ${$2_modulesdir?}])
    }; {
        $2_libdir=${$2_prefix}/lib64
        AC_MSG_CHECKING([for a separable 64-bit library area])
        if test -d ${$2_libdir?}
        then
            AC_MSG_RESULT([yes])
        else
            AC_MSG_RESULT([no])
            $2_libdir=${$2_prefix}/lib
            if test ! -d ${$2_libdir?}
            then
                AC_MSG_WARN([the directory ${$2_libdir?} is missing])
            fi
        fi
        HGTW_MSG_VERBOSE([the loadpath will include ${$2_libdir?}])
    }; {
        $2_PKG_CONFIG_PATH=${$2_libdir?}/pkgconfig
        AC_MSG_CHECKING([for a pkgconfig area])
        if test -d ${$2_PKG_CONFIG_PATH?}
        then
            AC_MSG_RESULT([yes])
        else
            AC_MSG_RESULT([no])
            AC_MSG_NOTICE([the directory ${$2_PKG_CONFIG_PATH?} is missing])
            AC_MSG_NOTICE([apparently $1 does not use the pkgconfig system])
        fi
        HGTW_MSG_VERBOSE([the pkgconfig path will include ${$2_PKG_CONFIG_PATH?}])
    }
    #
    $2_CPPFLAGS="-I${$2_modulesdir?} -I${$2_includedir?}${std_cppflags:+ ${std_cppflags}}"
    $2_CFLAGS="${std_cflags}"
    $2_CXXFLAGS="${std_cxxflags}"
    # the -L and -rpath are both individually & separately required
    # also equivalent is '-Xlinker -rpath=${$2_libdir?}'
    $2_LDFLAGS="-L${$2_libdir?} -Wl,-rpath -Wl,${$2_libdir?}${std_ldflags:+ ${std_ldflags}}"
    with_module_accretion_list="$with_module_accretion_list $1" # for use in [HGTW]_[FINALIZE]
    AC_SUBST($2_prefix)
    AC_SUBST($2_bindir)
    AC_SUBST($2_includedir)
    AC_SUBST($2_libdir)
    AC_SUBST($2_modulesdir)
    AC_SUBST($2_PKG_CONFIG_PATH)
    AC_SUBST($2_CPPFLAGS)
    AC_SUBST($2_CFLAGS)
    AC_SUBST($2_CXXFLAGS)
    AC_SUBST($2_LDFLAGS)
])
