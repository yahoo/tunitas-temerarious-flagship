dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_WITH_OPT(name-dashes, name-underscores, description)
dnl
dnl TF_WITH_OPT_TUNITAS             (no arguments)
dnl TF_WITH_OPT_SCOLD               (no arguments)
dnl 
dnl TF_DEFAULT_OPT_VALUES           (no arguments)
dnl
dnl Deprecated: (prefer the "OPT" variants as s/STD/OPT/)
dnl
dnl   TF_WITH_STD(name-dashes, name-underscores, description)
dnl   TF_WITH_STD_TUNITAS             (no arguments)
dnl   TF_WITH_STD_SCOLD               (no arguments)
dnl   TF_DEFAULT_STD_VALUES           (no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------
AC_DEFUN([TF_WITH_STD_SCOLD],     [TF_REDIRECT([TF_WITH_STD_SCOLD],     [TF_WITH_OPT_SCOLD])])
AC_DEFUN([TF_WITH_STD_TUNITAS],   [TF_REDIRECT([TF_WITH_STD_TUNITAS],   [TF_WITH_OPT_TUNITAS])])
AC_DEFUN([TF_WITH_STD],           [TF_REDIRECT([TF_WITH_STD],           [TF_WITH_OPT], [TF_WITH_OPT([$1], [$2], [$])])])
AC_DEFUN([TF_DEFAULT_STD_VALUES], [
    TF_REDIRECT([TF_DEFAULT_STD_VALUES], [TF_DEFAULT_OPT_VALUES])
    default_std_tunitas_prefix=${default_opt_tunitas_prefix?} # because older code expects this variable to be established
])

dnl
dnl TF_DEFAULT_OPT_VALUES            (no arguments)
dnl
AC_DEFUN([TF_DEFAULT_OPT_VALUES], [
    ifdef([HT_DEFAULT_OPT_VALUES], dnl prefer the modern stylings, avoid the warning messages of the old
          [ifdef([HGTW_DEFAULT_OPT_VALUES],
                 [AC_REQUIRE([HGTW_DEFAULT_STD_VALUES])],
                 [AC_REQUIRE([SCOLD_DEFAULT_STD_VALUES])])])
    default_opt_tunitas_prefix=/opt/tunitas
    : default_opt_EXAMPLE_prefix=$default_default_prefix
])

dnl
dnl TF_WITH_OPT_TUNITAS      (no arguments)
dnl
dnl The preferred form, as zero-argument so it can be used in AC_REQUIRE
dnl
AC_DEFUN([TF_WITH_OPT_TUNITAS], [
    TF_WITH_OPT([tunitas], [tunitas], [The Standard Tunitas Installation Area])
])

dnl
dnl TF_WITH_OPT_SCOLD      (no arguments)
dnl
dnl The preferred form, as zero-argument so it can be used in AC_REQUIRE
dnl
AC_DEFUN([TF_WITH_OPT_SCOLD], [    
    TF_WITH_OPT([scold], [scold], [The Standard S.C.O.L.D. Installation Area])
])

dnl
dnl TF_WITH_OPT(subsystem)
dnl $1 - subsystem, e.g. scold, tunitas, state-space, hyperledger, hyperledger/fabric, hyperledger/sawtooth, hyperledger/iroha, etc.
dnl
dnl Usage:
dnl
dnl   TF_WITH_OPT([scold])
dnl
AC_DEFUN([TF_WITH_OPT], [    
    AC_REQUIRE([TF_DEFAULT_OPT_VALUES])
    TFinternal_WITH_OPT([$1],
                        ifelse([$2], [],
                               m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                               [$2]),
                        ifelse([$3], [], [The Standard $1 Area], [$3]))
])
AC_DEFUN([TFinternal_WITH_OPT], [
    dnl
    dnl HT_WITH_OPT else HT_WITH_STD but there are many other compatibility layers ni between
    dnl
    ifdef([HT_WITH_OPT],
          [HT_WITH_OPT([$1], [$2], [$3])],
          [ifdef([HGTW_WITH_OPT],
                 [HGTW_WITH_OPT([$1], [$2], [$3])],
                 [ifdef([SCOLD_WITH_OPT],
                        [SCOLD_WITH_OPT([$1], [$2], [$3])],
                        [ifdef([HT_WITH_STD],
                              [ifdef([HGTW_WITH_STD],
                                     [HGTW_WITH_STD([$1], [$2], [$3])],
                                     [SCOLD_WITH_STD([$1], [$2], [$3])])])])])])
])
