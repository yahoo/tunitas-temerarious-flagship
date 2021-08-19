dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_MOCK_BUILD                   (no arguments)
dnl [[deprecated]] SCOLD_ENABLE_MOCK_BUILD   (no arguments)
dnl [[deprecated]] SCOLD_MOCK_BUILD
dnl
dnl Internal:
dnl   HGTW_FINALIZE_CONFIGURED               (no arguments, only callable from HGTW_FINALIZE)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Usage Scenario in ./Makefile.am
dnl
dnl     if ENABLE_MOCK_BUILD
dnl     # avoid .../hypogeal-twilight/am/archive.mk:75: *** missing specfile $filename.spec.  Stop.
dnl     #
dnl     # Whereas configured.mk was created by configure.ac via SCOLD_MOCK_BUILD
dnl     #           it defines RPM_SPEC_FILE and MOCK_-prefixed variables used by archive.mk
dnl     #           managed with ./configure --enable-specfile=$filename.spec
dnl     # Whereas automake processes includes immediately, but not if @DOT@ occludes it
dnl     include @DOT@/mk/configured.mk
dnl     # Whereas configured.mk establishes RPM_SPEC_FILE, if it exists
dnl     mk/configured.mk: $(RPM_SPEC_FILE) Makefile.am configure.ac
dnl     	./config.status
dnl     include @hypogeal_twilight_datarootdir@/am/archive.mk
dnl     endif
dnl
dnl Reminder: if mock build is disabled then
dnl
dnl     - @DOT@ is undefined
dnl     - mk/configured.mk is not created
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl fully deprecated, there never will be an HGTW incarnation of this
AC_DEFUN([SCOLD_MOCK_BUILD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[MOCK]_BUILD],
                        [HGTW_[ENABLE]_[MOCK]_BUILD])
    HGTW_ENABLE_MOCK_BUILD
])
dnl this never was ... but occurs when blind s/SCOLD_/HGTW_/ occurs on older configure.ac
AC_DEFUN([HGTW_MOCK_BUILD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[MOCK]_BUILD],
                        [HGTW_[ENABLE]_[MOCK]_BUILD])
    HGTW_ENABLE_MOCK_BUILD
])

dnl
dnl HGTW_ENABLE_MOCK_BUILD          (no arguments)
dnl
dnl     adds --enable-mock-build={yes,no}
dnl     adds --enable-specfile=FILE
dnl     adds hooks to do the rpmbuild via 'make package' 'make check-package'
dnl           via .../vernacular-doggerel/mk/build.mk
dnl     creates ./mk/configured.mk with the variable settings
dnl     <obsolete>
dnl         adds hooks to do the rpmbuild via .../hypogeal-twilight/am/archive.mk
dnl     </obsolete>
dnl
dnl expects (checked)
dnl   ${vernacular_doggerel_prefix} to be defined, else --disable-mock-build
dnl
dnl defines ./mk/configure..mk
dnl which is optionally GNUmake-included from within $(vernacular_doggerel_datadir)/mk/build.mk
dnl and MUST NOT be automake-included from within Makefile.am or a .../Makefrag.am
dnl
dnl See .../vernacular-doggerel/mk/build.mk
dnl Perform a package src build with rpmbuild && mock
dnl
AC_DEFUN([SCOLD_ENABLE_MOCK_BUILD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[MOCK]_BUILD],
                        [HGTW_[ENABLE]_[MOCK]_BUILD])
    HGTW_ENABLE_MOCK_BUILD
])
AC_DEFUN([HGTW_ENABLE_MOCK_BUILD], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_WITH_VERNACULAR_DOGGEREL])
    dnl DO NOT ... AC_REQUIRE([HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR])
    dnl
    dnl Part 1 (support --enable-mock-build)
    dnl
    if test -z "${vernacular_doggerel_prefix}" ; then
        dnl
        dnl --without-vernacular-doggerel implies --disable-mock-build
        dnl
        AC_MSG_NOTICE([the use of --without-vernacular-doggerel implies --disable-mock-build])
        enable_mock_build=no dnl WATCOHUT - if unset then HGTW_WITH_RPMBULD_HANDOFF_TOPDIR will error out with an inconsistent command line
        build_value=0
        build_word="disabled"
        build_how="defaulted"
        build_because="--without-vernacular-doggerel is in force"
    else
        dnl
        dnl Part 1 (support --enable-mock-build when --vernacular-doggerel is available)
        dnl
        AC_ARG_ENABLE([mock-build],
                      [AS_HELP_STRING([--enable-mock-build], [enable the rpm package building using the locally-configured mock])],
        [
            build_how="set"
            build_because="it was explicitly set that way"
            case "${enableval}" in
            (yes) build_value=1; build_word="enabled" ;;
            (no)  build_value=0; build_word="disabled" ;;
            (*) AC_MSG_ERROR([bad value ${enableval} for --enable-mock-build]) ;;
            esac
        ], [
            build_how="defaulted"
            build_because="that is the policy choice in .../enable-mock-build.m4"
            build_value=0
            build_word=disabled
            enable_mock_build=no
        ])
    fi
    AC_MSG_NOTICE([mock-build ${build_how?} to ${build_word?} because ${build_because?}.])
    AM_CONDITIONAL([ENABLE_MOCK_BUILD], [test x${build_value?} = x1])
    HGTW_MSG_VERBOSE([enable_mock_build=${enable_mock_build:-(unset)}])
    HGTWinternal_DECLARE_FILE_VARIABLES
    AM_COND_IF([ENABLE_MOCK_BUILD],
               [HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_ENABLED],
               [HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DISABLED])
    if test no != "${enable_mock_build}"
    then
        # For compatibility with older code, entail this with HGTW_ENABLE_MOCK_BUILD
        HGTW_WITH_RPMBUILD_HANDOFF_TOPDIR_UNCONDITIONAL
    fi
])

