dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.

dnl
dnl TF_COMPONENT_METADIRECTORY_TIERS             (no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_COMPONENT_METADIRECTORY_TIERS             (no arguments)
dnl
dnl defines
dnl
dnl     <strike>--with-external=<choice></strike>       rather, prefer --with-nearby=ROOT
dnl     --with-submodules=<choice>
dnl
dnl does not define
dnl     --with-std-tunitas=<choice>
dnl     --with-std-scold=<choice>
dnl
AC_DEFUN([TF_COMPONENT_METADIRECTORY_TIERS], [
    SCOLD_COMPONENT_METADIRECTORY_TIERS
])
