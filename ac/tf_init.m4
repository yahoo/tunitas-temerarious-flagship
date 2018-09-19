dnl
dnl TF_INIT(package, version, bugreport)
dnl
dnl Whereas AC_INIT does not like to be disintermediated.
dnl but someone has to initialize automake, libtool and do
dnl some basic preamble stuff...
dnl
dnl Usage:
dnl
dnl     AC_INIT([mypackage], [1.2.3], [/dev/null@example.com])
dnl     TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)
dnl
AC_DEFUN([TF_INIT], [
    SCOLD_INIT([$1], [$2], [$3])
])