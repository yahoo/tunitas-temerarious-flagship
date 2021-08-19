dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_AMBIENT_COMPONENT(name-dashes, name_underscores, [explanation])
dnl HGTW_WITH_AMBIENT_COMPONENT_WITHIN(name-dashes, name_underscores, [explanation], [path-of-candidates])
dnl HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST(name-dashes, name_underscores, [explanation])
dnl
dnl HGTW_AMBIENT_COMPONENT_SEARCHPATH]     (no arguments, expected to be in AC_REQUIRES)
dnl then
dnl
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes name3-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes name3-dashes name4-dashes)
dnl
dnl [[deprecating]] SCOLD_WITH_AMBIENT_COMPONENT(name-dashes, name_underscores, [explanation])
dnl [[deprecating]] SCOLD_WITH_AMBIENT_COMPONENT_WITHIN(name-dashes, name_underscores, [explanation], [path-of-candidates])
dnl [[deprecating]] SCOLD_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST(name-dashes, name_underscores, [explanation])
dnl
dnl See HGTW_COMPONENT_METADIRECTORY_TIERS
dnl The component will be found in one of the meta-directories
dnl     --with-submodules [=DIRECTORY], defaults to ${PWD}/submodules
dnl     --with-siblings   [=DIRECTORY], defaults to ${PWD%/*}
dnl     --with-nearby     [=DIRECTORY], defaults to /build/scold
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl Step 1. Prior to calling the function
dnl
dnl   AC_REQUIRE([HGTW_AMBIENT_COMPONENT_SEARCHPATH])
dnl   AC_REQUIRE([HGTW_WITH_STD_SCOLD]) dnl because compute_AMBIENT_COMPONENT_SEARCHPATH references ${std_scold_prefix?}
dnl
dnl Step 2. Call the function to compute the searchpath using $(...subshell...) but not `...backtick...`
dnl
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes name3-dashes)
dnl   $(compute_AMBIENT_COMPONENT_SEARCHPATH name1-dashes name2-dashes name3-dashes name4-dashes)
dnl
dnl The defun produces a shell function.
dnl The shell function will produce the searchpath
dnl
AC_DEFUN([SCOLD_AMBIENT_COMPONENT_SEARCHPATH], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[AMBIENT]_[COMPONENT]_[SEARCHPATH]], [HGTW_[WITH]_[AMBIENT]_[COMPONENT]_[SEARCHPATH]])
    HGTW_AMBIENT_COMPONENT_SEARCHPATH([$1], [$2], [$3], [$4])
])
AC_DEFUN([HGTW_AMBIENT_COMPONENT_SEARCHPATH], [
    function compute_AMBIENT_COMPONENT_SEARCHPATH() {
        for dir in [$1] [$2] [$3] [$4] [$5] ; do
            if test -n "$dir" ; then
                dnl some (all) of these may be legitimately empty at this point
                echo ${submodules_metadir:+$submodules_metadir/$dir} 
                echo ${siblings_metadir:+$siblings_metadir/$dir} 
                echo ${nearby_metadir:+$nearby_metadir/$dir} 
                echo ${external_metadir:+$external_metadir/$dir}
            fi
        done
        dnl guard with AC_REQUIRE, as above
        echo ${std_scold_prefix?}
    }
])

dnl HGTW_WITH_AMBIENT_COMPONENT_WITHIN(name-dashes, name_underscores, [explanation], [path-of-candidates])
dnl HGTW_WITH_AMBIENT_COMPONENT_WITHIN($1, $2, $3, $4)
dnl
dnl    $1 - argument name-with-dashes          e.g. scold-pattern
dnl    $2 - argument name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment               e.g. SCOLD stuff
dnl    $4 - path of candidates                 e.g. submodules, external, std_scold, prefix
dnl
dnl This is frequently called from derivative build system that want to flaunt their own chained path-of-candidates.
dnl
dnl AC_PREFIX_DEFAULT must already have been called (see init.m4)
dnl
AC_DEFUN([SCOLD_WITH_AMBIENT_COMPONENT_WITHIN], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[WITH]_[AMBIENT]_[COMPONENT]_WITHIN], [HGTW_[WITH]_[AMBIENT]_[COMPONENT]_WITHIN])
    HGTW_WITH_AMBIENT_COMPONENT_WITHIN([$1], [$2], [$3], [$4])
])
AC_DEFUN([HGTW_WITH_AMBIENT_COMPONENT_WITHIN], [
    HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [$3], [$4])
])

dnl HGTW_WITH_AMBIENT_COMPONENT(name-dashes, name_underscores, [explanation])
dnl HGTW_WITH_AMBIENT_COMPONENT($1, $2, $3)
dnl
dnl    $1 - argument name-with-dashes          e.g. scold-pattern
dnl    $2 - argument name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment               e.g. SCOLD stuff
dnl
dnl AC_PREFIX_DEFAULT must already have been called (see init.m4)
dnl
AC_DEFUN([SCOLD_WITH_AMBIENT_COMPONENT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[WITH]_[AMBIENT]_COMPONENT], [HGTW_[WITH]_[AMBIENT]_COMPONENT])
    HGTW_WITH_AMBIENT_COMPONENT([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_AMBIENT_COMPONENT], [
    AC_REQUIRE([HGTW_AMBIENT_COMPONENT_SEARCHPATH])
    AC_REQUIRE([HGTW_WITH_STD_SCOLD]) dnl because compute_AMBIENT_COMPONENT_SEARCHPATH references ${std_scold_prefix?}
    dnl do not add ${prefix} to the candidates; ${prefix} == "NONE" at this point.
    HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [$3], [$(compute_AMBIENT_COMPONENT_SEARCHPATH [$1])])
])

dnl HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST(name-dashes, name_underscores, explanation, searchpath)
dnl HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST($1, $2, $3, $4)
dnl
dnl    $1 - argument name-with-dashes          e.g. scold-pattern
dnl    $2 - argument name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment               e.g. SCOLD stuff
dnl    $4 - candidate list                     e.g. submodules /build/master /build/scold /opt/scold /usr/local
dnl                                                 ^          ^             ^            ^          ^
dnl                                                 |          |             |            |          |
dnl (tree of subtrees)            meta-directory ---/          |             |            |          |
dnl                               meta-directory --------------/             |            |          |
dnl                               meta-directory ----------------------------/            |          |
dnl                                                                                       |          |
dnl              direct pointer to the tree ----------------------------------------------/          |
dnl              direct pointer to the tree ---------------------------------------------------------/
dnl
dnl AC_PREFIX_DEFAULT must already have been called (see init.m4)
dnl
AC_DEFUN([SCOLD_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_HGTW_[AMBIENT]_[COMPONENT]_SEARCHPATH], [HGTW_[AMBIENT]_[COMPONENT]_SEARCHPATH])
    HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [$3], [$4])
])
AC_DEFUN([HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST], [
    AC_REQUIRE([AC_PREFIX_DEFAULT])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_DEBUG])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    function __directory_is_sufficiently_full_of_something_of_value() {
        local dir=[$]1; shift
        test -d $dir/include ||
        test -d $dir/modules ||
        test -d $dir/lib ||
        test -d $dir/lib64 ||
        test -d $dir/libexec ||
        test -d $dir/share ||
        test -f $dir/.gitignore ||
        test -f $dir/Makefile ||
        test -f $dir/Makefile.in ||
        test -f $dir/Makefile.am ||
        test -d $dir/configure ||
        test -d $dir/configure.ac ||
        test -d $dir/src ||
        test -d $dir/tests
        local -i e=$?
        return $e
    }
    AC_ARG_ENABLE([$1],
                  [AS_HELP_STRING([--enable-$1], [ERROR use --with-$1=ROOT])],
                  [AC_MSG_NOTICE([do not not say "enable" $1, because $1 is not a feature])
                   AC_MSG_NOTICE([rather say "with" $1 because $1 as a subsystem])
                   AC_MSG_ERROR([use --with-$1=ROOT, e.g. --with-$1=${prefix:-PREFIX}])])
    HGTW_MSG_DEBUG([ahead of AC ARG WITH with_$2=${with_$2:-(unset)}])
    AC_ARG_WITH([$1],
                [AS_HELP_STRING([--without-$1], [without the $3 development area])],
                [ with_$2=$withval ],
                [ with_$2=probing ])
    if test x = "x${with_$2}"
    then
        AC_MSG_WARN([the directory for --with-$1 as ${$2_prefix:-(empty)} is given as an empty string])
        AC_MSG_NOTICE([reverting to use "probing" mode, continuing])
        with_$2=probe
    fi
    AC_MSG_CHECKING([subsystem $1 in the ambient environment])
    if test xno = "x${with_$2?}" ||
       test xNONE = "x${with_$2?}"
    then
        #
        # --without-this-thing
        # (also) --enable-this-thing=no
        #
        AC_MSG_RESULT([no])
        unset $2_prefix
        HGTW_MSG_VERBOSE([when needed, the $1 components must be in the ambient build environment])
    else
        if ! { test xprobe = "x${with_$2?}" ||
               test xprobing = "x${with_$2?}" ||
               test xguess = "x${with_$2?}" ||
               test xguessing = "x${with_$2?}" ||
               test xyes = "x${with_$2?}" ||
               test xunset = "x${with_$2?}" ; }
        then
            #
            # --with-this-thing=/exp/something/something
            #
            AC_MSG_RESULT([yes])
            $2_prefix=${with_$2?}
            if ! expr "${$2_prefix?}" : "^/" > /dev/null
            then
                AC_MSG_WARN([the directory for $1 as ${$2_prefix:-(empty)} is not an absolute path])
                AC_MSG_WARN([some recursive configurations will likely fail])
                AC_MSG_NOTICE([remedy: retry with --with-$1=${PWD}/${$2_prefix?}])
                # and we can't fix this in place because we aren't [yet] able to edit the argv given to sub-configure invocations.
                AC_MSG_ERROR([cannot continue unless --with-$1 specifies an absolute path])
            fi
        else
            AC_MSG_RESULT([probing])
            __directory_candidates="$(echo m4_flatten($4))"
            HGTW_MSG_VERBOSE([ambient directory candidates are: ${__directory_candidates:-none}])
            # the __directory_candidates can be empty (which is surprising) but the test lower down will catch it
            for candidate in ${__directory_candidates}
            do
                for dir in $candidate/$1 $candidate
                do
                    # This test needs to work in development and also
                    # for installation of modules (code) and script kiddie stuff.
                    if ! test -d ${dir?}
                    then 
                        HGTW_MSG_VERBOSE([ignoring directory ${dir?}, which does not exist])
                    elif ! __directory_is_sufficiently_full_of_something_of_value ${dir?}
                    then 
                        HGTW_MSG_VERBOSE([ignoring directory ${dir?}, which contains nothing of interest])
                    else
                        # only consider candidates for guessing which are not wholly empty.                   
                        if test -d $dir
                        then
                            HGTW_MSG_VERBOSE([directory ${dir?} is acceptable])
                            $2_prefix=$dir
                            break 2
                        else
                            HGTW_MSG_VERBOSE([directory ${dir?} is missing])
                        fi
                    fi
                done
            done
            if test unset = "${$2_prefix:-unset}" ; then
                AC_MSG_ERROR([could not find a candidate for --with-$1 among ${__directory_candidates:-unset}])
            fi
            with_$2=${$2_prefix?}
            HGTW_MSG_VERBOSE([acting as if presented with --with-$1=${with_$2?}, making that choice explicit for possible recursion])
        fi
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1], [${$2_prefix?}])
        AC_MSG_CHECKING([again for subsystem $1 at ${$2_prefix?}])
        if ! test -d "${$2_prefix?}"
        then
            AC_MSG_RESULT([no])
            AC_MSG_ERROR([the directory ${$2_prefix?} does not exist])
        elif ! __directory_is_sufficiently_full_of_something_of_value "${$2_prefix?}"
        then
            AC_MSG_RESULT([no])
            AC_MSG_ERROR([the directory ${$2_prefix?} does not contain anything of value])
        else
            dnl be loud about this because the user chose one thing and we are swapping in an alternative
            AC_MSG_RESULT([found])
            HGTW_MSG_VERBOSE([the $1 components are in ${$2_prefix?}])
        fi
    fi
    with_module_accretion_list="$with_module_accretion_list $1" # for use in [HGTW]_[FINALIZE]
    AC_SUBST([$2_prefix])
])
