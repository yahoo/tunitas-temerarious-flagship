dnl
dnl TF_WITH_MODULE(name-dashes, name_underscores, explanation)
dnl
dnl $1 = name_dashes as appears on the command line
dnl $2 = name_underscores as appears in a bash variable
dnl $3 = explanation, may be empty
dnl

AC_DEFUN([TF_DEFAULT_STD_VALUES], [
    AC_REQUIRE([SCOLD_DEFAULT_STD_VALUES])
    default_std_tunitas_prefix=/opt/tunitas
    : default_std_EXAMPLE_prefix=$default_default_prefix
])


AC_DEFUN([TF_WITH_MODULE], [
    SCOLD_WITH_MODULE([module-$1],
                       ifelse([$2], [],
                              m4_bpatsubst([module_$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                              [$2]),
                       ifelse([$3], [], [Module $1 Development Area], [$3]))
]) 
 
AC_DEFUN([TF_WITH_SUBSYSTEM], [
    SCOLD_WITH_MODULE([$1],
                      ifelse([$2], [], 
                             m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                             [$2]),
                      ifelse([$3], [], [Subsystem $1 Development Area], [$3]))
]) 

AC_DEFUN([TF_WITH_NONSTD], [
    SCOLD_WITH_NONSTD([$1],
                      ifelse([$2], [],
                             m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                             [$2]),
                      ifelse([$3], [], [The non-standard $1 Area], [$3]))
]) 

AC_DEFUN([TF_WITH_STD], [    
    AC_REQUIRE([TF_DEFAULT_STD_VALUES])
    SCOLD_WITH_STD([$1],
                   ifelse([$2], [],
                          m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                          [$2]),
                   ifelse([$3], [], [The standard $1 Area], [$3]))
])

