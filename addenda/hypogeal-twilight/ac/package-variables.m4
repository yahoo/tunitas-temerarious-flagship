dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_PACKAGE_VARIABLES
dnl [[deprecated]] SCOLD_PACKAGE_VARIABLES
dnl
dnl Amplifies the variables which are set by AC_INIT
dnl    shell variables suitable for use in configure.ac
dnl    cpp symbols, which will appear in config.h
dnl
dnl Catalog
dnl   PACKAGE_NAME                  codeful
dnl   PACKAGE_TARNAME               codeful-1.2.3.tar.xz
dnl   PACKAGE_VERSION               1.2.3                 (following semver.org)
dnl   PACKAGE_STRING                codeful-1.2.3
dnl   PACKAGE_BUGREPORT             /dev/null@codeful.project.example
dnl   PACKAGE_URL                   http://codeful.project.example/
dnl
dnl   PACKAGE_VERSION_STRING        v1.2.3                 (following semver.org as a perl vstring)
dnl   PACKAGE_MAJOR_NUMBER          1
dnl   PACKAGE_MINOR_NUMBER          2
dnl   PACKAGE_PATCH_NUMBER          3
dnl   PACKAGE_MAJOR_NUMBER_STRING   "1"   (cpp only)
dnl   PACKAGE_MINOR_NUMBER_STRING   "2"   (cpp only)
dnl   PACKAGE_PATCH_NUMBER_STRING   "3"   (cpp only)
dnl
dnl (like datarootdir, but one level down)
dnl   appdatadir                (shell only)
dnl   PACKAGE_APPDATADIR        (cpp only)         "/usr/local/share/codeful"
dnl
dnl (like localstatedir, but one level down)
dnl   localstatedir             (shell only)
dnl   PACKAGE_APPLOCALSTATEDIR  (cpp only)         "/usr/local/share/codeful"
dnl
dnl (like sysconfdir, but one level down)
dnl   siteconfigdir             (shell only)
dnl   PACKAGE_SITECONFIGDIR     (cpp only)         "/usr/local/etc/codeful"
dnl
dnl THEORY - from configure (autoconf-2.69-10.fc19.noarch)
dnl
dnl Fine tuning of the installation directories:
dnl   --bindir=DIR            user executables [EPREFIX/bin]
dnl   --sbindir=DIR           system admin executables [EPREFIX/sbin]
dnl   --libexecdir=DIR        program executables [EPREFIX/libexec]
dnl   --sysconfdir=DIR        read-only single-machine data [PREFIX/etc]
dnl   --sharedstatedir=DIR    modifiable architecture-independent data [PREFIX/com]
dnl   --localstatedir=DIR     modifiable single-machine data [PREFIX/var]
dnl   --libdir=DIR            object code libraries [EPREFIX/lib]
dnl   --includedir=DIR        C header files [PREFIX/include]
dnl   --oldincludedir=DIR     C header files for non-gcc [/usr/include]
dnl   --datarootdir=DIR       read-only arch.-independent data root [PREFIX/share]
dnl   --datadir=DIR           read-only architecture-independent data [DATAROOTDIR]
dnl   --infodir=DIR           info documentation [DATAROOTDIR/info]
dnl   --localedir=DIR         locale-dependent data [DATAROOTDIR/locale]
dnl   --mandir=DIR            man documentation [DATAROOTDIR/man]
dnl   --docdir=DIR            documentation root [DATAROOTDIR/doc/${PACKAGE_NAME}]
dnl   --htmldir=DIR           html documentation [DOCDIR]
dnl   --dvidir=DIR            dvi documentation [DOCDIR]
dnl   --pdfdir=DIR            pdf documentation [DOCDIR]
dnl   --psdir=DIR             ps documentation [DOCDIR]
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([SCOLD_PACKAGE_VARIABLES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([SCOLD_[PACKAGE]_VARIABLES], [HGTW_[PACKAGE]_VARIABLES])
    HGTW_PACKAGE_VARIABLES
])
AC_DEFUN([HGTW_PACKAGE_VARIABLES], [
AC_REQUIRE([AC_PREFIX_DEFAULT])
AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
: is there a better way to do this ... prefix its default value set very late
if test NONE = ${prefix?} ; then
  prefix=${ac_default_prefix?}
  # when this happens, you pretty much always want to know that it is occurring.
  HGTW_MSG_NOTICE([because --prefix was not explicit, setting prefix=$ac_default_prefix in [HGTW]_[PACKAGE_VARIABLES]])
fi 
if test NONE = ${exec_prefix?} ; then
  exec_prefix=${prefix?}
  # ibidem.
  HGTW_MSG_NOTICE([because --exec-prefix was not explicit, setting exec_prefix=$prefix in [HGTW]_[PACKAGE_VARIABLES]])
fi 
# These variables are set by AC_INIT
test xyes = x$enable_configure_verbose && cat <<__HGTW_PACKAGE_VARIABLES__ANNOUNCE1__
PACKAGE_NAME=${PACKAGE_NAME:-unset, an UNEXPECTED-ERROR}
PACKAGE_TARNAME=${PACKAGE_TARNAME:-unset, an UNEXPECTED-ERROR}
PACKAGE_VERSION=${PACKAGE_VERSION:-unset, an UNEXPECTED-ERROR}
PACKAGE_STRING=${PACKAGE_STRING:-unset, an UNEXPECTED-ERROR}
PACKAGE_BUGREPORT=${PACKAGE_BUGREPORT:-unset, an UNEXPECTED-ERROR}
PACKAGE_URL=${PACKAGE_URL:-unset, an UNEXPECTED-ERROR}
__HGTW_PACKAGE_VARIABLES__ANNOUNCE1__
{
    # WATCHOUT - [ ] are the m4 quote characters which cannot be escaped
    # the { } do not affect m4, they only serve to document the extent of the quote reassignment need
    changequote(<,>)dnl
    PACKAGE_MAJOR_NUMBER=$(expr "${PACKAGE_VERSION}" : "\([^.]*\)\.[^.]*\..*")
    PACKAGE_MINOR_NUMBER=$(expr "${PACKAGE_VERSION}" : "[^.]*\.\([^.]*\)\..*")
    PACKAGE_PATCH_NUMBER=$(expr "${PACKAGE_VERSION}" : "[^.]*\.[^.]*\.\(.*\)")
    changequote([,])dnl
    PACKAGE_VERSION_REDERIVED="${PACKAGE_MAJOR_NUMBER}.${PACKAGE_MINOR_NUMBER}.${PACKAGE_PATCH_NUMBER}"
    PACKAGE_VERSION_STRING="v${PACKAGE_VERSION_REDERIVED}"
}
# These variables are set herein (above)
test xyes = x$enable_configure_verbose && cat <<__HGTW_PACKAGE_VARIABLES__ANNOUNCE2__
PACKAGE_VERSION_REDERIVED=${PACKAGE_VERSION_REDERIVED:-unset, an UNEXPECTED-ERROR}
PACKAGE_VERSION_STRING=${PACKAGE_VERSION_STRING:-unset, an UNEXPECTED-ERROR}
PACKAGE_MAJOR_NUMBER=${PACKAGE_MAJOR_NUMBER:-unset, an UNEXPECTED-ERROR}
PACKAGE_MINOR_NUMBER=${PACKAGE_MINOR_NUMBER:-unset, an UNEXPECTED-ERROR}
PACKAGE_PATCH_NUMBER=${PACKAGE_PATCH_NUMBER:-unset, an UNEXPECTED-ERROR}
__HGTW_PACKAGE_VARIABLES__ANNOUNCE2__

# See http://semver.org
AC_DEFINE_UNQUOTED([PACKAGE_MAJOR_NUMBER], ${PACKAGE_MAJOR_NUMBER}, [Package (semver.org) major version, as an integer])
AC_DEFINE_UNQUOTED([PACKAGE_MINOR_NUMBER], ${PACKAGE_MINOR_NUMBER}, [Package (semver.org) minor version, as an integer])
AC_DEFINE_UNQUOTED([PACKAGE_PATCH_NUMBER], ${PACKAGE_PATCH_NUMBER}, [Package (semver.org) patch level, as an integer])

AC_DEFINE_UNQUOTED([PACKAGE_MAJOR_NUMBER_STRING], "${PACKAGE_MAJOR_NUMBER}", [Package (semver.org) major version, as a string literal])
AC_DEFINE_UNQUOTED([PACKAGE_MINOR_NUMBER_STRING], "${PACKAGE_MINOR_NUMBER}", [Package (semver.org) minor version, as a string literal])
AC_DEFINE_UNQUOTED([PACKAGE_PATCH_NUMBER_STRING], "${PACKAGE_PATCH_NUMBER}", [Package (semver.org) patch level, as a string literal])

# PACKAGE_VERSION        is "0.0.0"  not a "vstring"
# PACKAGE_VERSION_STRING is "v0.0.0" is a "vstring"
AC_DEFINE_UNQUOTED([PACKAGE_VERSION_STRING], "${PACKAGE_VERSION_STRING}", [Package (semver.org) version, as a vstring])

# [[FIXTHIS]]
# [[FIXTHIS]]
# [[FIXTHIS]]
# [[FIXTHIS]]
# [[FIXTHIS]]
# [[FIXTHIS]]
# [[FIXTHIS]] see the scheme in aggressive-sackbut-negation for how this is "done right"
# [[FIXTHIS]]
# eval through the levels of indirection
if test -z "$rundir" ; then
    eval rundir="/run"
    eval rundir="$rundir"
    eval rundir="$rundir"
    eval rundir="$rundir"
    eval rundir="$rundir"
    AC_DEFINE_UNQUOTED([PACKAGE_RUNDIR], ["$rundir"], [The run directory, for the pidfile, architecture-independent and ephemeral])
    HGTW_MSG_VERBOSE([defining PACKAGE_RUNDIR as $rundir])
fi
if test -z "$applibexecdir" ; then
    eval applibexecdir="${libexecdir}/${PACKAGE_NAME}"
    eval applibexecdir="$applibexecdir"
    eval applibexecdir="$applibexecdir"
    eval applibexecdir="$applibexecdir"
    eval applibexecdir="$applibexecdir"
    AC_DEFINE_UNQUOTED([PACKAGE_APPLIBEXECDIR], ["$applibexecdir"], [Application executable library, architecture-dependent])
    HGTW_MSG_VERBOSE([defining PACKAGE_APPLIBEXECDIR as $applibexecdir])
fi
if test -z "$appdatadir" ; then
    eval appdatadir="${datadir}/${PACKAGE_NAME}"
    eval appdatadir="$appdatadir"
    eval appdatadir="$appdatadir"
    eval appdatadir="$appdatadir"
    eval appdatadir="$appdatadir"
    AC_DEFINE_UNQUOTED([PACKAGE_APPDATADIR], ["$appdatadir"], [Application-level read-only data, architecture-independent and slowly-changing])
    HGTW_MSG_VERBOSE([defining PACKAGE_APPDATADIR as $appdatadir])
fi
if test -z "$applocalstatedir" ; then
    eval applocalstatedir="${localstatedir}/${PACKAGE_NAME}"
    eval applocalstatedir="$applocalstatedir"
    eval applocalstatedir="$applocalstatedir"
    eval applocalstatedir="$applocalstatedir"
    eval applocalstatedir="$applocalstatedir"
    AC_DEFINE_UNQUOTED([PACKAGE_APPLOCALSTATEDIR], ["$applocalstatedir"], [Application-level modifiable state, architecture-dependent and arbitrarily-changing])
    HGTW_MSG_VERBOSE([defining PACKAGE_APPLOCALSTATEDIR as $applocalstatedir])
fi
if test -z "$siteconfigdir" ; then
    eval siteconfigdir="${sysconfdir}/${PACKAGE_NAME}"
    eval siteconfigdir="$siteconfigdir"
    eval siteconfigdir="$siteconfigdir"
    eval siteconfigdir="$siteconfigdir"
    eval siteconfigdir="$siteconfigdir"
    AC_DEFINE_UNQUOTED([PACKAGE_SITECONFIGDIR], ["$siteconfigdir"], [Site-level configuration data])
    HGTW_MSG_VERBOSE([defining PACKAGE_SITECONFIGDIR as $siteconfigdir])
fi
])
#end
