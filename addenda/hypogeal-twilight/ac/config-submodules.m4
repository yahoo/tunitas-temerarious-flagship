dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CONFIG_SUBMODULES(submoduledir, ...list-of-submodule-names...)
dnl [[deprecated]] SCOLD_CONFIG_SUBMODULES(submodules, ...list-of-submodule-names...)
dnl
dnl The submodules listed of the second argument define the (sub-)build order
dnl
dnl Example:
dnl
dnl     HGTW_CONFIG_SUBMODULES([submodules], [module-c module-sys module-cppunit module-path])
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl m4_bpatsubst(herein, [-], [_])))

dnl
dnl HGTW_CONFIG_SUBMODULES(submodules, ...list-of-submodule-names...)
dnl HGTW_CONFIG_SUBMODULES($1, $2)
dnl
dnl   $1 - meta-directory - the directory containing the submodules
dnl        e.g. ./submodules ./external or even . (the current directory) itself
dnl        ./submodules is current practice
dnl        ./external is deprecated practice
dnl   $2 - string list of directory-name-dashes - the directory names themselves, they may have dashes
dnl        e.g. module-file-slurp
dnl
dnl The (meta-)directory of the first argument is the submodules directory in this repo
dnl     If the subsystem is in this directory it will be configured for building
dnl     If the subsystem is not in this directory it will not be built.
dnl
dnl The submodules listed of the second argument define the (sub-)build order
dnl
AC_DEFUN([SCOLD_CONFIG_SUBMODULES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CONFIG]_SUBMODULES], [HGTW_[CONFIG]_SUBMODULES])
    HGTW_CONFIG_SUBMODULES([$1], [$2])
])
AC_DEFUN([HGTW_CONFIG_SUBMODULES], [
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    # on the occasion of --without-submodules
    # yet there are configured submodules declared within
    if test -z "${submodules_metadir}"
    then
        HGTW_MSG_NOTICE([warning: given --with-submodules=${submodules_metadir:-no} from ${submodules_metadir_provenance:-origin known}])
        HGTW_MSG_NOTICE([warning: found [HGTW]_[CONFIG]_[SUBMODULES]({$1}, {m4_flatten([$2])})])
        HGTW_MSG_WARNING([the command line is overriding configure.ac, continuing])
    else
        # because the command line or inference defines $submodules_metadir as a full path
        # yet $1 is almost always a relative path in configure.ac.
        __abs_arg=$(cd m4_flatten($1) 2>/dev/null && pwd || echo m4_flatten($1))
        if test ${__abs_arg?} != ${submodules_metadir?}
        then
            #
            # we get here legitimately when a submodule contains a submodule
            # e.g.
            #
            #    /build/projectA/submodules/projectB/submodules/projectC
            #    /build/projectA/submodules/projectB/submodules/projectD
            #
            HGTW_MSG_NOTICE([warning: given --with-submodules=${submodules_metadir:-no} from ${submodules_metadir_provenance:-origin known}])
            HGTW_MSG_NOTICE([warning: found [HGTW]_[CONFIG]_[SUBMODULES]({$1}, {m4_flatten([$2])})])
            HGTW_MSG_DEBUG([the command line specifies ${submodules_metadir:-no}])
            HGTW_MSG_DEBUG([whereas configure.ac specifies ${__abs_arg?}])
            HGTW_MSG_WARNING([the command line is overriding configure.ac, continuing anyway])
        fi
        AC_CONFIG_SUBDIRS([])
        m4_foreach([herein],
                   m4_split(m4_normalize([$2])), [
                       dnl cannot use $__abs_arg instead of $1 here because autoconf complains
                       dnl    configure.ac:68: warning: AC_CONFIG_SUBDIRS: you should use literals
                       dnl the full path has to come from the command line, it cannot be developed, or remediated, herein.
                       HGTWinternal_CONFIG_ONE_SUBMODULE([$1], herein, m4_bpatsubst(herein,-,_))
                   ])
    fi
])

