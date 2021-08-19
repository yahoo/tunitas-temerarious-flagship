dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_WITH_COMPONENT(name-dashes, name_underscores, [explanation])
dnl
dnl [[deprecated]] HGTW_WITH_COMPONENT(name-dashes, name_underscores, [explanation])
dnl [[deprecated]] SCOLD_WITH_COMPONENT(name-dashes, name_underscores, [explanation])
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HT_WITH_COMPONENT(name-dashes, name_underscores, [explanation])
dnl HT_WITH_COMPONENT($1, $2, $3)
dnl    $1 - argument name-with-dashes          e.g. scold-pattern
dnl    $2 - argument name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment               e.g. SCOLD stuff
dnl
dnl Grammar via HGTW_WITH_AMBIENT_COMPONENT
dnl in the help output, the $3 words appear in a sentence preceded by
dnl the article "the" as in "the wonderful module" for module-wonderful
dnl e.g.
dnl
dnl    --without-module-std    without the std module development area
dnl    
dnl remove the "scold-" prefix as that was a bad idea
dnl
dnl     scold-anguish-answer     -> anguish-answer
dnl     scold-hypogeal-twilight  -> hypogeal-twilight
dnl
AC_DEFUN([SCOLD_WITH_COMPONENT], [
    HTfriend_NOTICE_OF_USER_ERROR_NEVER_WAS([SCOLD_[WITH]_COMPONENT], [HT_[WITH]_COMPONENT], [$1], [$2], [$3])
    HT_WITH_COMPONENT([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_COMPONENT], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED_API([HGTW_[WITH]_COMPONENT], [HT_[WITH]_COMPONENT])
    HTprivate_ANY_COMPONENT_GENERALLY([$1], [$2], [$3])
])
AC_DEFUN([HT_WITH_COMPONENT], [HTprivate_ANY_COMPONENT_GENERALLY([$1], [$2], [$3])])

dnl
dnl HTprivate_ANY_COMPONENT_GENERALLY(name-dashes, name_underscores, [explanation])
dnl HTprivate_ANY_COMPONENT_GENERALLY($1, $2, $3)
dnl    $1 - argument name-with-dashes          e.g. scold-pattern
dnl    $2 - argument name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment               e.g. SCOLD stuff
dnl
dnl The workhorse, common to all the exported frontends.
dnl Handles all compatibility and grandfathering.
dnl
dnl e.g. 
dnl remove the "scold-" prefix as that was a bad idea
dnl
dnl     scold-anguish-answer     -> anguish-answer
dnl     scold-hypogeal-twilight  -> hypogeal-twilight
dnl
dnl e.g.
dnl allow the module- prefix which is disallowed, but re-supplied by HGTW_WITH_MODULE
dnl
dnl   previously
dnl     SCOLD_WITH_MODULE([module-apple], [module-apple], [The Apple Module])
dnl     SCOLD_WITH_MODULE([module-banana], [module-banana], [The Banana Module])
dnl     SCOLD_WITH_MODULE([module-cherry], [module-cherry], [The Cherry Module])
dnl   becomes
dnl     HGTW_WITH_MODULE([apple])
dnl     HGTW_WITH_MODULE([banana]]
dnl     HGTW_WITH_MODULE([cherry]]
dnl
AC_DEFUN([HTprivate_ANY_COMPONENT_GENERALLY], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_WITH_HYPOGEAL_TWILIGHT])
    AC_REQUIRE([HGTW_WITH_INCENDIARY_SOPHIST])
    AC_REQUIRE([HGTW_WITH_VERNACULAR_DOGGEREL])
    ifelse([scold], [$1], [
        AC_MSG_ERROR([--with-$1 cannot be processed by [SCOLD]_[WITH]_[MODULE], try [SCOLD]_[WITH]_[STD] instead])
    ], [ifelse([std], [$1], [
        AC_MSG_ERROR([--with-$1 cannot be processed by [SCOLD]_[WITH]_[MODULE], try [SCOLD]_[WITH]_[STD] instead])
    ], [ifelse([nonstd-compiler], [$1], [
        #
        # for 'compiler', because submodules may not have upgraded yet
        #     s/SCOLD_WITH_HEREIN/HGTW_WITH_NONSTD/
        #     s/SCOLD_WITH_COMMON/HGTW_WITH_NONSTD/
        #     s/SCOLD_WITH_HEREIN/HGTW_WITH_NONSTD/
        #     s/SCOLD_WITH_MODULE/HGTW_WITH_NONSTD/
        #     s/SCOLD_WITH_SIBLING/HGTW_WITH_NONSTD/
        #
        HT_MSG_DEPRECATED_OPTION([the option --with-$1 via [SCOLD]_[WITH]_[MODULE]],
                                 [HGTW_[WITH]_NONSTD])
        HGTW_WITH_NONSTD([gcc], [gcc], [$3])
    ], [ifelse([scold-anguish-answer], [$1], [
        HTprivate_REDOING_MODULE_REMOVING_DEPRECATED_SCOLD_PREFIX([$1], [$2], [$3])
    ], [ifelse([scold-hypogeal-twilight], [$1], [
        HTprivate_REDOING_MODULE_REMOVING_DEPRECATED_SCOLD_PREFIX([$1], [$2], [$3])
    ], [ifelse([anguish-answer], [$1], [
        HGTW_WITH_AMBIENT_COMPONENT([$1], [$2], [$3])
        # compatibility (set up the old variable names as well)
        AC_SUBST([scold_$2_prefix], [$$2_prefix])
    ], [ifelse([hypogeal-twilight], [$1], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([COMPONENT], [$1], [$2], [$3], [HYPOGEAL_TWILIGHT])
        HGTW_WITH_HYPOGEAL_TWILIGHT
    ], [ifelse([incendiary-sophist], [$1], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([COMPONENT], [$1], [$2], [$3], [INCENDIARY_SOPHIST])
        HGTW_WITH_INCENDIARY_SOPHIST
    ], [ifelse([vernacular-doggerel], [$1], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([COMPONENT], [$1], [$2], [$3], [VERNACULAR_DOGGEREL])
        HGTW_WITH_VERNACULAR_DOGGEREL
    ], [
        HGTW_WITH_AMBIENT_COMPONENT([$1], [$2], [$3])
    ])])])])])])])])])
])

