dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_FINALIZE                  (no arguments)
dnl
dnl [[deprecated]] HT_FINALIZE
dnl [[deprecated]] HGTW_FINALIZE
dnl [[deprecated]] SCOLD_FINALIZE
dnl
dnl [[error]] SCOLD_OUTPUT
dnl [[error]] HGTW_OUTPUT
dnl [[error]] HT_OUTPUT
dnl
dnl Deprecations:
dnl   The 'HGTW' prefix.
dnl   The 'SCOLD' prefix.
dnl   Certain confusing names from the baseline autoconf;
dnl     these never were part of the public interface, but are common mistakes.
dnl
dnl Purpose:
dnl
dnl   In lieu of AC_OUTPUT, calls AC_OUTPUT and performs other finalization functions.
dnl
dnl Expectation:
dnl
dnl   The use of HGTW_FINALIZE must be the last statement in configure.ac
dnl
dnl Postcondition:
dnl
dnl   The mk/configured.mk, mk/extracted.mk definitions are created
dnl     ./mk/configured.mk contains definitions of the hypogeal_twilight and vernacular_doggerel series.
dnl     ./mk/extracted.mk contains definitions for MODULE_NAME, MODULE_VERSION, MODULE_RELEASE.
dnl   The scold-compiler ./obj directories are created
dnl   A report is emitted summarizing the configuration.
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([SCOLD_OUTPUT], [HTinternal_BADCALL_ERROR_MESSAGE_QUIT([[SCOLD]_[OUTPUT]])])
AC_DEFUN([HGTW_OUTPUT],  [HTinternal_BADCALL_ERROR_MESSAGE_QUIT([[HGTW]_[OUTPUT]])])
AC_DEFUN([HT_OUTPUT],    [HTinternal_BADCALL_ERROR_MESSAGE_QUIT([[HT]_[OUTPUT]])])

dnl
dnl HGTW_FINALIZE
dnl
dnl in lieu of AC_OUTPUT
dnl
AC_DEFUN([SCOLD_FINALIZE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[FINALIZE]], [HT_[FINALIZE]])
    HT_FINALIZE
]) 
AC_DEFUN([HGTW_FINALIZE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[FINALIZE]], [HT_[FINALIZE]])
    HT_FINALIZE
]) 
AC_DEFUN([HT_FINALIZE], [
    HTinternal_FINALIZE_WARNING_ABOUT_DC
    HGTW_FINALIZE_CONFIGURED
    # was SCOLD_MAKE_OBJ_DIRECTORIES, but that is deprecated; no longer required
    __directories="obj obj/include obj/modules obj/src"
    if mkdir -p ${__directories?}; then
        AC_MSG_NOTICE([made the SCOLD working directories ${__directories?}])
    else
        AC_MSG_ERROR([could not make the SCOLD working directories ${__directories?}])
    fi
    HGTW_REPORT_FINALIZE
    AC_OUTPUT
])

AC_DEFUN([HTinternal_FINALIZE_WARNING_ABOUT_DC], [
    if test 1 != ${HGTW_CHECK_DC_was_called:-0} ; then
        HGTW_MSG_WARNING([A call to [HGTW]_[CHECK]_[DC] never occurred])
        HGTW_MSG_NOTICE([Use [HGTW]_[CHECK]_[DC] in the tools section near [HGTW]_[CHECK]_[GCC]])
    fi
    if test 1 != ${HGTW_PROG_DC_was_called:-0} ; then
        HGTW_MSG_WARNING([A call to [HGTW]_[PROG]_[DC] never occurred])
        dnl configure:4808: error: possibly undefined macro: AC_PROG_CXX
        dnl If this token and others are legitimate, please use m4_pattern_allow.
        dnl See the Autoconf documentation.
        dnl
        dnl ... and so we need the double quotes, which then shows up in the output
        dnl
        dnl here ---------------------------------------------------------\\\\\\ (here)
        dnl                                                               ||||||
        dnl                                                               vvvvvv
        HGTW_MSG_NOTICE([Use [HGTW]_[PROG]_[DC] in the tools section near [[AC]]_[PROG]_[CXX]])
    fi
])
AC_DEFUN([HTinternal_BADCALL_ERROR_MESSAGE_QUIT], [
    HGTW_MSG_NOTICE([there is no $1, only HT_[FINALIZE]])
    HGTW_MSG_ERROR([use HT_[FINALIZE] instead])
    dnl
    dnl But add the AC_OUTPUT in anyway because automake does static analysis of the configure.ac
    dnl and if it doesn't find the elements of AC_OUTPUT then it complains with the very cryptic
    dnl message as follows:
    dnl
    dnl   autoheader -I /build/useful/on/m4 -I /build/scold/hypogeal-twilight/ac
    dnl   autoconf -I /build/useful/on/m4 -I /build/scold/hypogeal-twilight/ac
    dnl   hack_in_the_HGTW_APPEND_SUBCONFIGURE_ARGUMENT
    dnl   automake --add-missing --foreign --include-deps
    dnl   /usr/share/automake-1.16/am/check2.am: error: am__EXEEXT does not appear in AM_CONDITIONAL
    dnl   automake exit 1
    dnl
    AC_OUTPUT
])
