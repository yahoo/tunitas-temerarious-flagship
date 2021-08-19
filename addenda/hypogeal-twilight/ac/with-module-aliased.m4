dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes, oldname4-dashes)
dnl
dnl [[deprecated]] HGTW_WITH_ALIASED_MODULE(newname-dashes, oldname-dashes, description)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes)
dnl HGTW_WITH_MODULE_ALIASED(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes, oldname4-dashes)
dnl
dnl $1 - newname-dashes         is the new name of the module
dnl $2 - oldname-dashes         is the old name1 of the module, is deprecating
dnl $3 - oldname-dashes         is the old name2 of the module, is deprecating
dnl $4 - oldname-dashes         is the old name3 of the module, is deprecating
dnl $5 - oldname-dashes         is the old name4 of the module, is deprecating
dnl
dnl The newname and oldname have dashes, not underscores
dnl the "module-" prefix is added to oldname, newname
dnl
dnl Usage:
dnl
dnl     HGTW_WITH_MODULE_ALIASED(string, c-string)
dnl     HGTW_WITH_MODULE_ALIASED(rigging, rigging-unit, unit-rigging)
dnl     HGTW_WITH_MODULE_ALIASED(rig, rigging, rigging-unit, unit-rigging, unit-rigging-testsuite)
dnl
AC_DEFUN([HGTW_WITH_MODULE_ALIASED], [
    ifelse([$1], [], [ : fine ], [
        HTprivate_ALIAS_NO_MODULE_PREFIX([$1])
    ])
    ifelse([$2], [], [ : fine ], [
        HTprivate_ALIAS_NO_MODULE_PREFIX([$2])
    ])
    ifelse([$3], [], [ : fine ], [
        HTprivate_ALIAS_NO_MODULE_PREFIX([$3])
    ])
    ifelse([$4], [], [ : fine ], [
        HTprivate_ALIAS_NO_MODULE_PREFIX([$4])
    ])
    ifelse([$5], [], [ : fine ], [
        HTprivate_ALIAS_NO_MODULE_PREFIX([$5])
    ])
    ifelse([$3], [], [
        HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM([module-$1], [module-$2])
    ], [ifelse([$4], [], [
        HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM([module-$1], [module-$2], [module-$3])
    ], [ifelse([$5], [], [
        HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM([module-$1], [module-$2], [module-$3], [module-$4])
    ], [ifelse([$6], [], [
        HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM([module-$1], [module-$2], [module-$3], [module-$4], [module-$5])
    ], [
        AC_MSG_ERROR([[HGTW]_[WITH]_[MODULE]_[ALIASED] accepts between two and five arguments])
    ]) ]) ]) ])
])

dnl
dnl [[deprecated]] HGTW_WITH_ALIASED_MODULE(newname-dashes, oldname-dashes, description)
dnl
dnl Usage:
dnl
dnl     HGTW_WITH_MODULE_ALIASED(string, c-string)
dnl     HGTW_WITH_MODULE_ALIASED(rigging-unit, unit-rigging, [Test Rigging])
dnl
AC_DEFUN([HGTW_WITH_ALIASED_MODULE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[WITH]_[ALIASED]_MODULE], [HGTW_[WITH]_[MODULE]_ALIASED])
    HGTW_WITH_MODULE_ALIASED([$1], [$2])
])

dnl HTprivate_ALIAS_NO_MODULE_PREFIX(newname-dashes, oldname-dashes, description)
dnl
dnl $1 - newname-dashes         is the new name of the module
dnl $2 - oldname-dashes         is the old name of the module, is deprecating
dnl $3 - description (short)    to which the callee appends " development area"
dnl
dnl Prove that $1 - name, does not contain a "module-" prefix
dnl
AC_DEFUN([HTprivate_ALIAS_NO_MODULE_PREFIX], [
   ifelse([module], m4_bpatsubst([$1], [^module.*], [module]),
          [AC_MSG_ERROR([Error: [HGTW]_[ALIAS]_[MODULE] argument 1 "module" prefix, remove that])])
])