dnl HGTWinternal_DECLARE_FILE_VARIABLES
dnl
dnl Idempotent.
dnl
dnl Postcondition
dnl
dnl   CONFIGFILE is defined, likely as ./mk/configured.mk
dnl   EXTRACTFILE is defined, likely as ./extracted.mk
dnl
AC_DEFUN([HGTWinternal_DECLARE_FILE_VARIABLES], [
    if test -z "$CONFIGFILE"
    then
        CONFIGFILE=mk/configured.mk
        tCONFIGFILE="${CONFIGFILE%/*}/t99.${CONFIGFILE##*/}.$$.mk~"
    fi
    if test -z "$EXTRACTFILE"
    then
        EXTRACTFILE=mk/extracted.mk
        tEXTRACTFILE="${EXTRACTFILE%/*}/t99.${EXTRACTFILE##*/}.$$.mk~"
    fi
])

dnl
dnl HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_ENABLED   (no arguments)
dnl
dnl When: --enable-mock-build
dnl
dnl Preconditions:
dnl
dnl   CONFIGFILE is defined, likely as ./mk/configured.mk
dnl   EXTRACTFILE is defined, likely as ./extracted.mk
dnl
dnl Postconditions:
dnl
dnl   mk/configured.mk is created
dnl   mk/extracted.mk is created
dnl
AC_DEFUN([HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_ENABLED], [
    AC_REQUIRE([HGTW_WITH_VERNACULAR_DOGGEREL])
    dnl
    dnl Part 2 (support --enable-specfile=FILE)
    dnl
    if test yes != "${enable_mock_build:-FAIL}" ; then
        dnl Should never be reached because this is [SCOLD]_[ENABLE]_[MOCK_BUILD]__[ACTIONS]_[WHEN]_[ENABLED]
        AC_MSG_NOTICE([--enable-mock-build=${enable_mock_build:-(empty)}])
        AC_MSG_ERROR([unreachable])
    fi
    if test -z "${vernacular_doggerel_prefix}" ; then
        AC_MSG_NOTICE([need --with-vernacular-doggerel to define vernacular_doggerel_prefix for --enable-mock-build])
        AC_MSG_ERROR([the option --enable-mock-build requires --with-vernacular-doggerel])
    fi
    # 
    # Reminder: the guess_rpm_basename guessing
    #
    #    in an rpmbuild, the containing directory is versioned,  e.g. "project-name-here-X.Y.Z"
    #    here in development the containing directory is simple, e.g. "project-name-here"
    #
    # Contra: always name the specfile in rpmbuilds
    #
    #   within a specfile, explicitly enable the specfile as --enable-specfile=%{specfile)
    #   because otherwise the advised specfile will be the one named after the build directory
    #   and that is arbitrary and ugly.
    #
    declare guess_rpm_basename=$(basename $(pwd))
m4_changequote(<,>)
__version_pattern="\(.*\)-[0-9][0-9a-zA-Z]*-[0-9][0-9a-zA-Z]*-[0-9][0-9a-zA-Z]*$"
m4_changequote([,])
    guess_rpm_basename=$(expr "${guess_rpm_basename?}" : "${__version_pattern?}" '|' "${guess_rpm_basename?}")
    declare default_rpm_spec_file
    if default_rpm_spec_file="${guess_rpm_basename?}.spec"; test -e ${default_rpm_spec_file?} ; then
        : keep
    elif default_rpm_spec_file=release/package.spec; test -e ${default_rpm_spec_file?} ; then
        : keep
    else
        default_rpm_spec_file=guess
    fi
    AC_ARG_WITH([specfile],
                [AS_HELP_STRING([--with-specfile], [ERROR use --enable-specfile=FILE])],
                [AC_MSG_ERROR([use --enable-specfile=FILE, e.g. --enable-specfile=${default_rpm_spec_file?}])])
    AC_ARG_ENABLE([specfile],
                  [AS_HELP_STRING([--disable-specfile], [With the RPM spec file defaulting to ${default_rpm_spec_file?}])],
                  [
                      # enable_specfile is 'yes', 'no', a FILE, also 'yes' means 'guess'
                      if test -z "$enable_specfile" ; then
                         AC_MSG_ERROR([empty FILE in --enable-specfile=${enableval:-(empty)}])
                      fi
                  ], [
                      # act as yes
                      enable_specfile=${default_rpm_spec_file?}
                      HGTW_MSG_VERBOSE([omitted --enable-specfile behaves as --enable-specfile=${enable_specfile?}])
                  ])
    #
    # Combinatorix
    # whereas --enable-mock-build
    #
    #     --enable-specfile=FILE     -> use FILE
    #     --disable-specfile         -> unset the specfile (same as --disable-mock-build)
    #     [unstated]                 -> guess the specfile from pwd
    #
    declare rpm_spec_file
    case ${enable_specfile?} in
    ( no )
        unset rpm_spec_file
        ;;
    ( yes | guess )
        rpm_spec_file=guess
        ;;
    ( * )
        rpm_spec_file=${enable_specfile?}
        ;;
    esac
    if test guess == "${rpm_spec_file:-unset}" ; then
        rpm_spec_file=$(sed -n -e "s/^PACKAGE_SPEC_FILE *= *\(.*\)/\1/p" Makefile.am)
        HGTW_MSG_VERBOSE([the --enable-specfile=${enable_specfile?} identifies ${rpm_spec_file:-(unset)}])
        HGTW_MSG_VERBOSE([acting as if --enable-specfile=${rpm_spec_file}])
    fi
    if test unset == "${rpm_spec_file:-unset}" ; then
        AC_MSG_NOTICE([the option -enable-mock-build=${enable_mock_build:-(unset)}, yet --enable-specfile=${enable_specfile:-(unset)}])
        AC_MSG_NOTICE([mock building is effectively disabled])
        HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DISABLED
    else
        HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED
    fi
])

