dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_RPM_PACKAGE_CHECKING
dnl [[deprecated]] SCOLD_ENABLE_RPM_PACKAGE_CHECKING
dnl
dnl Control whether specific rpm packages are to be looked for
dnl There is no point in doing this on a non-rpm system.
dnl There is no point in doing this within an rpm build (the spec file *should* cover it)
dnl There is a possibility of using other packages that provide the same capability (e.g. mysql vs mariadb).
dnl 
AC_DEFUN([SCOLD_ENABLE_RPM_PACKAGE_CHECKING], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[ENABLE]_[RPM]_[PACKAGE]_CHECKING], [HGTW_[ENABLE]_[RPM]_[PACKAGE]_CHECKING])
    HGTW_ENABLE_RPM_PACKAGE_CHECKING
])
AC_DEFUN([HGTW_ENABLE_RPM_PACKAGE_CHECKING], [
    AC_ARG_ENABLE([rpm-package-checking],
                  [AS_HELP_STRING([--disable-rpm-package-checking], [disable checking for specific rpm packages])],
                  [
                      if test no = "$enable_rpm_package_checking" ; then
                          rpm_package_checking=0
                      else
                          rpm_package_checking=1
                      fi
                   ], [
                       rpm_package_checking=1
                   ])
])
