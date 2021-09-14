dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_REPORT_FINALIZE
dnl
dnl Is called from HGTW_FINALIZE, there is no need to call it directly.
dnl
dnl Example
dnl
dnl    [[current]]
dnl    HGTW_FINALIZE
dnl
dnl [[deprecating]]
dnl
dnl   SCOLD_REPORT_FINALLY([components-list])          was standalone, is deprecating
dnl                         The components-list is a list of variable names
dnl
dnl   Example:
dnl
dnl     SCOLD_REPORT_FINALLY([module-c
dnl                           module-std
dnl                           module-cpp
dnl                           module-unit-rigging])
dnl
AC_DEFUN([SCOLD_REPORT_FINALLY], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[REPORT]_[FINALLY]], [HGTW_[FINALIZE]])
    HGTWinternal_REPORT_EXPLICIT_MODULE_ACCRETION_LIST([ $1 ])
])
AC_DEFUN([HGTW_REPORT_FINALIZE], [
    HGTWinternal_REPORT_EXPLICIT_MODULE_ACCRETION_LIST([ $with_module_accretion_list ])
])

dnl
dnl HGTWinternal_REPORT_EXPLICIT_MODULE_ACCRETION_LIST([...list...])
dnl
dnl The ...list... is a list of components which must be supplied explicitly.
dnl
dnl [[current]]     HGTW_REPORTd]_FINALIZE supplies with_module_accretion_list
dnl                 and its value is guaranteed to be in sync with the rest of configure.ac.
dnl [[deprecating]] SCOLD_REPORT_FINALLY supplies it explicitly,
dnl                 and hopefully it is in sync with the rest of configure.ac.
dnl
AC_DEFUN([HGTWinternal_REPORT_EXPLICIT_MODULE_ACCRETION_LIST], [
    AC_MSG_NOTICE([finally($NAME): in $(pwd)])
    if test x$devel_prefix != x ; then dnl --with-devel=ROOT is deprecated
        AC_MSG_NOTICE([finally($NAME): (the deprecated) --with-devel sets devel_prefix=$devel_prefix])
    fi 
    AC_MSG_NOTICE([finally($NAME): prefix=${prefix?(unset)}])
    dnl HGTW_WITH_META_DIRECTORY establishes these
    AC_MSG_NOTICE([finally($NAME): submodules_metadir=${submodules_metadir:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): siblings_metadir=${siblings_metadir:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): nearby_metadir=${nearby_metadir:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): (deprecating) external_metadir=${external_metadir:-(unset)}])
    dnl [[DEPRECATED]] SCOLD_WITH_MODULE (HEREIN, SIBLING, etc.) establishes these
    dnl components as submodules herein in ${subdirs}
    AC_MSG_NOTICE([finally($NAME): subdirs=${subdirs:-(is empty)}])

    AC_MSG_NOTICE([finally($NAME): (deprecating) external=${external:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): (deprecating) submodules=${submodules:-(unset)}])
    dnl the scold- scold_ prefix is deprecated
    AC_MSG_NOTICE([finally($NAME): (deprecated) scold_anguish_answer_prefix=${scold_anguish_answer_prefix:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): (deprecated) scold_hypogeal_twilight_prefix=${scold_hypogeal_twilight_prefix:-(unset)}])
    dnl anguish-answer is the 1st generation of the SCOLD compiler; use --std-scold intead
    AC_MSG_NOTICE([finally($NAME): (deprecating) anguish_answer_prefix=${anguish_answer_prefix:-(unset)}])
    dnl baleful-ballad is the 2nd generation of the SCOLD compiler; use --std-scold instead
    AC_MSG_NOTICE([finally($NAME): (deprecating) baleful_ballad_prefix=${baleful_ballad_prefix:-(unset)}])
    dnl components as ancillaries
    function __warn_if_used() {
        # tag is, e.g., 'gcc' for nonstd-gcc
        local bad_tag=[$]1; shift
        local good_tag=[$]1; shift
        local nonstd_bad_tag="nonstd-${bad_tag?}"
        local nonstd_good_tag="nonstd-${good_tag?}"
        local subject_name="nonstd_${bad_tag?}_prefix"
        local subject_value;
        eval "subject_value=\"\${${subject_name?}:-xyzzy}\""
        if test xyzzy != "${subject_value?}" ; then
              AC_MSG_WARN([finally($NAME): ${subject_name?}=${subject_value?}, but there is no ${nonstd_bad_tag?}, only ${nonstd_good_tag?}])
        fi
    }
    __warn_if_used json jsoncpp
    __warn_if_used mysql mysqlpp
    dnl m4_split     -- NO -- it makes [word], [word], [word]
    dnl m4_normalize -- YES -- it splits the words on whitespace
    for herein in m4_normalize(m4_bpatsubst([$1], [-], [_])); do
        herein=${herein//-/_}
        eval "message=\"finally($NAME): ${herein}_prefix=\${${herein}_prefix:-(unset)}\""
        AC_MSG_NOTICE([$message])
    done
    AC_MSG_NOTICE([finally($NAME): PACKAGE_NAME=${PACKAGE_NAME:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): PACKAGE_VERSION=${PACKAGE_VERSION:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): PACKAGE_MAJOR=${PACKAGE_MAJOR:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): PACKAGE_MINOR=${PACKAGE_MINOR:-(unset)}])
    AC_MSG_NOTICE([finally($NAME): PACKAGE_PATCH=${PACKAGE_PATCH:-(unset)}])
    HGTW_MSG_DEBUG([now ac_sub_configure_args=$ac_sub_configure_args])
])