AC_DEFUN([HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED], [
    HGTW_MSG_VERBOSE([debug: enable_mock_build is ${enable_mock_build:-unset}])
    HGTW_MSG_VERBOSE([debug: specfile is ${rpm_spec_file:-unset}])
    if test unset = "${rpm_spec_file:-unset}" ; then
        AC_MSG_NOTICE([--enable-mock-build=${enable_mock_build:-(unset)}])
        AC_MSG_NOTICE([--enable-specfile=${enable_specfile:-(unset)}])
        AC_MSG_ERROR([unreachable])
    fi
    if test ! -f "${rpm_spec_file?}" ; then
        AC_MSG_NOTICE([the option --enable-specfile defaults to guess the file ${enable_specfile?}])
        AC_MSG_NOTICE([the file ${rpm_spec_file?} does not exist])
        AC_MSG_NOTICE([the option --enable-specfile=FILE must name an existing file])
        AC_MSG_NOTICE([perhaps you intended to use --disable-mock-build AND ALSO --disable-specfile])
        AC_MSG_ERROR([the file ${rpm_spec_file?} is missing])
    fi
    HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED_PART3
    HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED_PART4
    dnl
    dnl Trick: against automake
    dnl
    dnl The containing Makefile.am shall dodge the automake cut-N-paste include model
    dnl by one level of indirection through the artifice of an @DOT@ variable reference.
    dnl
    dnl If the include file path name is manifest then automake tries to include it.
    dnl If the include file path mame is latent, then automake allows GNU make to process it.
    dnl
    dnl in Makefile.am
    dnl
    dnl   include @DOT@/mk/configured.mk
    dnl
    AC_SUBST([DOT], [.])
])

