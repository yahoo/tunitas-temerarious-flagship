dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_FINALIZE    (no arguments)
dnl
dnl Prefer TF_FINALIZE over AC_OUTPUT, but a call to AC_OUTPUT is required before EOF.
dnl
dnl Deprecations:
dnl
dnl   TF_OUTPUT - same thing, following the naming convention of AC_OUTPUT
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_FINALIZE    (no arguments)
dnl
dnl Finalize the configure.ac.
dnl This should be the the last thing in the specification
dnl Output the Makefile.in et al.
dnl
dnl Deprecated:
dnl
dnl   TF_OUTPUT - same thing, following the naming convention of AC_OUTPUT
dnl

AC_DEFUN([TF_OUTPUT], [
  TF_MSG_VERBOSE([[TF]_[OUTPUT] is deprecated, instead use [TF]_[OUTPUT]])
  TF_FINALIZE
])

AC_DEFUN([TF_FINALIZE], [
    if test NONE = $prefix ; then
       AC_MSG_WARN([prefix was not set so the default ${ac_default_prefix:-(unset)} will obtain])
    fi
    ifdef([HGTW_FINALIZE], [
        dnl Use the new way when possible.
        HGTW_FINALIZE
    ], [
        dnl Else open code it
        ifdef([HGTW_MAKE_OBJ_DIRECTORIES], dnl but still shutup deprecation warnings
              [HGTW_MAKE_OBJ_DIRECTORIES],
              [SCOLD_MAKE_OBJ_DIRECTORIES])
        AC_OUTPUT
    ])
])
