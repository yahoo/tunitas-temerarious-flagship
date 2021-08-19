dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_INIT(package-name, major.minor.patch, email-address)
dnl [[deprecated]] SCOLD_INIT(package-name, major.minor.patch, email-address)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Example (cut & paste this)
dnl
dnl    AC_INIT([module-specimen], [0.0.0], [admin@example.org])
dnl    HGTW_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
dnl    AC_PREREQ([2.69])
dnl    AM_PROG_AR             dnl first
dnl    AC_PROG_LIBTOOL
dnl    AC_PROG_CXX
dnl    AC_PREREQ([2.69])
dnl    LT_PREREQ([2.4.2])
dnl    LT_INIT                dnl second
dnl    AC_LANG([C++])
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl No point in complaining about deprecation, this is too early in the cycle.
AC_DEFUN([SCOLD_INIT], [HGTW_INIT([$1], [$2], [$3])])

dnl FAILs ---> dnl https://stackoverflow.com/questions/22871340/using-a-variable-in-ac-init#22875075
dnl FAILs ---> dnl
dnl FAILs ---> dnl The arguments of 'AC_INIT' must be static, i.e., there should not be any shell computation, quotes, or newlines, but they can be computed by M4. This is because the package information strings are expanded at M4 time into several contexts, and must give the same text at shell time whether used in single-quoted strings, double-quoted strings, quoted here-documents, or unquoted here-documents. It is permissible to use 'm4_esyscmd' or 'm4_esyscmd_s' for computing a version string that changes with every commit to a version control system (in fact, Autoconf does just that, for all builds of the development tree made between releases).
dnl FAILs ---> dnl 
dnl FAILs ---> dnl This is what autoconf (currently) uses:
dnl FAILs ---> dnl 
dnl FAILs ---> dnl AC_INIT([GNU Autoconf],
dnl FAILs ---> dnl     m4_esyscmd([build-aux/git-version-gen .tarball-version]),
dnl FAILs ---> dnl     [bug-autoconf@gnu.org])
dnl FAILs ---> dnl 
dnl FAILs ---> dnl If you don't need to read the version from an outside source, here's what GLIB uses:
dnl FAILs ---> dnl 
dnl FAILs ---> dnl m4_define([glib_major_version], [2])
dnl FAILs ---> dnl m4_define([glib_minor_version], [41])
dnl FAILs ---> dnl m4_define([glib_micro_version], [0])
dnl FAILs ---> dnl m4_define([glib_version], [glib_major_version.glib_minor_version.glib_micro_version])
dnl FAILs ---> dnl AC_INIT(glib, [glib_version], ...)

dnl
dnl HGTW_INIT(package-name, major, minor, patchlevel, email-address)
dnl
dnl Use 'define' here because this is init!  the m4 sugar is not available yet
dnl ... definitely AC_DEFUN is not available yet.
dnl
dnl We want to wrap up the SCOLD init declarations to ensure the package name
dnl and version gets propagated to all the sites where it is needed.
dnl
AC_DEFUN([HGTW_INIT], [
    dnl WATCHOUT - AC_INIT must have been called to get here ... to get AC_DEFUN to work
    # WATCHOUT - shell variables must be bound only *after* AC_INIT
    dnl and shell variables are best used for debug statements
    NAME=$1
    AC_PREFIX_DEFAULT([/usr/local])
    #
    # From AC_INIT, we already get
    # -DPACKAGE_NAME=\"something-something-dark-side\"
    # -DPACKAGE_TARNAME=\"something-something-dark-side.sticky.sticky.tarball\"
    # -DPACKAGE_VERSION=\"0.1.0\"
    # -DPACKAGE_STRING=\"something-something-dark-side\ 0.1.0\"
    # -DPACKAGE_BUGREPORT=\"administrator@something.something.dark.side.public-suffix.list\"
    # -DPACKAGE_URL=\"https://something.something.dark-side.public-suffix.list/\"
    #
    # -DPACKAGE=\"something-something-dark-side\"
    # -DVERSION=\"0.1.0\"
    #
    # We want more
    # -DPACKAGE_MAJOR=0
    # -DPACKAGE_MINOR=1
    # -DPACKAGE_PATCH=0
    #   
    AC_DEFINE([PACKAGE_MAJOR],
              [m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\1})m4_changequote({[}, {]})],
              [Major version of $1 $2])
    AC_DEFINE([PACKAGE_MINOR], 
              [m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\2})m4_changequote({[}, {]})],
              [Minor version of $1 $2])
    AC_DEFINE([PACKAGE_PATCH], 
              [m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\3})m4_changequote({[}, {]})],
              [Patch level of $1 $2]) 
    AC_SUBST([PACKAGE_MAJOR])
    AC_SUBST([PACKAGE_MINOR])
    AC_SUBST([PACKAGE_PATCH]) 
    [PACKAGE_MAJOR]=m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\1})m4_changequote({[}, {]})
    [PACKAGE_MINOR]=m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\2})m4_changequote({[}, {]})
    [PACKAGE_PATCH]=m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\3})m4_changequote({[}, {]}) 
    dnl deprecating "PATCHLEVEL" in favor of "PATCH"
    AC_DEFINE([PACKAGE_PATCHLEVEL],
              [m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\3})m4_changequote({[}, {]})],
              [Patch level of $1 $2])
    AC_SUBST([PACKAGE_PATCHLEVEL])
    [PACKAGE_PATCHLEVEL]=m4_changequote([{], [}])m4_bpatsubst({$2}, {\([^.]+\)\.\([^.]+\)\.\([^.]+\)}, {\3})m4_changequote({[}, {]}) 
    HGTWinternal_AUTOTOOLS
    HGTWinternal_TOOLCHAIN
])

dnl to be called from HGTW_INIT
AC_DEFUN([HGTWinternal_AUTOTOOLS], [
    dnl
    dnl https://www.gnu.org/software/automake/manual/html_node/Automake-silent_002drules-Option.html
    dnl
    dnl A double opt-in is required.
    dnl Both
    dnl 1. It is not possible to instead specify silent-rules in a Makefile.am file. 
    dnl    Either
    dnl    (a) Add the silent-rules option as argument to AM_INIT_AUTOMAKE.
    dnl        as AM_INIT_AUTOMAKE([silent-rules])
    dnl    (b) Call the AM_SILENT_RULES macro from within the configure.ac file. 
    dnl 2. Either
    dnl    (a) ./configure --enable-silent-rules
    dnl        enable the silent rules by default;
    dnl    (b) make V=0
    dnl        to disable the “verbose” build; 
    dnl 
    dnl To change the default, and make all builds silent unless otherwise requested,
    dnl Both
    dnl    1. AM_SILENT_RULES([yes])
    dnl       This give silent rules by default
    dnl    2. To recover the verbose rules effect,
    dnl       Either
    dnl       (a) ./configure --disable-silent-rules
    dnl       (b) make V=1.
    dnl
    AM_INIT_AUTOMAKE dnl see AUTOMAKE_OPTIONS in Makefile.am
    AM_SILENT_RULES([yes])
])

dnl to be called from HGTW_INIT
AC_DEFUN([HGTWinternal_TOOLCHAIN], [
    : indeed, nothing to initialize yet
])

#end