AC_DEFUN([HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED_PART3], [
    dnl
    dnl Part 3 (find the executable $extract as .../extract-rpm-specfile-value)
    dnl
    basename_extract=extract-rpm-specfile-value
    AC_MSG_CHECKING([$basename_extract])
    # First check (current) vernacular-doggerel, then check (deprecating) hypogeal-twilight
    # Concept: in development, maybe it is in a .../rpm subdirectory, maybe it is at the top level
    if __exe="${vernacular_doggerel_prefix}/libexec/${basename_extract}"; test -x "$__exe" ; then
        # the development location (uses libexec, even in development)
        extract=$__exe
        AC_MSG_RESULT([found (via vernacular-doggerel)])
    elif __exe="${vernacular_doggerel_prefix}/rpm/${basename_extract}"; test -x "$__exe" ; then
        # the development location (unexpected, used .../rpm in development as a .../libexec-type area)
        # no memorable variant of development ever really did this; ../rpm was a hypogeal-twilight scheme.
        extract=$__exe
        AC_MSG_RESULT([found (via vernacular-doggerel)])
    elif __exe="${vernacular_doggerel_prefix}/${basename_extract}"; test -x "$__exe" ; then
        # the development location (even older, put the the extract script right at the top level)
        # no memorable variant of development ever really did this; ../rpm was a hypogeal-twilight scheme.
        extract=$__exe
        AC_MSG_RESULT([found (via vernacular-doggerel)])
    elif __exe="${vernacular_doggerel_prefix}/libexec/vernacular-doggerel/${basename_extract}"; test -x "$__exe" ; then
        # the installed location
        extract=$__exe
        AC_MSG_RESULT([found (via vernacular-doggerel)])
    else
        #
        # Look for an extract script in the hypogeal-twilight area
        # This is a last gasp now.  If vernacular-doggerel didn't have it then hypogeal-twilight's will be old.
        #
        AC_REQUIRE([HGTW_WITH_HYPOGEAL_TWILIGHT])
        if test -z "${hypogeal_twilight_prefix}" ; then
            AC_MSG_ERROR([need --with-hypogeal-twilight to define hypogeal_twilight_prefix for --enable-mock-build])
        fi
        if __exe="${hypogeal_twilight_prefix}/rpm/${basename_extract}"; test -x "$__exe" ; then
            # the development location
            extract=$__exe
            AC_MSG_RESULT([found (via hypogeal-twilight)])
        elif __exe="${hypogeal_twilight_prefix}/libexec/hypogeal-twilight/${basename_extract}"; test -x "$__exe" ; then
            # the installed location
            extract=$__exe
            AC_MSG_RESULT([found (via hypogeal-twilight)])
        else
            AC_MSG_RESULT([FAIL])
            AC_MSG_ERROR([cannot find ${basename_extract} within ${vernacular_doggerel_prefix?} or ${hypogeal_twilight_prefix?}])
        fi
    fi
    HGTW_MSG_VERBOSE([found $extract])
    dnl Is this thing even on?
    if test ! -x "${extract}" || ! "${extract}" --usage > /dev/null 2>&1 ; then
        AC_MSG_ERROR([the specfile extractor fails to execute - ${extract}])
    fi
])