dnl HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM(newname-dashes, oldname1-dashes)
dnl HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM(newname-dashes, oldname1-dashes, oldname2-dashes)
dnl HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes)
dnl HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM(newname-dashes, oldname1-dashes, oldname2-dashes, oldname3-dashes, oldname4-dashes)
dnl
AC_DEFUN([HTprivate_ALIAS_WITH_ALIASED_AMBIENT_SUBSYSTEM], [
    HTprivate_ALIAS_WAAS5([$1], m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]), [$2], [$3], [$4], [$5])
])

dnl HTprivate_ALIAS_WAAS5(newname-dashes, newname_underscores, oldname1-dashes)
dnl HTprivate_ALIAS_WAAS5(newname-dashes, newname_underscores, oldname1-dashes, oldname2-dashes)
dnl HTprivate_ALIAS_WAAS5(newname-dashes, newname_underscores, oldname1-dashes, oldname2-dashes, oldname3-dashes)
dnl HTprivate_ALIAS_WAAS5(newname-dashes, newname_underscores, oldname1-dashes, oldname2-dashes, oldname3-dashes, oldname4-dashes)
dnl
dnl $1 - newname-dashes,      is expected to have dashes
dnl $2 - newname_underscores, is expected to have underscores
dnl $3 - oldname1-dashes
dnl $4 - oldname2-dashes
dnl $5 - oldname3-dashes
dnl $6 - oldname4-dashes
dnl
dnl After all the setup and checkings. Do That Thing.
dnl
AC_DEFUN([HTprivate_ALIAS_WAAS5], [
    AC_REQUIRE([HGTW_AMBIENT_COMPONENT_SEARCHPATH])
    AC_REQUIRE([HGTW_WITH_STD_SCOLD]) dnl because compute_AMBIENT_COMPONENT_SEARCHPATH references ${std_scold_prefix}
    ifelse([$3], [], [ : fine ], [
        AC_ARG_ENABLE([$3],
                      [AS_HELP_STRING([--enable-$3], [ERROR use --with-$1=ROOT])],
                      [AC_MSG_ERROR([for --enable-$3, use --with-$1=ROOT, e.g. --with-$1=${prefix:-PREFIX}])])
    ])
    ifelse([$4], [], [ : fine ], [
        AC_ARG_ENABLE([$4],
                      [AS_HELP_STRING([--enable-$4], [ERROR use --with-$1=ROOT])],
                      [AC_MSG_ERROR([for --enable-$4, use --with-$1=ROOT, e.g. --with-$1=${prefix:-PREFIX}])])
    ])
    ifelse([$5], [], [ : fine ], [
        AC_ARG_ENABLE([$5],
                      [AS_HELP_STRING([--enable-$5], [ERROR use --with-$1=ROOT])],
                      [AC_MSG_ERROR([for --enable-$4, use --with-$1=ROOT, e.g. --with-$1=${prefix:-PREFIX}])])
    ])
    ifelse([$6], [], [ : fine ], [
        AC_ARG_ENABLE([$6],
                      [AS_HELP_STRING([--enable-$6], [ERROR use --with-$1=ROOT])],
                      [AC_MSG_ERROR([for --enable-$6, use --with-$1=ROOT, e.g. --with-$1=${prefix:-PREFIX}])])
    ])
    ifelse([$4], [], [
        HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [module $1], [$(compute_AMBIENT_COMPONENT_SEARCHPATH [$1], [$3])])
    ], [ifelse([$5], [], [
        HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [module $1], [$(compute_AMBIENT_COMPONENT_SEARCHPATH [$1], [$3], [$4])])
    ], [ifelse([$6], [], [
        HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [module $1], [$(compute_AMBIENT_COMPONENT_SEARCHPATH [$1], [$3], [$4], [$5])])
    ], [
        HGTW_WITH_AMBIENT_COMPONENT_AND_EXPLICIT_PROBING_CANDIDATES_LIST([$1], [$2], [module $1], [$(compute_AMBIENT_COMPONENT_SEARCHPATH [$1], [$3], [$4], [$5], [$6])])
    ]) ]) ])
])
