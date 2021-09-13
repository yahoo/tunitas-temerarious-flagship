dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc. 2021
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_WITH_MODULE(name-dashes, name-underscores, description)
dnl TF_WITH_NONSTD(name-dashes, name-underscores, description)
dnl TF_WITH_STD(name-dashes, name-underscores, description)
dnl TF_WITH_SUBSYSTEM(name-dashes, name-underscores, description)
dnl
dnl TF_WITH_STD_TUNITAS             (no arguments)
dnl TF_WITH_STD_SCOLD               (no arguments)
dnl TF_WITH_HYPOGEAL_TWILIGHT       (no arguments)
dnl TF_WITH_TEMERARIOUS_FLAGSHIP    (no arguments)
dnl 
dnl TF_DEFAULT_STD_VALUES           (no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_DEFAULT_STD_VALUES            (no arguments)
dnl
AC_DEFUN([TF_DEFAULT_STD_VALUES], [
    ifdef([HGTW_DEFAULT_STD_VALUES], dnl prefer the modern stylings, avoid the warning messages of the old
          [AC_REQUIRE([HGTW_DEFAULT_STD_VALUES])],
          [AC_REQUIRE([SCOLD_DEFAULT_STD_VALUES])])
    default_std_tunitas_prefix=/opt/tunitas
    : default_std_EXAMPLE_prefix=$default_default_prefix
])

dnl
dnl TF_WITH_MODULE(name-dashes)
dnl TF_WITH_MODULE(name-dashes, name_underscores)
dnl TF_WITH_MODULE(name-dashes, name_underscores, explanation)
dnl
dnl $1 = name_dashes as appears on the command line
dnl      the syntax "module-" is prefixed (added) to $1
dnl $2 = name_underscores as appears in a bash variable
dnl      the prefix 'module_' is prefixed to $2
dnl $3 = explanation, may be empty
dnl
dnl Whereas "modules" is a SCOLD-level concept, the default location is whatever SCOLD_WITH_MODULE says it is.
dnl which respects --with-submodules and --with-external
dnl
AC_DEFUN([TF_WITH_MODULE], [
    TFinternal_WITH_MODULE([$1], dnl no "module-" prefix and see the  WATCHOUT below
                           ifelse([$2], [],
                                  m4_bpatsubst([module_$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                                  [$2]),
                           ifelse([$3], [], [Module $1 Development Area], [$3]))
])
AC_DEFUN([TFinternal_WITH_MODULE], [
    ifdef([HGTW_WITH_MODULE],
          dnl 
          dnl WATCHOUT the newer API does not accept $2 and $3, which are always synthesized from $1
          dnl WATCHOUT the newer API does not accept "module-" prefix on $1
          dnl
          [HGTW_WITH_MODULE([$1])],
          dnl
          dnl WATCHOUT -------\
          dnl                 |
          dnl                 v
          [SCOLD_WITH_MODULE([module-$1], [$2], [$3])])
])
 
dnl
dnl TF_WITH_TEMERARIOUS_FLAGSHIP
dnl
dnl does the definition but also AC_SUBST for ancillary variables
dnl
AC_DEFUN([TF_WITH_TEMERARIOUS_FLAGSHIP], [
    AC_REQUIRE([TF_DEFAULT_STD_VALUES])
    AC_REQUIRE([TF_WITH_STD_TUNITAS])
    AC_REQUIRE([TF_COMPONENT_METADIRECTORY_TIERS])
    TFinternal_WITH_SUBSYSTEM([temerarious-flagship], [temerarious_flagship], [The Tunitas Build System])
    temerarious_flagship_datadir="\$(temerarious_flagship_datarootdir)"
    AC_SUBST([temerarious_flagship_datadir])
    temerarious_flagship_datarootdir=${temerarious_flagship_prefix}/share/temerarious-flagship
    AC_SUBST([temerarious_flagship_datarootdir])
    temerarious_flagship_libexecdir=${temerarious_flagship_prefix}/libexec/temerarious-flagship
    AC_SUBST([temerarious_flagship_libexecdir])
])

dnl
dnl TF_WITH_SUBSYSTEM(name-dashes)
dnl TF_WITH_SUBSYSTEM(name-dashes, name_underscores)
dnl TF_WITH_SUBSYSTEM(name-dashes, name_underscores, explanation)
dnl
AC_DEFUN([TF_WITH_SUBSYSTEM], [
    AC_REQUIRE([TF_DEFAULT_STD_VALUES])
    AC_REQUIRE([TF_WITH_STD_TUNITAS])
    AC_REQUIRE([TF_COMPONENT_METADIRECTORY_TIERS])
    ifelse([$1], [temerarious-flagship], [
        TF_WITH_TEMERARIOUS_FLAGSHIP
    ], [
        TFinternal_WITH_SUBSYSTEM([$1], [$2], [$3])
    ])
])
AC_DEFUN([TFinternal_WITH_SUBSYSTEM], [
    AC_REQUIRE([TF_DEFAULT_STD_VALUES])
    AC_REQUIRE([TF_WITH_STD_TUNITAS])
    AC_REQUIRE([TF_COMPONENT_METADIRECTORY_TIERS])
    ifdef([SCOLD_WITH_AMBIENT_COMPONENT_WITHIN], [
        dnl hypogeal-twilight 0.43 and newer
	SCOLD_WITH_AMBIENT_COMPONENT_WITHIN([$1],
					    ifelse([$2], [],
						   m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
						   [$2]),
					    ifelse([$3], [], [Subsystem $1 Development Area], [$3]),
					    dnl ${std_tunitas_prefix} may be empty|undefined if --without-std-tunitas
					    [${submodules_metadir:+$submodules_metadir/$1} ${external_metadir:+$external_metadir/$1} ${std_tunitas_prefix?} ${prefix?}])
    ], [ifdef([SCOLD_WITH_AMBIENT_COMPONENT], [
        dnl hypogeal-twilight 0.42
	SCOLD_WITH_AMBIENT_COMPONENT([$1],
				     ifelse([$2], [],
				   	    m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
				            [$2]),
                                     ifelse([$3], [], [Subsystem $1 Development Area], [$3]))
    ], [
        AC_MSG_NOTICE([hypogeal-twilight is too old (or unprobably, too new)])
        AC_MSG_ERROR([neither [SCOLD]_[AMBIENT]_[COMPONENT]_[WITHIN] nor [SCOLD]_[AMBIENT]_[COMPONENT] is available])
    ]) ])
])

dnl
dnl TF_WITH_NONSTD(name-dashes)
dnl TF_WITH_NONSTD(name-dashes, name-underscores)
dnl TF_WITH_NONSTD(name-dashes, name-underscores, description)
dnl
dnl $1 = name_dashes as appears on the command line
dnl $2 = name_underscores as appears in a bash variable, may be empty
dnl $3 = explanation, may be empty
dnl
AC_DEFUN([TF_WITH_NONSTD], [
    TFinternal_WITH_NONSTD([$1],
                           ifelse([$2], [],
                                  m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                                  [$2]),
                           ifelse([$3], [], [The Non-Standard $1 Area], [$3]))
]) 
AC_DEFUN([TFinternal_WITH_NONSTD], [
    ifdef([HGTW_WITH_NONSTD], [HGTW_WITH_NONSTD([$1], [$2], [$3])], [SCOLD_WITH_NONSTD([$1], [$2], [$3])])
])

dnl
dnl TF_WITH_STD_TUNITAS      (no arguments)
dnl
dnl The preferred form, as zero-argument so it can be used in AC_REQUIRE
dnl
AC_DEFUN([TF_WITH_STD_TUNITAS], [
    TF_WITH_STD([tunitas], [tunitas], [The Standard Tunitas Area])
])
dnl
dnl TF_WITH_STD_SCOLD      (no arguments)
dnl
dnl The preferred form, as zero-argument so it can be used in AC_REQUIRE
dnl
AC_DEFUN([TF_WITH_STD_SCOLD], [    
    TF_WITH_STD([scold], [scold], [The Standard S.C.O.L.D. Area])
])

dnl
dnl TF_WITH_STD(subsystem)
dnl $1 - subsystem, e.g. scold, tunitas, state-space, hyperledger, hyperledger/fabric, hyperledger/sawtooth, hyperledger/iroha, etc.
dnl
dnl Usage:
dnl
dnl   TF_WITH_STD([scold])
dnl
AC_DEFUN([TF_WITH_STD], [    
    AC_REQUIRE([TF_DEFAULT_STD_VALUES])
    TFinternal_WITH_STD([$1],
                        ifelse([$2], [],
                               m4_bpatsubst([$1], m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}), [_]),
                               [$2]),
                        ifelse([$3], [], [The Standard $1 Area], [$3]))
])
AC_DEFUN([TFinternal_WITH_STD], [
    ifdef([HGTW_WITH_STD],
          [HGTW_WITH_STD([$1], [$2], [$3])],
          [SCOLD_WITH_STD([$1], [$2], [$3])])
])

dnl
dnl TF_WITH_HYPOGEAL_TWILIGHT      (no arguments)
dnl
AC_DEFUN([TF_WITH_HYPOGEAL_TWILIGHT], [ifdef([HGTW_WITH_HYPOGEAL_TWILIGHT], [HGTW_WITH_HYPOGEAL_TWILIGHT], [SCOLD_WITH_HYPOGEAL_TWILIGHT])])

dnl
dnl TF_WITH_TEMERARIOUS_FLAGSHIP         (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere
dnl
AC_DEFUN([TF_WITH_TEMERARIOUS_FLAGSHIP], [
    AC_REQUIRE([TF_COMPONENT_METADIRECTORY_TIERS])
    AC_REQUIRE([TF_WITH_HYPOGEAL_TWILIGHT])
    SCOLD_WITH_AMBIENT_COMPONENT([temerarious-flagship], [temerarious_flagship], [Tunitas autotools build scaffolding],
                                 [${submodules_metadir:+$submodules_metadir/$1} ${external_metadir:+$external_metadir/$1} ${std_tunitas_prefix} ${prefix}])
    if test unset != "${temerarious_flagship_prefix:-unset}"; then
        # You are already using temerarious-flagship, so why did you want to say --without-temerarious-flagship?
        temerarious_flagship_datadir='$(temerarious_flagship_datarootdir)'
        if temerarious_flagship_datarootdir=${temerarious_flagship_prefix?}; test -d "${temerarious_flagship_datarootdir?}/ac" ; then
            #
            # using temerarious-flagship out of its development location where
            #    datarootdir == "topdir"
            #    libexecdir  == "topdir"/libexec
            #
            temerarious_flagship_libexecdir="${temerarious_flagship_prefix?}/libexec"
        elif temerarious_flagship_datarootdir="${temerarious_flagship_prefix?}/share/temerarious-flagship"; test -d "${temerarious_flagship_datarootdir?}/ac" ; then
            #
            # using temerarious-flagship out of the installation area
            #
            temerarious_flagship_libexecdir="${temerarious_flagship_prefix?}/libexec/temerarious-flagship"
        else
            AC_MSG_WARN([cannot find the temerarious-flagship components in ${temerarious_flagship_prefix?}])
            AC_MSG_NOTICE([reverting to without mode, acting as if presented with --without-temerarious-flagship])
            unset temerarious_flagship_prefix
            unset temerarious_flagship_datarootdir
            unset temerarious_flagship_datadir
            unset temerarious_flagship_libexecdir
        fi
    fi
    TF_MSG_VERBOSE([temerarious_flagship_prefix=${temerarious_flagship_prefix:-(unset)}])
    TF_MSG_VERBOSE([temerarious_flagship_datarootdir=${temerarious_flagship_datarootdir:-(unset)}])
    TF_MSG_VERBOSE([temerarious_flagship_datadir=${temerarious_flagship_datadir:-(unset)}])
    TF_MSG_VERBOSE([temerarious_flagship_libexecdir=${temerarious_flagship_libexecdir:-(unset)}])
    AC_SUBST([temerarious_flagship_datarootdir])
    AC_SUBST([temerarious_flagship_datadir])
    AC_SUBST([temerarious_flagship_libexecdir])
    AC_SUBST(scold_temerarious_flagship_prefix, $temerarious_flagship_prefix)
])
AC_DEFUN([TFinternal_WITH_AMBIENT_COMPONENT], [
    ifdef([HGTW_WITH_AMBIENT_COMPONENT],
          [HGTW_WITH_AMBIENT_COMPONENT([$1], [$2], [$3], [$4])], 
          [SCOLD_WITH_AMBIENT_COMPONENT([$1], [$2], [$3], [$4])])
])

dnl
dnl TF_WITH_USR_LOCAL         (no arguments)
dnl
dnl Usage in configure.ac
dnl   TF_WITH_USR_LOCAL
dnl
dnl Usage in Makefile.am
dnl   Makefile_nonstd_PACKAGE_CPPFLAGS_SET = @usr_local_CPPFLAGS_SET@
dnl   Makefile_nonstd_PACKAGE_CFLAGS_SET   = @usr_local_CFLAGS_SET@
dnl   Makefile_nonstd_PACKAGE_CXXFLAGS_SET = @usr_local_CXXFLAGS_SET@
dnl   Makefile_nonstd_PACKAGE_LDFLAGS_SET  = @usr_local_LDFLAGS_SET@
dnl
AC_DEFUN([TF_WITH_USR_LOCAL], [
    ifdef([HGTW_WITH_USR_LOCAL], [
        # Arrives in hypogeal-twilight 0.46 or maybe 0.45
        HGTW_WITH_USR_LOCAL
    ], [
        # hack just what we need...
        AC_SUBST([usr_local_CPPFLAGS], [-I/usr/local/include])
        AC_SUBST([usr_local_CFLAGS], [])
        AC_SUBST([usr_local_CXXFLAGS], [])
        AC_SUBST([usr_local_LDFLAGS], [-Wl,-rpath=/usr/local/lib64])
    ])
])
