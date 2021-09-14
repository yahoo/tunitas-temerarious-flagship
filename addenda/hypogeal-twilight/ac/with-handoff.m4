dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR                  (no arguments)
dnl HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR_UNCONDITIONAL    (no arguments)
dnl
dnl The usage is very distributed
dnl
dnl ./configure argument
dnl    --with-rpmbuild-handoff-topdir=DIRECTORY
dnl    where DIRECTORY names a handoff area; with subdirectories $DIRECTORY/{SOURCES,SPECS,SRPMS}
dnl
dnl configure.ac
dnl    HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR      (but entailed in HGTW_ENABLE_MOCK_BUILD)
dnl
dnl Makefile.am
dnl    HANDOFF_TOPDIR = @HANDOFF_TOPDIR@
dnl
dnl package.spec (your package.spec)
dnl
dnl     Name: example
dnl     Version: 1.2.3
dnl     Release: %{this_release_handoff}
dnl
dnl .../vernacular-doggerel/mk/handoff.mk        uses HANDOFF_TOPDIR
dnl .../vernacular-doggerel/rpm/macros.handoff   uses %declare_handoff, %
dnl
dnl Suitable for AC_REQUIRE([HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR])
dnl aligns with "the other configure" in ../libexec/boilerplate-simplistic-configure-for-untooled-packages
dnl
AC_DEFUN([HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR], [
    AC_REQUIRE([SCOLD_ENABLE_MOCK_BUILD])
    if test no != "${enable_mock_build}"
    then
        HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR_UNCONDITIONAL
    fi
])

dnl
dnl
dnl HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR__UNCONDITIONAL_BODY        (no arguments)
dnl
dnl Perform the function unconditionally
dnl
AC_DEFUN([HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR_UNCONDITIONAL], [
    AC_REQUIRE([SCOLD_COMPONENT_METADIRECTORY_TIERS])
    AC_ARG_ENABLE([rpmbuild-handoff-topdir],
                  [AS_HELP_STRING([--enable-rpmbuild-handoff-topdir], [ERROR use --with-rpmbuild-handoff-topdir=ROOT])],
                  [AC_MSG_ERROR([use --with-rpmbuild-handoff-topdir=$enableval, also check $CONFIG_SITE])])
    AC_ARG_WITH([rpmbuild-handoff-topdir],
                [AS_HELP_STRING([--with-rpmbuild-handoff-topdir=DIRECTORY specifies the handoff directory, in which .../SOURCES are dumped])],
                [ HANDOFF_TOPDIR=$withval ],
                [ HANDOFF_TOPDIR=${HANDOFF_TOPDIR:-default} ])
    if test no = "$HANDOFF_TOPDIR"
    then
        HGTW_WITH_HANDOFF__ERROR([cannot declare --without-rpmbuild-handoff-topdir])
    elif test -z "$HANDOFF_TOPDIR" || test yes = "$HANDOFF_TOPDIR" || test default = "$HANDOFF_TOPDIR"
    then
        # [[FIXTHIS]] the same value is in "the default" value vernacular-doggerel mk/handoff.mk __handoff_def_HANDOFF_TOPDIR
        __default_handoff_topdir="/fedora/%{fedora}/handoff"
        HANDOFF_TOPDIR=${HANDOFF_TOPDIR:-${__default_handoff_topdir}}
    fi
    if test ! -e $HANDOFF_TOPDIR
    then
        HGTW_WITH_HANDOFF__ERROR([the directory ${HANDOFF_TOPDIR?} does not exist])
    elif test ! -d $HANDOFF_TOPDIR
    then
        HGTW_WITH_HANDOFF__ERROR([the name ${HANDOFF_TOPDIR?} exists but is not a directory])
    fi
    __failure=0
    for subdir in SOURCES SPECS SRPMS
    do
        __handoff_subdir="$HANDOFF_TOPDIR/$subdir"
        if test ! -e "$__handoff_subdir"
        then
            __failure=1
            AC_MSG_WARN([the directory ${__handoff_subdir?} is missing])
        elif test ! -d "$__handoff_subdir"
        then
            __failure=1
            AC_MSG_WARN([the name ${__handoff_subdir?} exists but is not a directory])
        fi
    done
    if test 0 != $__failure
    then
        HGTW_WITH_HANDOFF__ERROR([the directory ${HANDOFF_TOPDIR} is incomplete and cannot be used])
    fi
    AC_SUBST([HANDOFF_TOPDIR])
])

dnl
dnl HGTW_WITH_HANDOFF__ERROR(message)
dnl
dnl Emit a hopeful hint towards remediation, and then emit the error.
dnl
AC_DEFUN([HGTW_WITH_HANDOFF__ERROR], [
    AC_MSG_NOTICE([to disable the rpmbuild-handoff system, use --disable-mock-build])
    AC_MSG_ERROR([$1])
])
