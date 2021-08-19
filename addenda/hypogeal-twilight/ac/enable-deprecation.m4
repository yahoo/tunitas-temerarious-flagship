dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_ENABLE_DEPRECATION_NOTIFICATION       (no arguments)
dnl
dnl HT_MSG_DEPRECATED(concept)
dnl HT_MSG_DEPRECATED(concept, successor)
dnl
dnl HT_MSG_DEPRECATED_API(concept)
dnl HT_MSG_DEPRECATED_API(concept, successor)
dnl
dnl HT_MSG_DEPRECATED_USAGE(symbol, concept)
dnl HT_MSG_DEPRECATED_USAGE(symbol, concept, successor)
dnl
dnl HT_MSG_DEPRECATED_OPTION(concept)
dnl HT_MSG_DEPRECATED_OPTION(concept, successor)
dnl
dnl [[deprecated]] HGTW_ENABLE_DEPRECATION_NOTIFICATION       (no arguments)
dnl [[deprecated]] HGTW_MSG_DEPRECATED(concept)
dnl [[deprecated]] HGTW_MSG_DEPRECATED(concept, successor)
dnl
dnl [[deprecated]] SCOLD_ENABLE_DEPRECATION_NOTIFICATION       (no arguments)
dnl [[deprecated]] SCOLD_MSG_DEPRECATED(concept)
dnl [[deprecated]] SCOLD_MSG_DEPRECATED(concept, successor)
dnl
dnl Deprecations
dnl   The 'SCOLD' prefix.
dnl
dnl Purpose:
dnl
dnl   HT_ENABLE_DEPRECATION_NOTIFICATION
dnl
dnl     enables the option
dnl     --disable-deprecation-notification ... turns off deprecation notification
dnl
dnl HT_MSG_DEPRECATED(concept [,successor])
dnl
dnl     emits the messaging explaining the deprecation of concept.
dnl     emits the messaging suggesting the use of the successor.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl No point in giving deprecation warnings in the deprecation warning system.
dnl Just do it: provide compatibility and a bridge to the future, and shut up.

dnl
dnl HT_ENABLE_DEPRECATION_NOTIFICATIN       (no arguments)
dnl
AC_DEFUN([SCOLD_ENABLE_DEPRECATION_NOTIFICATION], [HT_ENABLE_DEPRECATION_NOTIFICATION])
AC_DEFUN([HGTW_ENABLE_DEPRECATION_NOTIFICATION],  [HT_ENABLE_DEPRECATION_NOTIFICATION])
AC_DEFUN([HT_ENABLE_DEPRECATION_NOTIFICATION], [
    AC_MSG_CHECKING([deprecation notification messaging])
    AC_ARG_ENABLE([deprecation-notification],
                  [AS_HELP_STRING([--disable-deprecation-notification], [disable configure-time deprecation notifications])],
                  [: already set],
                  [enable_deprecation_notification=yes])
    AC_MSG_RESULT([$enable_deprecation_notification]) 
])

dnl
dnl HT_MSG_DEPRECATED(concept)                   the concept is deprecated
dnl HT_MSG_DEPRECATED(concept, alternate]        the concept is deprecated, use the alternate
dnl
dnl the concept and the alternate MUST be an m4 symbol,
dnl these are transformed into a shell variable
dnl
AC_DEFUN([SCOLD_MSG_DEPRECATED], [HT_MSG_DEPRECATED_API([$1], [$2])])
AC_DEFUN([HGTW_MSG_DEPRECATED],  [HT_MSG_DEPRECATED_API([$1], [$2])])
AC_DEFUN([HT_MSG_DEPRECATED],    [HT_MSG_DEPRECATED_API([$1], [$2])])

dnl
dnl HT_MSG_DEPRECATED_USAGE(symbol, old, new]      the old usage is deprecated, use the new usage
dnl
dnl $1 - symbol ----- is a unique m4 variable name, likely the m4 function name
dnl $2 - deprecated - the deprecate usage (in full call-site form)
dnl $3 - alternate -- the alternative form (in full call-site form)
dnl
AC_DEFUN([SCOLD_MSG_DEPRECATED_USAGE], [HT_MSG_DEPRECATED_USAGE([$1], [$2])])
AC_DEFUN([HGTW_MSG_DEPRECATED_USAGE],  [HT_MSG_DEPRECATED_USAGE([$1], [$2])])
AC_DEFUN([HT_MSG_DEPRECATED_USAGE], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    ifelse([$1], [], [
        AC_MSG_ERROR([empty first argument to [HT]_[MSG]_[DEPRECATED_USAGE]])
    ], [
        if test xno != x${__emitted_$1:-no}
        then
            __emitted_$1=yes
            if test xyes = x"${enable_deprecation_notification:-yes}"
            then
                AC_MSG_NOTICE([deprecation: avoid $2])
                ifelse([$2], [],
                       [: ok],
                       [AC_MSG_NOTICE([deprecation: instead, use $3])])
            fi
        fi
    ])
])

dnl
dnl HT_MSG_DEPRECATED_API(concept)                   the concept is deprecated
dnl HT_MSG_DEPRECATED_API(concept, alternate]        the concept is deprecated, use the alternate
dnl
AC_DEFUN([SCOLD_MSG_DEPRECATED_API], [HT_MSG_DEPRECATED_API([$1], [$2])])
AC_DEFUN([HGTW_MSG_DEPRECATED_API],  [HT_MSG_DEPRECATED_API([$1], [$2])])
AC_DEFUN([HT_MSG_DEPRECATED_API], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    ifelse([$1], [], [
        AC_MSG_ERROR([empty first argument to [HT]_[MSG]_[DEPRECATED_API]])
    ], [
        if test xno != x${__emitted_$1:-no}
        then
            __emitted_$1=yes
            if test xyes = x"${enable_deprecation_notification:-yes}"
            then
                AC_MSG_NOTICE([deprecation: avoid $1])
                ifelse([$2], [],
                       [: ok],
                       [AC_MSG_NOTICE([deprecation: instead, use $2])])
            fi
        fi
    ])
])

dnl
dnl HT_MSG_DEPRECATED_OPTION(concept)                   the concept is deprecated
dnl HT_MSG_DEPRECATED_OPTION(concept, alternate]        the concept is deprecated, use the alternate
dnl
dnl There is no guard against duplicate messaging
dnl
dnl Grammar:
dnl
dnl   "the option" is prepended to the messaging
dnl
dnl Example:
dnl
dnl   HT_MSG_DEPRECATED_OPTION([--with-this-old-thing=THAT], [--with-certain-new-thing=OTHER])
dnl
AC_DEFUN([SCOLD_MSG_DEPRECATED_OPTION], [HT_MSG_DEPRECATED_OPTION([$1], [$2])])
AC_DEFUN([HGTW_MSG_DEPRECATED_OPTION],  [HT_MSG_DEPRECATED_OPTION([$1], [$2])])
AC_DEFUN([HT_MSG_DEPRECATED_OPTION], [
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    ifelse([$1], [], [
        AC_MSG_ERROR([empty first argument to [HT]_[MSG]_[DEPRECATED_OPTION]])
    ], [
        if test xyes = x"${enable_deprecation_notification:-yes}"
        then
            AC_MSG_NOTICE([deprecation: avoid the option $1])
            ifelse([$2], [],
                   [: ok],
                   [AC_MSG_NOTICE([deprecation: instead, use the option $2])])
        fi
    ])
])
