dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_PACKAGE_VARIABLES            (no options)
dnl
dnl Amplifies the variables which are set by AC_INIT
dnl    shell variables suitable for use in configure.ac
dnl    cpp symbols, which will appear in config.h
dnl
dnl Catalog:
dnl
dnl   PACKAGE_NAME                  mypackage
dnl   PACKAGE_TARNAME               mypackage-1.2.3.tar.xz
dnl   PACKAGE_VERSION               1.2.3                 (following semver.org)
dnl   PACKAGE_STRING                mypackage-1.2.3
dnl   PACKAGE_BUGREPORT             /dev/null@mypackage.project.example
dnl   PACKAGE_URL                   http://mypackage.project.example/
dnl
dnl   PACKAGE_VERSION_STRING        v1.2.3                 (following semver.org as a perl-style vstring)
dnl   PACKAGE_MAJOR_NUMBER          1
dnl   PACKAGE_MINOR_NUMBER          2
dnl   PACKAGE_PATCH_NUMBER          3
dnl   PACKAGE_MAJOR_NUMBER_STRING   "1"   (cpp only)
dnl   PACKAGE_MINOR_NUMBER_STRING   "2"   (cpp only)
dnl   PACKAGE_PATCH_NUMBER_STRING   "3"   (cpp only)
dnl
dnl (like datarootdir, but one level down)
dnl   appdatadir                (shell only)
dnl   PACKAGE_APPDATADIR        (cpp only)         "/usr/local/share/mypackage"
dnl
dnl (like localstatedir, but one level down)
dnl   localstatedir             (shell only)
dnl   PACKAGE_APPLOCALSTATEDIR  (cpp only)         "/usr/local/share/mypackage"
dnl
dnl (like sysconfdir, but one level down)
dnl   siteconfigdir             (shell only)
dnl   PACKAGE_SITECONFIGDIR     (cpp only)         "/usr/local/etc/mypackage"
dnl
dnl THEORY - from configure (c.f. autoconf-2.69-10.fc19.noarch)
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

dnl
dnl TF_PACKAGE_VARIABLES            (no options)
dnl
AC_DEFUN([TF_PACKAGE_VARIABLES], [
  ifdef([HGTW_PACKAGE_VARIABLES],
        [HGTW_PACKAGE_VARIABLES],
        [ifdef([SCOLD_PACKAGE_VARIABLES],
               [SCOLD_PACKAGE_VARIABLES],
               [TF_MSG_WARNING([[TF]_[ENABLE]_[GCC] is not implemented, ignoring it])])])
])
