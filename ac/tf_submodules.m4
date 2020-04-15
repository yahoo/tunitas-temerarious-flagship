dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.

dnl
dnl TF_CONFIG_SUBMODULES(submodulesdir, submodules-list)
dnl
dnl [[advice]] It's worth avoiding the use of submodules.  They are usable, but clunky.
dnl
dnl Usage:
dnl   Makefile.am:   SUBDIRS = @subdirs@
dnl   configure.ac:  TF_CONFIG_SUBMODULES(submodulesdir, submodules-list)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_CONFIG_SUBMODULES(submodulesdir, submodules-list)
dnl
dnl $1 - submodulesdir is the submodules directory
dnl      e.g. submodules to nominate ./submodules       
dnl $2 - submodules-list is the list of submodules found within that directory
dnl      as a single string, space separated, no commas, no commentariat
dnl      e.g. [hypogeal-twilight module-std module-nonstd]
dnl
AC_DEFUN([TF_CONFIG_SUBMODULES], [
  ifdef([HGTW_CONFIG_SUBMODULES], [
      HGTW_CONFIG_SUBMODULES([$1], [$2])
  ], [
      SCOLD_CONFIG_SUBMODULES([$1], [$2])
  ])
])
