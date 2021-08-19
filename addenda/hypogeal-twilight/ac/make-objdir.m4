dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl [[deprecated]] SCOLD_MAKE_OBJ_DIRECTORIES     (no arguments)
dnl
dnl Subsumed into HGTW_FINALIZE
dnl Remains for compatibility with older schemes of configure.ac where a separate step was required.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl [[deprecated]] SCOLD_MAKE_OBJ_DIRECTORIES    (no macro arguments)
dnl
dnl (was) suitable for use in AC_REQUIRE
dnl From hypogeal-twilight >= 0.45.0-0.devel, the function is subsumed into HGTW_FINALIZE
dnl
dnl But make some directories anyway because there exis old old old systems that still depend upon
dnl SCOLD_MAKE_OBJ_DIRECTORIES having some function at all.  c.f. the example, as sketched below
dnl
dnl The compatibility example is for old configuration code that expects to call only 
dnl SCOLD_MAKE_OBJ_DIRECTORIES and AC_OUTPUT in succession.  An example is shown below.
dnl
dnl Old Example (compatibility scenario):
dnl
dnl     AC_DEFUN([XYZ_FINALIZE], [
dnl         if test NONE = $prefix ; then
dnl            AC_MSG_WARN([prefix was not set so the default ${ac_default_prefix:-(unset)} will obtain])
dnl         fi
dnl         SCOLD_MAKE_OBJ_DIRECTORIES <------------------ deprecated usage ... instead use HGTW_FINALIZE
dnl         AC_OUTPUT <----------------------------------- deprecated usage ... instead call HGTW_FINALIZE
dnl     ])
dnl
AC_DEFUN([SCOLD_MAKE_OBJ_DIRECTORIES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([[SCOLD]_[MAKE]_[OBJ]_[DIRECTORIES]], [[HGTW]_[FINALIZE]])
    __directories="obj obj/include obj/modules obj/src"
    if mkdir -p ${__directories?}; then
        AC_MSG_NOTICE([DEPRECATION-COMPATIBILITY (FIX configure.ac) made the SCOLD working directories ${__directories?}])
    else
        AC_MSG_ERROR([could not make the SCOLD working directories ${__directories?}])
    fi
])
