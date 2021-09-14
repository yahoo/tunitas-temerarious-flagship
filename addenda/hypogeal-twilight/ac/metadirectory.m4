dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_COMPONENT_METADIRECTORY_TIERS   (no arguments)
dnl HGTW_WITH_META_DIRECTORY(name-dashes, name-underscores, default-value, explanation_text)
dnl [[deprecated]] SCOLD_COMPONENT_METADIRECTORY_TIERS   (no arguments)
dnl [[deprecated]] SCOLD_WITH_META_DIRECTORY(name-dashes, name-underscores, default-value, explanation_text)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Purpose:
dnl
dnl   HGTW_WITH_META_DIRECTORY(name-dashes, name-underscores, default-value, explanation_text)
dnl
dnl     Declare one of the metadirectory tiers.
dnl     Normally this is an internal call of HGTW_COMPONENT_METADIRECTORY_TIERS, but is available.
dnl
dnl   HGTW_COMPONENT_METADIRECTORY_TIERS
dnl
dnl     Define the, at least three, component tiers: submodules, siblings, nearby, 
dnl     Definitions of submodules, siblings and nearby appear below with the option syntax. 
dnl  
dnl     --with-submodules=DIRECTORY
dnl       These are modules within a subdirectory herein
dnl       They are (git) submodules within a directory herein
dnl       Default:
dnl           --with-submodules
dnl           --with-submodules=${PWD}/submodules <----------  needs the full path
dnl       Examples:
dnl           --with-submodules=${PWD}/submodules
dnl           --with-submodules=${PWD}/something/anything   (rare, better to use --with-nearby=)
dnl           --with-submodules=${PWD}/external             [[deprecated]]
dnl                          (older, yes "external" is a confusing word sense; it is historical)
dnl
dnl     --with-siblings=DIRECTORY
dnl       These are modules at the same level as this tree; they are accessible via ..
dnl       Default:
dnl           --with-siblings <-------------------- defaults to /build/scold
dnl           --with-siblings=${PWD%/*} <-------------------  needs the full path
dnl       Examples:  
dnl           --with-siblings=$(cd .. ; pwd)
dnl  
dnl     --with-nearby=DIRECTORY
dnl       These are modules somewhere nearby.
dnl       Default:
dnl           --with-nearby <---------------------- defaults to /build/scold
dnl           --with-nearby=/build/scold
dnl       Examples:
dnl           --with-nearby=/build/scold
dnl  
dnl    --with-external=DIRECTORY, is deprecating; it is like "--with-nearby"
dnl  
dnl    --with-std-scold=ROOT (a directory)
dnl      This is an installation directory
dnl      Default:
dnl          --without-std-scold
dnl      Example:
dnl          --with-std-scold=/opt/scold
dnl          --with-std-scold=/opt/scold/bootstrap
dnl          --with-std-scold=/usr/local
dnl          --with-std-scold=/usr
dnl  
dnl   Any of these may be established as --without
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_COMPONENT_METADIRECTORY_TIERS        (no arguments)
dnl
AC_DEFUN([SCOLD_COMPONENT_METADIRECTORY_TIERS], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([SCOLD_[COMPONENT]_[METADIRECTORY]_TIERS], [HGTW_[COMPONENT]_[METADIRECTORY]_TIERS])
    HT_COMPONENT_METADIRECTORY_TIERS
])
AC_DEFUN([HGTW_COMPONENT_METADIRECTORY_TIERS], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([HGTW_[COMPONENT]_[METADIRECTORY]_TIERS], [HT_[COMPONENT]_[METADIRECTORY]_TIERS])
])
AC_DEFUN([HT_COMPONENT_METADIRECTORY_TIERS], [
    __abs_srcdir=${ac_abs_srcdir:-${PWD}}
    # A separate interlock exists to prove that the submodules directory
    # as indicated herein is "the same as" the submodules directory anointed in HGTW_[CONFIG]_[SUBMODULES]
    HGTW_WITH_META_DIRECTORY([submodules],
                             [submodules],
                             [${__abs_srcdir}/submodules],
                             [submodules within this tree])
    HGTW_WITH_META_DIRECTORY([siblings],
                             [siblings],
                             [${__abs_srcdir%/*}],
                             [sibling modules, next to this tree])
    HGTW_WITH_META_DIRECTORY([nearby],
                             [nearby],
                             [/build/scold],
                             [nearby modules, in a nearby tree])
    # [[deprecated]] as the name "external" is not really motivated by anything
    # the deprecation warning occurs inside as a special condition.
    HGTW_WITH_META_DIRECTORY([external],
                             [nearby],
                             [/build/scold],
                             [nearby modules, in a nearby tree])
    HGTW_WITH_STD([scold],
                  [scold],
                  [directory containing the built-in-place submodules])
])

dnl HGTW_WITH_META_DIRECTORY(name-dashes, name_underscores, [explanation])
dnl HGTW_WITH_META_DIRECTORY($1, $2, $3)
dnl
dnl   $1 - argument name-with-dashes          e.g. submodules
dnl   $2 - argument name_with_underscores     e.g. submodules
dnl   $3 - default value                      e.g. ./external
dnl   $4 - explanation fragment               e.g. submodules directory
dnl        grammar: $4 has "with the" prefixed to it 
dnl
dnl Side Effects:
dnl   the shell variables are defined
dnl
dnl   with_$2                  any of: <directory>, no, default, yes, NONE.
dnl   $2_metadir               either: <directory> or empty
dnl   $2_metadir_provenance    origin of the value, why is $2_metadir defined like this?
dnl                            grammar: should start with an article, e.g. "an" or "a"
dnl
dnl ... and any other compatibility enhancements that might be relevant
dnl
AC_DEFUN([SCOLD_WITH_META_DIRECTORY], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([SCOLD_[WITH]_[META]_DIRECTORY], [HGTW_[WITH]_[META]_DIRECTORY])
    HGTW_WITH_META_DIRECTORY([$1], [$2], [$3], [$4])
])
AC_DEFUN([HGTW_WITH_META_DIRECTORY], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_DEBUG])
    ifelse([$1], [external], [
        HT_MSG_DEPRECATED_OPTION([--with-external], [--with-nearby])
    ])
    AC_ARG_ENABLE([$1],
                  [AS_HELP_STRING([--enable-$1], [ERROR use --with-$1=DIRECTORY])],
                  [AC_MSG_ERROR([use --with-$1=DIRECTORY])])
    ifelse([$1], [external], [
        # the deprecation case where --with-external looks like --with-nearby
        AC_ARG_WITH([$1],
                    [AS_HELP_STRING([--with-$1], [with the $4])],
                    [
                        # WATCHOUT - this works because $with_nearby was established prior to 'external'
                        # handle conflicting values in old code; e.g. --with-nearby, --without-external
                        # WATCHOUT - there is no $with_external, only $withval when $1 == 'external'
                        #            because $2 - is always 'nearby' when $1 == 'external'
                        if test -n "$with_nearby" && test "$withval" != "$with_nearby"
                        then
                            HGTW_MSG_NOTICE([--with-external is deprecated, prefer --with-nearby])
                            HGTW_MSG_NOTICE([error: --with-nearby=${with_nearby:-(empty)}])
                            HGTW_MSG_NOTICE([error: --with-external=${with_external:-(empty)}])
                            HGTW_MSG_ERROR([--with-nearby and --with-external have conflicting values])
                        fi
                        with_$2=$withval
                    ],
                    [ with_$2=${with_$2:-default} ])
     ], [
        # the normal case (easy)
        AC_ARG_WITH([$1],
                    [AS_HELP_STRING([--with-$1], [with the $4])],
                    [ with_$2=$withval ],
                    [ with_$2=${with_$2:-default} ])
    ])
    ifelse([$1], [external], [
        dnl special case: treating --with-external=SOMETHING as --with-nearby=SOMETHING
        dnl the caller passed 'nearby' as the bindable variable
        if test -n "$with_$1"
        then
            HGTW_MSG_NOTICE([treating --with-$1=${with_$1} as --with-$2=${with_$1:-unset}])
        fi
    ])
    if test x = "x${with_$2}"
    then
        AC_MSG_WARN([the directory for --with-$1=${$2_prefix:-(empty)} is empty])
        AC_MSG_NOTICE([reverting to use "default" mode, continuing])
        with_$2=default
    fi
    AC_MSG_CHECKING([meta directory $1])
    if test "xno" = "x$with_$2" ||
       test "xNONE" = "x$with_$2"
    then
        AC_MSG_RESULT([no])
        with_$2=no
        unset $2_metadir
        $2_metadir_provenance="an explicit choice on the command line --without-$2"
        HGTW_MSG_VERBOSE([acting as if presented with --without-$1, making that choice explicit for possible recursion])
        # The submodule builds need to see this.  It is the choice all the way down the tree.
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--without-$1])
    else
        # Either 'yes' and we compute a default
        # or else a literal value which we accept
        # Always with_$2 is checked for reasonableness.       
        if ! { test "xdefault" = "x$with_$2" ||
               test "xyes" = "x$with_$2" ||
               test "xunset" = "x${with_$2:-unset}" ; }
        then
            AC_MSG_RESULT([yes])
            $2_metadir_provenance="an explicit choice on the command line as --with-$2=$with_$2"
            ifelse([$1], [submodules], [
                if ! expr "$with_$2?" : "^/" > /dev/null
                then
                    HGTW_MSG_VERBOSE([option --with-$1=$with_$2 is explicit on the command line])
                    HGTW_MSG_WARNING([a full path is required for --with-$1, applying ${__abs_srcdir}])
                    with_$2="${__abs_srcdir}/$with_$2"
                    # this will happen anyway in HGTWinternal_WITH_META_ACCEPT_DIRECTORY
                    HGTW_MSG_VERBOSE([now acting as if presented with --with-$1=${with_$2?}, making that choice explicit for possible recursion])
                fi
            ])
            HGTWinternal_WITH_META_ACCEPT_DIRECTORY([$1], [$2], [$3], [$4])
        else
            AC_MSG_RESULT([default])
            # The value of default_with_$2 may or may not appear spontaneously in the environment by the ancestral caller.
            if test -z "${default_with_$2}"
            then
                if test -d $3
                then
                    default_with_$2="$3"
                    AC_MSG_NOTICE([using ${default_with_$2?} as the default for --with-$1])
                    with_$2=${default_with_$2}
                    $2_metadir_provenance="the default value ${default_with_$2?}"
                    HGTWinternal_WITH_META_ACCEPT_DIRECTORY([$1], [$2], [$3], [$4])
                    # try ... to communicate the new value down the tree by resetting the arguments
                    HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1=${default_with_$2}])
                    {
                        # Whereas dynamic scoping is an abomination.
                        # But because we cannot modify the sense of the current arguments to configure
                        #    e.g. to add or remove --with-submodule, --without-submodule
                        # we have to communicate the sense of the default value down the tree out of band.
                        # is this really [still] true?
                        export default_with_$2
                    }
                else
                    AC_MSG_NOTICE([there is no default $1 directory])
                    AC_MSG_NOTICE([and the potential candidate default $1 directory, $3, does not exist])
                    AC_MSG_NOTICE([therefore, acting as if --without-$1 was presented])
                    unset with_$2
                    unset $2_metadir
                    $2_metadir_provenance="an implicit inferrence because, although --with-$1 was indicated, no default $1 directory candidate was available"
                    # The submodule builds need to see this.  It is the choice all the way down the tree.
                    HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--without-$1])
                fi
            elif test -d ${default_with_$2}
            then
                AC_MSG_NOTICE([using the recursion-scoped value ${default_with_$2?} as the default value for --with-$1])
                with_$2=${default_with_$2}
                $2_metadir_provenance="the recursion-scoped value, which was established earlier"
                HGTWinternal_WITH_META_ACCEPT_DIRECTORY([$1], [$2], [$3], [$4])
            else
                AC_MSG_NOTICE([the potential candidate default directory $3 does not exist])
                AC_MSG_NOTICE([there is no viable default directory for --with-$1])
                AC_MSG_ERROR([use you must --with-$1=DIRECTORY explicitly])
            fi
        fi
    fi
    AC_SUBST($2_metadir)
])

dnl HGTWinternal_WITH_META_ACCEPT_DIRECTORY(name-dashes, name_underscore, default_value, explanation)
dnl
dnl    $1 - argument name-with-dashes          e.g. submodules
dnl    $2 - argument name_with_underscores     e.g. submodules
dnl    $3 - default value                      e.g. ./external
dnl    $4 - explanation fragment               e.g. submodules directory
dnl         grammar: $4 has "with the" prefixed to it 
dnl
AC_DEFUN([HGTWinternal_WITH_META_ACCEPT_DIRECTORY], [
    $2_metadir=${with_$2?}
    if test no == "${$2_metadir?}"
    then
        dnl [[FIXTHIS]] something elsewhere, upstream, has failed
        dnl the failed routine continues to supply $2_metadir=no (it should be empty)
        dnl whereas $with_2=no is valid, $2_metadir="" is the appropriate value in that case
        HGTW_MSG_DEBUG([option --with-$1=${$2_metadir} must have been supplied explicitly on the command line])
        HGTW_MSG_VERBOSE([option --with-$1=${$2_metadir} will be ignored])
    else
        if ! test -d "${$2_metadir?}"
        then
            AC_MSG_NOTICE([option --with-$1=${$2_metadir} is invalid])
            AC_MSG_NOTICE([remedy: retry with --without-$1])
            AC_MSG_NOTICE([remedy: or retry with --with-$1=DIRECTORY and another location])
            AC_MSG_ERROR([the directory ${$2_metadir?} does not exist])
        fi
        HGTW_MSG_DEBUG([presented with --with-$1=${$2_metadir}])
        if ! expr "${$2_metadir?}" : "^/" > /dev/null
        then
            AC_MSG_NOTICE([the value for --with-$1=${$2_metadir:-(empty)} is not an absolute path])
            AC_MSG_NOTICE([recursive configurations submodule would fail with this definition])
            AC_MSG_NOTICE([remedy: retry with --with-$1=${PWD}/${$2_metadir?}])
            # and we ca not fix this in place because we are not [yet] able to edit the argv given to sub-configure invocations.
            AC_MSG_ERROR([cannot continue unless --with-$1 specifies an absolute path])
        fi
        # The submodule builds need to see this in case they too declare, vaguely, e.g. --with-submodules
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1], [${$2_metadir?}])
    fi
])