AC_DEFUN([HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DOUBLE_ENABLED_PART4], [
    dnl
    dnl Part 4 (create ./mk/configured.mk)
    dnl
    # default-default values
    # WATCHOUT - /usr/bin/hostname may not be installed (!!!); e.g. in a mock environment
    declare advice_mock_cfg_name=$({ hostname -s || uname -n || echo default ; } 2>/dev/null | sed 1q)
    declare advice_mock_rpmbuild_root=/build/mock
    declare advice_mock_git_branch=master
    # default values
    declare default_mock_cfg_name=${advice_mock_cfg_name:-unchosen}
    declare default_mock_rpmbuild_root=$(rpm --eval "%_topdir")
    # reminder, this may be executed in a location which is not a git repo, so git branch will fail (loudly)
    declare default_mock_git_branch=$(set -o pipefail ; git branch -l 2>/dev/null | sed -ne "/^\* / {; s/^..//p; }" || echo none)
    dnl
    dnl requires $extract to be valid
    dnl
    {
       # be paranoid ... lack of consistency has never ceased to cause incomprehensible problems.
        if ! {
               test -n "${rpm_spec_file}" &&
               test -n "${extract}" &&
               test -x "${extract}" &&
               true
        }; then
           AC_MSG_ERROR([variable invariant fails ... this was supposed to have been checked and messaged elegantly above])
        fi
        # do the work twice to make sure the error messaging comes through on failure
        if ! {
            ${extract} Name ${rpm_spec_file} &&
            ${extract} Version ${rpm_spec_file} &&
            ${extract} Release ${rpm_spec_file} &&
            true
        } >/dev/null; then
           AC_MSG_ERROR([extract $extract fails ... this was supposed to "just work"])
        fi
    }
    module_name=$(${extract} Name ${rpm_spec_file}) || exit 1
    module_version=$(${extract} Version ${rpm_spec_file}) || exit 1
    module_release=$(${extract} Release ${rpm_spec_file}) || exit 1
    mock_cfg_name=$default_mock_cfg_name
    mock_rpmbuild_root=$default_mock_rpmbuild_root
    mock_git_branch=$default_mock_git_branch
    HGTW_MSG_VERBOSE([configuring ${CONFIGFILE?} as enabled])
    # matches .../boilerplate-simplistic-configure-for-untooled-packages
    mkdir -p ${tCONFIGFILE%/*} && tee ${tCONFIGFILE?} <<__EOF__ | sed -e "s,^,${CONFIGFILE##*/}-> ," && mv -f "${tCONFIGFILE?}" "${CONFIGFILE?}"
# prefix, includedir, modulesdir, libdir, _lib are all expected to have been set in the containing Makefile
hypogeal_twilight_prefix = ${hypogeal_twilight_prefix}
hypogeal_twilight_libdir = ${hypogeal_twilight_libdir}
hypogeal_twilight_libexecdir = ${hypogeal_twilight_libexecdir}
hypogeal_twilight_datarootdir = ${hypogeal_twilight_datarootdir}
hypogeal_twilight_datadir = ${hypogeal_twilight_datadir} 
vernacular_doggerel_prefix = ${vernacular_doggerel_prefix}
vernacular_doggerel_libdir = ${vernacular_doggerel_libdir}
vernacular_doggerel_libexecdir = ${vernacular_doggerel_libexecdir}
vernacular_doggerel_datarootdir = ${vernacular_doggerel_datarootdir}
vernacular_doggerel_datadir = ${vernacular_doggerel_datadir}
# now found in ${EXTRACTFILE}
# (deprecated) RPM_SPEC_FILE = ${rpm_spec_file}
# MODULE_NAME = ${module_name}
# MODULE_VERSION = ${module_version}
# MODULE_RELEASE = ${module_release}
# (deprecated) MOCK_CFG_NAME = ${mock_cfg_name}
# (deprecated) RPMBUILD_ROOT = ${mock_rpmbuild_root}
# (deprecated) MOCK_GIT_BRANCH = ${mock_git_branch}
__EOF__
    HGTW_MSG_VERBOSE([configuring ${EXTRACTFILE?} as enabled])
    mkdir -p ${tEXTRACTFILE%/*} && tee ${tEXTRACTFILE?} <<__EOF__ | sed -e "s,^,${EXTRACTFILE##*/}-> ," && mv -f "${tEXTRACTFILE?}" "${EXTRACTFILE?}"
# (deprecated) RPM_SPEC_FILE = ${rpm_spec_file}
MODULE_NAME = ${module_name}
MODULE_VERSION = ${module_version}
MODULE_RELEASE = ${module_release}
# (deprecated) MOCK_CFG_NAME = ${mock_cfg_name}
# (deprecated) RPMBUILD_ROOT = ${mock_rpmbuild_root}
# (deprecated) MOCK_GIT_BRANCH = ${mock_git_branch}
__EOF__
])

