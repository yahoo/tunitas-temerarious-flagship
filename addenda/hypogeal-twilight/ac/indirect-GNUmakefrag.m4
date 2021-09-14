dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl [[deprecated]] SCOLD_INDIRECT_GNUmakefrag(pathname)
dnl
dnl AVOID - do not use in any new work.
dnl Instead prefer to use the two-step method
dnl There is no 'HGTW'-prefixed successor at all.
dnl
dnl example
dnl   INDIRECT_GNUmakefrag([src/jolly/goodcode])
dnl
AC_DEFUN([SCOLD_INDIRECT_GNUmakefrag], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[INDIRECT]_GNUmakefrag])
    HGTWinternal_INDIRECT_GNUmakefrag_FILES_denormalized([$1],
                                                         [m4_changequote([{], [}]) dnl WATCHOUT - newlines
                                                          m4_bpatsubst({$1/GNUmakefrag}, {[-./]}, {_}) dnl WATCHOUT newlines
                                                          m4_changequote({[}, {]})],
                                                         [$1/Makefrag.am],
                                                         [$1/GNUmakefrag.mk])
  ])

dnl
dnl SCOLD_INDIRECT_GNUmakefrag_FILES(directory, shell_variable, .../Makefrag.am, .../GNUmakefrag.mk)
dnl
dnl example
dnl     SCOLD_INDIRECT_GNUmakefrag_FILES([src/tests/unit],
dnl                                      [src_tests_unit_GNUmakefrag],
dnl                                      [src/tests/unit/Makefrag.am],
dnl                                      [src/tests/unit/GNUmakefrag.mk])
dnl
AC_DEFUN([SCOLD_INDIRECT_GNUmakefrag_FILES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[INDIRECT]_[GNUmakefrag]_FILES])
    HGTWinternal_INDIRECT_GNUmakefrag_FILES_denormalized([$1], [$2], [$3], [$4])
])
dnl
dnl HGTWinternal_INDIRECT_GNUmakefrag_FILES_denormalized(directory, variable, .../Makefrag.am, .../GNUmakefrag.mk)
dnl HGTWinternal_INDIRECT_GNUmakefrag_FILES_normalized(directory, variable, .../Makefrag.am, .../GNUmakefrag.mk)
dnl
dnl $1 - directory
dnl $2 - subst variable based on the .../GNUmakefrag name to appear as @$2@
dnl $3 - path to .../Makefrag.am
dnl $4 - path to .../GNUmakefrag.mk
dnl
AC_DEFUN([HGTWinternal_INDIRECT_GNUmakefrag_FILES_denormalized], [
    HGTWinternal_INDIRECT_GNUmakefrag_FILES_normalized(m4_normalize($1), m4_normalize($2), m4_normalize($3), m4_normalize($4))
])
AC_DEFUN([HGTWinternal_INDIRECT_GNUmakefrag_FILES_normalized], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    dnl
    dnl https://www.gnu.org/software/autoconf/manual/autoconf-2.63/html_node/Redefined-M4-Macros.html
    dnl     patsubst -> m4_bpatsubst
    dnl something about how m4 v2.0 will have "real extended regex"
    dnl
    dnl Example expected result:
    dnl
    dnl let $1 = src/coreutils/mktemp/GNUmakefrag
    dnl generate
    dnl      src_coreutils_mktemp_GNUmakefrag=src/coreutils/mktemp/GNUmakefrag.mk
    dnl      AC_SUBST_FILE(src_coreutils_mktemp_GNUmakefrag)
    dnl
    dnl where the Makefile.am or Makefrag.am contains a line
    dnl
    dnl     @src_coreutils_mktemp_GNUmakefrag@
    dnl
    dnl IRKSOME - if the substitution is mis-stated, the path is misspelled
    dnl there is no error or warning message, the @...@ pattern is merely not substituted.
    dnl and you see a Makefile syntax error
    dnl
    indirect_missing=0
    for f in $3 $4; do
        if test ! -f $f ; then
            indirect_missing=1
            AC_MSG_WARN([missing $f])
        fi
    done
    if test 0 != $indirect_missing; then 
        AC_MSG_ERROR([in $1, there are missing Makefile fragments for the indirect substitution])
    fi
    if ! grep -q -e @$2@ $3 ; then
        AC_MSG_ERROR([in $3, there is no token @$2@])
    fi
    $2=$4
    AC_SUBST_FILE($2)
    HGTW_MSG_VERBOSE([substituting as $2=$4 in $3 to include $4],
                     [including $4])
])
