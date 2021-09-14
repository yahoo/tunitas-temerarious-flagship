dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl An (internal-to-hypogeal-twilight) shared deprecatino warning
dnl
dnl HTfriend_NOTICE_OF_USER_ERROR_NEVER_EVER([conjugate], [erroneous_api_name], [correct_api_name], name-dashes, name_underscores, [prose explanation])
dnl HTfriend_NOTICE_OF_USER_ERROR_NEVER_WAS([erroneous_api_name], [correct_api_name], name-dashes, name_underscores, [prose explanation])
dnl HTfriend_NOTICE_OF_USER_ERROR_NEVER_WILL_BE([erroneous_api_name], [correct_api_name], name-dashes, name_underscores, [prose explanation])
dnl
dnl    $1 - the verb "to be" conjugated appropriately as "was" or "will be"
dnl    $2 - the erroneous API name, e.g. HGTW_WITH_SUBSYSTEM (this is not "deprecated" because it never was available ever; it is merely a common error)
dnl    $3 - the correct API name, e.g. HGTW_WITH_COMPONENT
dnl    $4 - argument scold-name-with-dashes          e.g. scold-pattern
dnl    $5 - argument scold-name_with_underscores     e.g. scold_pattern
dnl    $6 - explanation fragment                     e.g. some component
dnl
AC_DEFUN([HTfriend_NOTICE_OF_USER_ERROR_NEVER_WAS],     [HTfriend_NOTICE_OF_USER_ERROR_NEVER_EVER([was],     [$1], [$2], [$3], [$4], [$5])])
AC_DEFUN([HTfriend_NOTICE_OF_USER_ERROR_NEVER_WILL_BE], [HTfriend_NOTICE_OF_USER_ERROR_NEVER_EVER([will be], [$1], [$2], [$3], [$4], [$5])])
AC_DEFUN([HTfriend_NOTICE_OF_USER_ERROR_NEVER_EVER], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_WARNING([there never $1 an API shaped as $2(...), instead use $3(...)])
    HT_MSG_NOTICE([invalid use $2(changequote([{],[}])[$4]changequote({[},{]}), changequote([{],[}])[$5]changequote({[},{]}), changequote([{],[}])[$6]changequote({[},{]}))])
    HT_MSG_NOTICE([instead use $3(changequote([{],[}])[$4]changequote({[},{]}), changequote([{],[}])[$5]changequote({[},{]}), changequote([{],[}])[$6]changequote({[},{]}))])
])

dnl
dnl HTfriend_NOTICE_OF_BREAKING_CHANGE_SCOLD_PREFIX(suffix_word, name-dashes, name_underscores, [prose explanation])
dnl
dnl    $1 - is one of the keywords COMMON, HEREIN, MODULE, SIBLING
dnl    $2 - argument scold-name-with-dashes          e.g. scold-pattern
dnl    $3 - argument scold-name_with_underscores     e.g. scold_pattern
dnl    $4 - explanation fragment                     e.g. some component
dnl
dnl SCOLD_WTIH_MODULE(3-arg) <---> HT_WITH_MODULE(1-arg]
dnl SCOLD_WTIH_MODULE(3-arg) <---> HT_WITH_MODULE(2-arg]
dnl
dnl     SCOLD_WITH_MODULE([module-apple], [module-apple], [The Apple Module])
dnl     SCOLD_WITH_MODULE([module-banana], [module-banana], [The Banana Module])
dnl     SCOLD_WITH_MODULE([module-cherry], [module-cherry], [The Cherry Module])
dnl
dnl   becomes (1-arg, mandatory)
dnl     HT_WITH_MODULE([apple])
dnl     HT_WITH_MODULE([banana]]
dnl     HT_WITH_MODULE([cherry]]
dnl
AC_DEFUN([HTfriend_NOTICE_OF_BREAKING_CHANGE_SCOLD_PREFIX], [
    ifelse(m4_bpatsubst([$2], [module-.*], [module]), [module], [
        HT_MSG_DEPRECATED_USAGE([[SCOLD]_[WITH]_[$1]],
                                [[SCOLD]_[WITH]_[$1](changequote([{],[}])[$2]changequote({[},{]}), changequote([{],[}])[$3]changequote({[},{]}), changequote([{],[}])[$4]changequote({[},{]}))],
                                [[HT]_[WITH]_[MODULE](m4_bpatsubst([changequote([{],[}])[$2]changequote({[},{]})], [module-], []))])
    ], [ifelse([hypogeal-twilight], [$2], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([$1], [$2], [$3], [$4], [HYPOGEAL_TWILIGHT])
    ], [ifelse([incendiary-sophist], [$2], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([$1], [$2], [$3], [$4], [INCENDIARY_SOPHIST])
    ], [ifelse([vernacular-doggerel], [$2], [
        HTfriend_NOTICE_OF_HOOK_DEPRECATION([$1], [$2], [$3], [$4], [VERNACULAR_DOGGEREL])
    ], [
        HT_MSG_DEPRECATED_USAGE([[SCOLD]_[WITH]_[$1]],
                                [[SCOLD]_[WITH]_[$1](changequote([{],[}])[$2]changequote({[},{]}), changequote([{],[}])[$3]changequote({[},{]}), changequote([{],[}])[$4]changequote({[},{]}))],
                                [[HGTW]_[WITH]_[COMPONENT]([$2], [$3], [$4])])
    ])])])])
])

dnl HTfriend_NOTICE_OF_HOOK_DEPRECATION(with_suffix_word, name-dashes, name_underscores, explanation, replacement_suffix)
dnl HTfriend_NOTICE_OF_HOOK_DEPRECATION($1, $2, $3, $4, $5)
dnl
dnl    $1 - is one of the keywords COMMON, HEREIN, MODULE, SIBLING
dnl    $2 - argument name-with-dashes          e.g. hypogeal-twilight
dnl    $3 - argument name_with_underscores     e.g. hypogeal_twilight
dnl    $4 - explanation fragment               e.g. Hypogeal Twilight Build System
dnl    $5 - replacement macro name             e.g. HYPOGEAL_TWILIGHT suffixing HT_WITH_HYPOGEAL_TWILIGHT
dnl
dnl suitable for hypogeal-twilight, incendiary-sophist, vernacular-doggerel
dnl
AC_DEFUN([HTfriend_NOTICE_OF_HOOK_DEPRECATION], [
    HT_MSG_DEPRECATED_USAGE([SCOLD_[WITH]_[$1]],
                            [SCOLD_[WITH]_[$1](changequote([{],[}])[$2]changequote({[},{]}), changequote([{],[}])[$3]changequote({[},{]}), changequote([{],[}])[$4]changequote({[},{]}))],
                            [HT_[WITH]_[$5]])
])
