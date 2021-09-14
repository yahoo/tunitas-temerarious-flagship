dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_VERNACULAR_DOGGEREL        (no arguments)
dnl [[deprecated]] SCOLD_WITH_VERNACULAR_DOGGEREL        (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere
dnl
AC_DEFUN([SCOLD_WITH_VERNACULAR_DOGGEREL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[WITH]_[VERNACULAR]_DOGGEREL], [HGTW_[WITH]_[VERNACULAR]_DOGGEREL])
    HGTW_WITH_VERNACULAR_DOGGEREL
])
AC_DEFUN([HGTW_WITH_VERNACULAR_DOGGEREL], [
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    HGTW_WITH_AMBIENT_COMPONENT([vernacular-doggerel], [vernacular_doggerel], [SCOLD rpmbuild scaffolding])
    if test unset != "${vernacular_doggerel_prefix:-unset}"; then
        vernacular_doggerel_datadir='$(vernacular_doggerel_datarootdir)'
        if vernacular_doggerel_datarootdir="${vernacular_doggerel_prefix?}"; test -d "${vernacular_doggerel_datarootdir?}/mk" ; then
            #
            # using vernacular-doggerel out of its development location where
            #    datarootdir == "topdir"
            #    libexecdir  == "topdir/libexec"
            #
            vernacular_doggerel_libexecdir="${vernacular_doggerel_prefix?}/libexec"
            vernacular_doggerel_libdir="${vernacular_doggerel_prefix?}/lib"
        elif vernacular_doggerel_datarootdir="${vernacular_doggerel_prefix?}/share/vernacular-doggerel"; test ! -d "${vernacular_doggerel_datarootdir?}/mk" ; then
            #
            # using vernacular-doggerel out of the installation area
            #
            vernacular_doggerel_libexecdir="${vernacular_doggerel_prefix?}/libexec/vernacular-doggerel"
            vernacular_doggerel_libdir="${vernacular_doggerel_prefix?}/lib/vernacular-doggerel"
        else
            AC_MSG_WARN([cannot find the vernacular-doggerel components in ${vernacular_doggerel_prefix:-unset}])
            AC_MSG_NOTICE([perhaps is they are missing or merely nearby?])
            AC_MSG_NOTICE([reverting to without mode, acting as if presented with --without-vernacular-doggerel])
            unset vernacular_doggerel_prefix
            unset vernacular_doggerel_datarootdir
            unset vernacular_doggerel_datadir
            unset vernacular_doggerel_libexecdir
            unset vernacular_doggerel_libdir
        fi
    fi
    HGTW_MSG_VERBOSE([vernacular_doggerel_prefix=${vernacular_doggerel_prefix:-(unset)}])
    HGTW_MSG_VERBOSE([vernacular_doggerel_datarootdir=${vernacular_doggerel_datarootdir:-(unset)}])
    HGTW_MSG_VERBOSE([vernacular_doggerel_datadir=${vernacular_doggerel_datadir:-(unset)}])
    HGTW_MSG_VERBOSE([vernacular_doggerel_libexecdir=${vernacular_doggerel_libexecdir:-(unset)}])
    HGTW_MSG_VERBOSE([vernacular_doggerel_libdir=${vernacular_doggerel_libdir:-(unset)}])
    AC_SUBST([vernacular_doggerel_prefix])
    AC_SUBST([vernacular_doggerel_datarootdir])
    AC_SUBST([vernacular_doggerel_datadir])
    AC_SUBST([vernacular_doggerel_libexecdir])
    AC_SUBST([vernacular_doggerel_libdir])
    dnl [[compatibility]] with hypogeal-twilight <= 0.41
    AC_SUBST([vernacular_doggerel_libexec], [$vernacular_doggerel_libexecdir])
])
