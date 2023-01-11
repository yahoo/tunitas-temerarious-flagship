dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE
dnl
dnl TF_PREVENT([old-name], [new-name])
dnl
dnl TF_REDIRECT([old-name], [new-name])                     the new-body is optional and is new-name (without arguments)
dnl TF_REDIRECT([old-name], [new-name], [new-body])         the new-body is supplied
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([TF_PREVENT], [
          ifdef([HT_PREVENT], [
                    HT_PREVENT([$1], [$2], [$3])
                ], [
                    ifelse([$1], [], [AC_ERROR([empty OLD in [HT_PREVENT](...)])])
                    ifelse([$2], [], [AC_ERROR([empty NEW in [HT_PREVENT]([$1], ...)])])
                    AC_MSG_NOTICE([use the name [$2] instead of [$1]])
                    AC_MSG_NOTICE([the name [$1] has been deprecated in favor of [$1]])
                    AC_MSG_NOTICE([you MUST modify the call site to to use [$1]])
                    AC_MSG_ERROR([nowadays, the name [$1] may not be used at all])
            ])
])
AC_DEFUN([TF_REDIRECT], [
          ifdef([HT_REDIRECT], [
                    HT_REDIRECT([$1], [$2], [$3])
                ], [
                    ifelse([$1], [], [AC_ERROR([empty OLD in [HT_REDIRECT](...)])])
                    ifelse([$2], [], [AC_ERROR([empty NEW in [HT_REDIRECT]([$1]...)])])
                    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
                    HT_MSG_DEPRECATED([[$1]], [[$2]])
                    ifelse([$3], [], [$2], [$3])
                ])
])
