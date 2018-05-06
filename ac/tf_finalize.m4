dnl
dnl TF_FINALIZE    (no arguments)
dnl
dnl Finalize the configure.ac, the last thing in the specification; output the stuff.
dnl
dnl TF_OUTPUT - same thing, following the naming convention of AC_OUTPUT
dnl
dnl Some basic well-understood enablements
dnl

AC_DEFUN([TF_OUTPUT], [TF_FINALIZE])

AC_DEFUN([TF_FINALIZE], [
    if test NONE = $prefix ; then
       AC_MSG_WARN([prefix was not set so the default ${ac_default_prefix:-(unset)} will obtain])
    fi
    SCOLD_MAKE_OBJ_DIRECTORIES
    AC_OUTPUT
])
