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
    AC_REQUIRE([TF_WITH_STD_TUNITAS])
    AC_REQUIRE([TF_WITH_TEMERARIOUS_FLAGSHIP])
    if test NONE = $prefix ; then
       AC_MSG_WARN([prefix was not set so the default ${ac_default_prefix:-(unset)} will obtain])
    fi
    SCOLD_MAKE_OBJ_DIRECTORIES
    AC_OUTPUT
])