dnl HTprivate_REDOING_MODULE_REMOVING_DEPRECATED_SCOLD_PREFIX(scold-name-dashes, scold_name_underscores, [explanation])
dnl HTprivate_REDOING_MODULE_REMOVING_DEPRECATED_SCOLD_PREFIX($1, $2, $3)
dnl    $1 - argument scold-name-with-dashes          e.g. scold-pattern
dnl    $2 - argument scold-name_with_underscores     e.g. scold_pattern
dnl    $3 - explanation fragment                     e.g. some component
dnl
AC_DEFUN([HTprivate_REDOING_MODULE_REMOVING_DEPRECATED_SCOLD_PREFIX], [
    # compatibility so that --with-$2 acts as --with-m4_bpatsubst($2, [scold_], [])
    HT_MSG_DEPRECATED_OPTION([option --with-$1],
                             [option --with-m4_bpatsubst([$1], [scold-], [])])
    HGTW_WITH_AMBIENT_COMPONENT(m4_bpatsubst($1, [scold-], []), m4_bpatsubst($2, [scold_], []), [$3])
    # compatibility (set up the old variable names as well)
    AC_SUBST([$2_prefix], [$m4_bpatsubst($2, [scold_], [])_prefix])
    with_module_accretion_list="$with_module_accretion_list m4_bpatsubst($1, [scold-], [])" # for use in [HGTW]_[FINALIZE]
])
