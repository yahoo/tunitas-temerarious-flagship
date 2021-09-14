dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_HYPOGEAL_TWILIGHT                        (no arguments)
dnl [[deprecated]] SCOLD_WITH_HYPOGEAL_TWILIGHT        (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere
dnl
AC_DEFUN([SCOLD_WITH_HYPOGEAL_TWILIGHT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[WITH]_[HYPOGEAL]_TWILIGHT], [HGTW_[WITH]_[HYPOGEAL]_TWILIGHT])
    HGTW_WITH_HYPOGEAL_TWILIGHT
])
AC_DEFUN([HGTW_WITH_HYPOGEAL_TWILIGHT], [
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_DEBUG])
    if test -z "$buildconfed_is_loaded" ; then
        # don't load mk/buildconfed.mk more than once because it will overwrite the choices we are making herein
        __buildconfed=./mk/buildconfed.mk
        if test -f ${__buildconfed?} ; then
            if ! . ${__buildconfed?} ; then
                AC_MSG_ERROR([could not load the definitions in ${__buildconfed?}])
            fi
            buildconfed_is_loaded=1
            if test yes = ${enable_configure_debug:-no} ; then
               sed -e "s,^,DEBUG ---> ${__buildconfed?}," ${__buildconfed?} < /dev/null
            fi
        fi
    fi
    HGTW_WITH_AMBIENT_COMPONENT([hypogeal-twilight], [hypogeal_twilight], [SCOLD autotools build scaffolding])
    if test unset != "${hypogeal_twilight_prefix:-unset}"; then
        # lotta trouble with this business logic
        HGTW_MSG_DEBUG([hypogeal-twilight is set, evaluating what sort of tree this is])
        HGTW_MSG_DEBUG([hypogeal_twilight_prefix=${hypogeal_twilight_prefix:-(unset)}])
        # (not unset) - you are already using hypogeal-twilight, so why did you want to say --without-hypogeal-twilight?
        if ! test -d "${hypogeal_twilight_prefix?}" ; then
            AC_MSG_NOTICE([hypogeal-twilight was explicitly set as ${hypogeal_twilight_prefix}])
            AC_MSG_ERROR([the directory ${hypogeal_twilight_prefix} does not exist])
        fi
        hypogeal_twilight_datadir='$(hypogeal_twilight_datarootdir)'
        if : the development area shaped until v0.42 ;
           test -e "${hypogeal_twilight_prefix?}/Makefile" &&
           test -d "${hypogeal_twilight_prefix?}/am" &&
           test -d "${hypogeal_twilight_prefix?}/ac" &&
           test -d "${hypogeal_twilight_prefix?}/rpm" &&
         ! test -d "${hypogeal_twilight_prefix?}/libexec" ; then
            HGTW_MSG_DEBUG([found .../am, .../ac, .../rpm but not .../libexec])
            HGTW_MSG_DEBUG([based on information & belief: a development area shaped until v0.42])
            # [[production]]
            # Huh?  0ld ... v0.42 & prior had a "rpm" subdirectory
            #                    DID NOT have a "libexec" directory
            #
            # using hypogeal-twilight out of its development location where
            #    datarootdir == "topdir"
            #    libexecdir  == "topdir"/rpm or "topdir"/ac
            #                    WATCHOUT - the notion of libexecdir for the development area is ill-posed (it is two places)
            #                    [[deprecating]] topdir/rpm with "extract" being in vernacular-doggerel-0.12 
            #
            hypogeal_twilight_datarootdir="${hypogeal_twilight_prefix?}"
            # this is broken & wrong in the development area
            hypogeal_twilight_libexecdir="${hypogeal_twilight_prefix?}/rpm" # which is arguably wrong (as is the other choice)
            # these are different in the development area
            hypogeal_twilight_libexecdir_ac="${hypogeal_twilight_prefix?}/ac"
            hypogeal_twilight_libexecdir_rpm="${hypogeal_twilight_prefix?}/rpm"
        elif : the development area shaped after v0.42 ;
             test -e "${hypogeal_twilight_prefix?}/Makefile" &&
             test -d "${hypogeal_twilight_prefix?}/am" &&
             test -d "${hypogeal_twilight_prefix?}/ac" &&
           ! test -d "${hypogeal_twilight_prefix?}/rpm" &&
             test -d "${hypogeal_twilight_prefix?}/libexec" ; then
            HGTW_MSG_DEBUG([found .../am, .../ac, .../libexec but NOT .../rpm])
            HGTW_MSG_DEBUG([based on information & belief: a development area shaped after v0.42])
            # [[production]]
            # [[current]]
            # the hypogeal-twilight development area of v0.43+
            #
            # using hypogeal-twilight out of its development location where
            #    datarootdir == "topdir"
            #    libexecdir  == "topdir"/libexec"
            #
            hypogeal_twilight_datarootdir="${hypogeal_twilight_prefix?}"
            hypogeal_twilight_libexecdir="${hypogeal_twilight_prefix?}/libexec"
            # legacy compatibility ... because the "_ac" and "_rpm" suffixed variables exist "out there"
            hypogeal_twilight_libexecdir_ac="${hypogeal_twilight_prefix?}/libexec"
            hypogeal_twilight_libexecdir_rpm="${hypogeal_twilight_prefix?}/libexec"
        elif : the development area shaped has old and new junk in it; 
             test -d "${hypogeal_twilight_prefix?}/am" && 
             test -d "${hypogeal_twilight_prefix?}/ac" &&
             { { test -d "${hypogeal_twilight_prefix?}/rpm" &&
                 test -d "${hypogeal_twilight_prefix?}/libexec" ; } ||
               { ! test -d "${hypogeal_twilight_prefix?}/rpm" &&
                 ! test -d "${hypogeal_twilight_prefix?}/libexec" ; } ; } then
            AC_MSG_NOTICE([the directory ${hypogeal_twilight_prefix?} is incomprehensible])
            AC_MSG_ERROR([the directory ${hypogeal_twilight_prefix?} must be cleaned up])
        elif : the production area in any era ;
             hypogeal_twilight_datarootdir="${hypogeal_twilight_prefix?}/share/hypogeal-twilight";
           ! test -e "${hypogeal_twilight_prefix?}/Makefile" &&
             test -d "${hypogeal_twilight_datarootdir?}/am" ; then
            HGTW_MSG_DEBUG([found .../am, and using default reasoning])
            HGTW_MSG_DEBUG([based on information & belief: a production area in any era])
            # [[production]]
            # [[current]]
            # using hypogeal-twilight out of the installation area
            #
            hypogeal_twilight_libexecdir="${hypogeal_twilight_prefix?}/libexec/hypogeal-twilight"
            # these are the same once installed
            hypogeal_twilight_libexecdir_ac="${hypogeal_twilight_libexecdir?}"
            hypogeal_twilight_libexecdir_rpm="${hypogeal_twilight_libexecdir?}"
        else
            AC_MSG_NOTICE([hypogeal-twilight is declared to be at ${hypogeal_twilight_prefix?}])
            AC_MSG_WARN([cannot find the hypogeal-twilight components .../am, .../ac, .../libexec therein])
            AC_MSG_NOTICE([reverting to without mode, acting as if presented with --without-hypogeal-twilight])
            unset hypogeal_twilight_prefix
            unset hypogeal_twilight_datarootdir
            unset hypogeal_twilight_datadir
            unset hypogeal_twilight_libexecdir
            unset hypogeal_twilight_libexecdir_ac
            unset hypogeal_twilight_libexecdir_rpm
        fi
    fi
    HGTW_MSG_VERBOSE([hypogeal_twilight_prefix=${hypogeal_twilight_prefix:-(unset)}])
    HGTW_MSG_VERBOSE([hypogeal_twilight_libdir=${hypogeal_twilight_libdir:-(unset)}])
    HGTW_MSG_VERBOSE([hypogeal_twilight_datarootdir=${hypogeal_twilight_datarootdir:-(unset)}])
    HGTW_MSG_VERBOSE([hypogeal_twilight_datadir=${hypogeal_twilight_datadir:-(unset)}])
    HGTW_MSG_VERBOSE([hypogeal_twilight_libexecdir=${hypogeal_twilight_libexecdir:-(unset)}])
    AC_SUBST([hypogeal_twilight_prefix])
    AC_SUBST([hypogeal_twilight_datarootdir])
    AC_SUBST([hypogeal_twilight_datadir])
    AC_SUBST([hypogeal_twilight_libexecdir])
    dnl [[compatibility]] with hypogeal-twilight <= 0.41
    AC_SUBST([hypogeal_twilight_libexecdir_ac])
    AC_SUBST([hypogeal_twilight_libexecdir_rpm])
    dnl [[compatibility]] with hypogeal-twilight <= 0.41
    AC_SUBST([hypogeal_twilight_libexec], [$hypogeal_twilight_libexecdir])
    AC_SUBST([hypogeal_twilight_libexec_ac], [$hypogeal_twilight_libexecdir_ac])
    AC_SUBST([hypogeal_twilight_libexec_rpm], [$hypogeal_twilight_libexecdir_rpm])
    #
    # [[deprecated]] circa hypogeal-twilight-0.30?
    # ancient compatibility (set up the old variable names as well)
    #
    AC_SUBST([scold_hypogeal_twilight_prefix], [$hypogeal_twilight_prefix])
])
