dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_INCENDIARY_SOPHIST                        (no arguments)
dnl [[deprecated]] SCOLD_WITH_INCENDIARY_SOPHIST        (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere
dnl
AC_DEFUN([SCOLD_WITH_INCENDIARY_SOPHIST], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[WITH]_[INCENDIARY]_SOPHIST], [HGTW_[WITH]_[INCENDIARY]_SOPHIST])
    HGTW_WITH_INCENDIARY_SOPHIST
])
AC_DEFUN([HGTW_WITH_INCENDIARY_SOPHIST], [
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    HGTW_WITH_AMBIENT_COMPONENT([incendiary-sophist], [incendiary_sophist], [SCOLD autotools test scaffolding])
    if test unset != "${incendiary_sophist_prefix:-unset}"; then
        incendiary_sophist_datadir='$(incendiary_sophist_datarootdir)'
        # assume that if test-suite-summarizer is there then test-case-driver is also therein
        if incendiary_sophist_libexecdir=${incendiary_sophist_prefix?}; test -x "${incendiary_sophist_libexecdir?}/test-suite-summarizer" ; then
            #
            # using incendiary-sophist out of its development location where
            #    datarootdir == "topdir"
            #    libexecdir  == "topdir"
            #
            incendiary_sophist_datarootdir="${incendiary_sophist_prefix?}"
            incendiary_sophist_libdir="${incendiary_sophist_prefix?}/lib"
        elif incendiary_sophist_libexecdir="${incendiary_sophist_prefix?}/libexec/incendiary-sophist"; test -x "${incendiary_sophist_libexecdir?}/test-suite-summarizer" ; then
            # using incendiary-sophist out of the installation area
            incendiary_sophist_datarootdir="${incendiary_sophist_prefix?}/share/incendiary-sophist"
            incendiary_sophist_libdir="${incendiary_sophist_prefix?}/lib/incendiary-sophist"
        else
            AC_MSG_WARN([cannot find the incendiary-sophist executables in ${incendiary_sophist_prefix:-(unset)}])
            AC_MSG_NOTICE([perhaps they are missing or merely non-executable?])
            AC_MSG_NOTICE([reverting to without mode, acting as if presented with --without-incendiary-sophist])
            unset incendiary_sophist_prefix
            unset incendiary_sophist_datadir
            unset incendiary_sophist_datarootdir
            unset incendiary_sophist_libexecdir
            unset incendiary_sophist_libdir
        fi
    fi
    HGTW_MSG_VERBOSE([incendiary_sophist_prefix=${incendiary_sophist_prefix:-(unset)}])
    HGTW_MSG_VERBOSE([incendiary_sophist_datadir=${incendiary_sophist_datadir:-(unset)}])
    HGTW_MSG_VERBOSE([incendiary_sophist_datarootdir=${incendiary_sophist_datarootdir:-(unset)}])
    HGTW_MSG_VERBOSE([incendiary_sophist_libexecdir=${incendiary_sophist_libexecdir:-(unset)}])
    HGTW_MSG_VERBOSE([incendiary_sophist_libdir=${incendiary_sophist_libdir:-(unset)}])
    AC_SUBST([incendiary_sophist_prefix])
    AC_SUBST([incendiary_sophist_datadir])
    AC_SUBST([incendiary_sophist_datarootdir])
    AC_SUBST([incendiary_sophist_libexecdir])
    AC_SUBST([incendiary_sophist_libdir])
    dnl compatibility with hypogeal-twilight <= 0.41
    AC_SUBST([incendiary_sophist_libexec], [$incendiary_sophist_libexecdir])
])
