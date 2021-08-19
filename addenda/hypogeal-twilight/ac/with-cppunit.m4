dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_WITH_CPPUNIT        (and no arguments)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HT_WITH_CPPUNIT        (and no arguments)
dnl
dnl with or without CppUnit
dnl the use of standard or non-standard CppUnit is a choice dependent upon this
dnl
dnl Usage: (in configure.ac)
dnl
dnl    HT_WITH_CPPUNIT ........................ yes or no?
dnl    HT_WITH_NONSTD_CPPUNIT ................. in a weird place?
dnl    HT_CHECK_CPPUNIT ....................... establishes te ${TOOL}FLAGS-variables
dnl
AC_DEFUN([HT_WITH_CPPUNIT], [
    AC_ARG_WITH([cppunit],
                [AS_HELP_STRING([--with-cppunit], [use --with-cppunit=ROOT])])
    AC_ARG_ENABLE([cppunit],
                  [AS_HELP_STRING([--enable-cppunit], [ERROR use --with-cppunit=ROOT])],
                  [AC_MSG_WARN([instead of --enable-cppunit{enableval:=$enableval}, use --with-cppunit=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-cppunit=ROOT, e.g. --with-nonstd-cppunit=${prefix:-ROOT}])])
])