dnl HGTW_FINALIZE_CONFIGURED (no arguments)
dnl
dnl Preconditions:
dnl
dnl   Called only from HGTW_FINALIZE to handle the last-chance.
dnl   We know that HGTW_ENABLE_MOCK_BUILD was never called and never will be.
dnl
dnl Postcondition:
dnl
dnl   ./mk/configured.mk is established.
dnl   ./mk/extracted.mk is established.
dnl   Makefile-space variables are defined for the directories of
dnl     hypogeal_twilight
dnl     vernacular_doggerel
dnl
AC_DEFUN([HGTW_FINALIZE_CONFIGURED], [
    if test -z "$enable_mock_build"
    then
        HGTWinternal_DECLARE_FILE_VARIABLES
        HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DISABLED
    fi 
])

dnl
dnl HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_ENABLED   (no arguments)
dnl
dnl When: --disable-mock-build
dnl
dnl Preconditions:
dnl
dnl   CONFIGFILE is defined, likely as ./mk/configured.mk
dnl   EXTRACTFILE is defined, likely as ./extracted.mk
dnl
dnl Postconditions:
dnl
dnl   mk/configured.mk is created with definitions for hypogeal-twilight and vernacular_doggerel
dnl   mk/extracted.mk is created with "undefined" for MODULE_NAME, MODULE_VERSION, MODULE_RELEASE
dnl
AC_DEFUN([HGTWinternal_ENABLE_MOCK_BUILD_ACTIONS_WHEN_DISABLED], [
    dnl
    dnl Part 4ish (create a dummy empty ./mk/configured.mk)
    dnl
    HGTW_MSG_VERBOSE([configuring ${CONFIGFILE?} as disabled])
    mkdir -p ${tCONFIGFILE%/*} && tee ${tCONFIGFILE?} <<__EOF__ | sed -e "s,^,${CONFIGFILE##*/}-> ," && mv -f "${tCONFIGFILE?}" "${CONFIGFILE?}"
# prefix, includedir, modulesdir, libdir, _lib are all expected to have been set in the containing Makefile
hypogeal_twilight_prefix = ${hypogeal_twilight_prefix}
hypogeal_twilight_libexecdir = ${hypogeal_twilight_libexecdir}
hypogeal_twilight_datarootdir = ${hypogeal_twilight_datarootdir}
hypogeal_twilight_datadir = ${hypogeal_twilight_datadir} 
vernacular_doggerel_prefix = ${vernacular_doggerel_prefix}
vernacular_doggerel_libexecdir = ${vernacular_doggerel_libexecdir}
vernacular_doggerel_datarootdir = ${vernacular_doggerel_datarootdir}
vernacular_doggerel_datadir = ${vernacular_doggerel_datadir}
# now found in ${EXTRACTFILE}
# MODULE_NAME = undefined
# MODULE_VERSION = undefined
# MODULE_RELEASE = undefined
__EOF__
    HGTW_MSG_VERBOSE([configuring ${EXTRACTFILE?} as disabled])
    mkdir -p ${tEXTRACTFILE%/*} && tee ${tEXTRACTFILE?} <<__EOF__ | sed -e "s,^,${EXTRACTFILE##*/}-> ," && mv -f "${tEXTRACTFILE?}" "${EXTRACTFILE?}"
MODULE_NAME = undefined
MODULE_VERSION = undefined
MODULE_RELEASE = undefined
__EOF__
])
