dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_COMPONENT_METADIRECTORY_TIERS             (no arguments)
dnl
dnl Arguments:
dnl
dnl     --with-submodules=DIRECTORY       e.g. ${PWD}/submodules       a directory of the current project
dnl     --with-siblings=DIRECTORY         e.g. /build/tunitas
dnl     --with-nearby=DIRECTORY           e.g. /build/something-something
dnl     --with-std-scold=DIRECTORY        e.g. /opt/scold
dnl
dnl For Tunitas Technologies, you'll want to have
dnl
dnl     --with-std-tunitas=DIRECTORY      e.g. /opt/tunitas
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
    ifdef([HGTW_COMPONENT_METADIRECTORY_TIERS], [
        HGTW_COMPONENT_METADIRECTORY_TIERS
    ], [
        SCOLD_COMPONENT_METADIRECTORY_TIERS
    ])
])
