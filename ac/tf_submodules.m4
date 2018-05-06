dnl
dnl TF_CONFIG_SUBMODULES(submodulesdir, submodules-list)
dnl
dnl $1 - submodulesdir is the submodules directory
dnl      e.g. submodules to nominate ./submodules       
dnl $2 - submodules-list is the list of submodules found within that directory
dnl      as a single string, space separated, no commas, no commentariat
dnl      e.g. [hypogeal-twilight module-std module-nonstd]
dnl

AC_DEFUN([TF_CONFIG_SUBMODULES], [SCOLD_CONFIG_SUBMODULES([$1], [$2])])