dnl
dnl HGTWinternal_CONFIG_ONE_SUBMODULE(meta-directory, directory-name-dashes, variable_name_underscores)
dnl
dnl $1 - meta-directory - the directory containing the submodules
dnl      e.g. ./submodules ./external or even . (the current directory) itself
dnl $2 - directory-name-dashes - the directory name itself, it may have dashes
dnl      e.g. module-file-slurp
dnl $3 - variable_name_underscores - the variable name, it will have underscores, suitable for bash
dnl      e.g. module_file_slurp
dnl
dnl to be called only from SCOLD_CONFIG_SUBMODULES
dnl
AC_DEFUN([HGTWinternal_CONFIG_ONE_SUBMODULE], [
    AC_MSG_CHECKING([if $2 is a submodule build])
    # it is prettier to not see the leading "./" when concatenations are created
    # also, avoid ambiguities between "./" prefixes;
    #       e.g. ./submodules/some-submodule and submodules/some-submodule
    if test . = $1 ; then
        subpath=$2
    else
        subpath=$1/$2
    fi
    #
    # A submodule is enabled under three conditions
    #
    # 1. the --with-SUBSYSTEM option exists and is not 'no'
    #    then build the submodule herein
    #
    # 2. the --with-SUBSYSTEM option did not exist but $3_prefix was specified somehow
    #        in some other way; e.g. by implication see HGTW_WITH_MODULE
    #        AND $3_prefix specifies the submodule directory herein
    #    then build the submodule herein
    #
    # 3. the --with-SUBSYSTEM option does not exist at all
    #    always build the submodule herein, if it exists
    #
    # And by implication, 'no' as in --with-SUBSYSTEM=no means do not build the submodule
    #
    if { : case 1;
         test -n "$with_$3" && test "x$with_$3" != "xno" ; } ; then
        if ! test -d "${subpath?}" || ! test -d "${with_$3?}"; then
            if test -d "${subpath?}"; then __subpath_found=present; else __subpath_found=missing; fi
            if test -d "${with_$3?}"; then __with_3_found=present; else __with_3_found=missing; fi
            reason="the directories are ambiguous: .../${subpath?} is ${__subpath_found?}, .../${with_$3?} is ${__with_3_found?} (case 1)"
            submodule_build=no
        else
            canonical_subpath=$(cd $subpath && pwd) 
            canonical_with_$3=$(cd ${with_$3?} && pwd)
            if test "$canonical_subpath" = "$canonical_with_$3"; then
                reason=".../$subpath is a submodule [herein], and it was indicated by --with-$2=${with_$3?} (case 1)"
                submodule_build=yes
            else
                reason=".../$subpath is a submodule, but a different $2 was indicated by --with-$2=${with_$3?} (case 1)"
                submodule_build=no
            fi
        fi
     elif { : case 2;
            test -z "$with_$3" && test -n "${$3_prefix}"; }; then
        if ! test -d "${subpath?}" || ! test -d "${$3_prefix?}"; then
            if test -d "${subpath?}"; then __subpath_found=present; else __subpath_found=missing; fi
            reason="the directories are ambiguous: .../${subpath?} is ${__subpath_found?}, .../${$3_prefix?} is ${__3_prefix_found?} (case 2)"
            submodule_build=no
        else
            canonical_subpath=$(cd $subpath && pwd) 
            canonical_$3_prefix=$(cd ${$3_prefix?} && pwd)
            if test "$canonical_subpath" = "$canonical_$3_prefix"; then
                reason=".../$subpath is a submodule [herein], and it was indicated by --with-$2=${$3_prefix?} (case 2)"
                submodule_build=yes
            else
                reason=".../$subpath is a submodule, but a different $2 was indicated by --with-$2=${$3_prefix?} (case 2)"
                submodule_build=no
            fi
        fi
     elif { : case 3;
            test -z "$with_$3"; }; then
        reason="$2 is always built as there is no --without-$2 option available to disable it (case 3)"
        submodule_build=yes
     else
        reason="there is no --with-$2 indication that selects it (case 3)"
        submodule_build=no
     fi
     if test yes = $submodule_build && ! {
        test -f $subpath/Makefile ||
        test -f $subpath/Makefile.in ||
        test -f $subpath/Makefile.am
        } ; then
        reason="$reason, yet there is no Makefile at .../$subpath/Makefile, so there is no way to build it"
        submodule_build=no
     fi
     if test yes = $submodule_build; then
        if ! test -d $subpath ; then
            AC_MSG_RESULT([FAIL])
            AC_MSG_ERROR([the submodule directory $subpath is missing])
        else
            AC_MSG_RESULT([yes])
            HGTW_MSG_VERBOSE([$2 is a submodule build because $reason])
        fi
        dnl WATCHOUT -- utter this line only once as other scripts grok for it
        AC_CONFIG_SUBDIRS($1/$2)
    else
        AC_MSG_RESULT([no])
        HGTW_MSG_VERBOSE([$2 is not a submodule build because $reason])
    fi
])
