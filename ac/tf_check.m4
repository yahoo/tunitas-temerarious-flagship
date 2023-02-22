dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Yahoo Inc. 2021
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl TF_CHECK_<that> for BOOST, JSONCPP, MYSQLPP, UUID
dnl         ... there are at present quite a few members of this set
dnl
dnl TF_CHECK_STD_FILESYSTEM  sets up -lstdc++fs, needed since gcc5
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_CHECK_<that> for BOOST, JSONCPP, MYSQLPP, UUID
dnl
dnl Some basic well-understood checkification.
dnl

AC_DEFUN([TF_CHECK_GCC], [
  ifdef([HGTW_ENABLE_GCC], dnl prefer this newer one
        [HGTW_ENABLE_GCC],
        [ifdef([SCOLD_ENABLE_GCC],
               [SCOLD_ENABLE_GCC],
               [TF_MSG_WARNING([[TF]_[ENABLE]_[GCC] is not implemented, ignoring it])])])
])

dnl
dnl Defines the "toolflags" variables; e.g. cppflags, cflags, cxxflags, ldflags
dnl e.g.
dnl   for the case of TF_CHECK_CPPUNIT
dnl
dnl   @CPPFLAGS_cppunit@
dnl   @CFLAGS_cppunit@
dnl   @CXXFLAGS_cppunit@
dnl   @LDFLAGS_cppunit@
dnl
dnl and so on
dnl but Apache HTTPd is special because it comes with many different clusters of toolflags
dnl [[FIXTHIS]] document apapche
dnl
AC_DEFUN([TF_CHECK_APACHE_HTTPD], [ifdef([HGTW_CHECK_APACHE_HTTPD], [HGTW_CHECK_APACHE_HTTPD], [SCOLD_CHECK_APACHE_HTTPD])])
AC_DEFUN([TF_CHECK_BOOST],        [ifdef([HGTW_CHECK_BOOST],        [HGTW_CHECK_BOOST],        [SCOLD_CHECK_BOOST])])
AC_DEFUN([TF_CHECK_CPPUNIT],      [ifdef([HGTW_CHECK_CPPUNIT],      [HGTW_CHECK_CPPUNIT],      [SCOLD_CHECK_CPPUNIT])])
AC_DEFUN([TF_CHECK_JSONCPP],      [ifdef([HGTW_CHECK_JSONCPP],      [HGTW_CHECK_JSONCPP],      [SCOLD_CHECK_JSONCPP])])
AC_DEFUN([TF_CHECK_MYSQLPP],      [ifdef([HGTW_CHECK_MYSQLPP],      [HGTW_CHECK_MYSQLPP],      [SCOLD_CHECK_MYSQLPP])])
AC_DEFUN([TF_CHECK_SQLITE],       [ifdef([HGTW_CHECK_SQLITE],       [HGTW_CHECK_SQLITE],       [SCOLD_CHECK_SQLITE])])
AC_DEFUN([TF_CHECK_UUID],         [ifdef([HGTW_CHECK_UUID],         [HGTW_CHECK_UUID],         [SCOLD_CHECK_UUID])])

dnl
dnl TF_CHECK_STD_FILESYSTEM  sets up -lstdc++fs, needed since gcc5
dnl
dnl Usage:
dnl
dnl   In Makefile.am (the top level), set the variables
dnl
dnl   Makefile_COMPILER_CPPFLAGS_SET = @CPPFLAGS_gcc@ 
dnl   Makefile_COMPILER_CFLAGS_SET   =   @CFLAGS_gcc@   @CFLAGS_gdb@
dnl   Makefile_COMPILER_CXXFLAGS_SET = @CXXFLAGS_gcc@ @CXXFLAGS_gdb@
dnl   Makefile_COMPILER_LDFLAGS_SET  =  @LDFLAGS_gcc@  @LDFLAGS_gdb@ @libstd_filesystem@ <------------- this
dnl
AC_DEFUN([TF_CHECK_STD_FILESYSTEM], [
   ifdef([HGTW_CHECK_STD_FILESYSTEM], [
        HGTW_CHECK_STD_FILESYSTEM
   ], [
       # Any reasonable and recent version of gcc needs this
       # e.g.
       #   /usr/lib/gcc/x86_64-redhat-linux/8/libstdc++fs.a
       #   /usr/lib/gcc/x86_64-redhat-linux/8/32/libstdc++fs.a
       AC_SUBST([libstd_filesystem], [-lstdc++fs])
    ])
])

########################################
# Reminder, and herein documenting "uuid" vs "libuuid" ...
#
# USE -----> libuuid-devel has uuid.pc
# USE -----> libuuid-devel-2.24.2-1.fc20.x86_64
#
# AVOID ---> uuid-devel does not
# AVOID ---> uuid-devel-1.6.2-21.fc20.x86_64
#
# WATCHOUT - package 'libuuid' has pkgconfig named 'uuid.pc' (not named 'libuuid.pc' as with many other libraries)
# rpm -q -f /usr/lib64/pkgconfig/uuid.pc 
# libuuid-devel-2.24.2-1.fc20.x86_64
#
########################################

dnl
dnl TF_CHECK_PACKAGES(module-name-list, devel-package-name)
dnl TF_CHECK_PACKAGES(module-name-list, devel-package-name, package-title)
dnl
dnl TF_CHECK_PACKAGES_WARNING(module-name-list, devel-package-name)
dnl TF_CHECK_PACKAGES_WARNING(module-name-list, devel-package-name, package-title)
dnl
dnl TF_CHECK_PACKAGES_ERROR(module-name-list, devel-package-name)
dnl TF_CHECK_PACKAGES_ERROR(module-name-list, devel-package-name, package-title)
dnl
dnl
dnl Wherein
dnl   module-name-list    ::= a list of S.C.O.L.D. type modules as you would name them in an #import statement
dnl   devel-package-name  ::= a single RPM package name as you would install it with dnf
dnl
dnl Examples
dnl
dnl   module-name-list
dnl     [std.is_same]                        ... a list of one S.C.O.L.D. module
dnl     [nonstd]                             ... ibidem
dnl     [sys.exits.Code sys.posix.open]      ... a list of two S.C.O.L.D. modules (both will have to be present appear)
dnl
dnl   devel-package-name
dnl     [module-std-devel]                   ... the name of the rpm package that you should install
dnl     [module-dnl-devel]                   ... ibidem
dnl     [module-sys-devel]                   ... these names are used in messaging, they are not probed with rpm -q
dnl
dnl   package-title
dnl
dnl     The Standard Library
dnl     The Non-Standard Library
dnl     The Tunias Basic Components
dnl     The MySQL C++ API
dnl     The cURL C++ API
dnl
dnl For grammatical niceness, you will likely feel the need for an article in package-title
dnl but that may not be relevant so we are not supplying it for you in $3 package-title
dnl
dnl The check does not test whether the named rpm package is actually installed.
dnl The check attempts to compile a program that uses the S.C.O.L.D. module (its C++ #include header)
dnl and based upon the failure of that test then emits the error and quits.
dnl
dnl Usage:
dnl
dnl                               dnf install module-std-devel
dnl                                           |
dnl                #import std                |                The descriptive naming convention
dnl                #import std.is_same        |                    |
dnl                        |     |            |                    |
dnl                        v     v            v                    v
dnl   TF_CHECK_PACKAGES([std std.is_same], [module-std-devel], [The Standard C++ Library, module-std >= 1.0])
dnl   TF_CHECK_PACKAGES([nonstd], [module-nonstd-devel], [The Non-Standard C++ Library, module-nonstd >= 1.3])
dnl   TF_CHECK_PACKAGES([mysqlpp], [module-mysql-devel]) dnl ..... no description
dnl   TF_CHECK_PACKAGES([curlpp], [module-curl-devel]) dnl ....... no description given
dnl
AC_DEFUN([TF_CHECK_PACKAGES], [
  TF_CHECK_PACKAGES_WARNING([$1], [$2], [$3])
])
AC_DEFUN([TF_CHECK_PACKAGES_WARNING], [
  TFinternal_CHECK_PACKAGES_CANNOT_PROCEED([$1], [$2], [$3], [
     TF_MSG_WARNING([should proceed without $2, there may be errors])
  ])
])
AC_DEFUN([TF_CHECK_PACKAGES_ERROR], [
  TFinternal_CHECK_PACKAGES_CANNOT_PROCEED([$1], [$2], [$3], [
     TF_MSG_ERROR([cannot proceed without $2, you MUST install $3])
  ])
])
AC_DEFUN([TFinternal_CHECK_PACKAGES_CANNOT_PROCEED], [
    AC_REQUIRE([TF_COMPONENT_METADIRECTORY_TIERS])
    AC_REQUIRE([TF_WITH_STD_SCOLD])
    AC_REQUIRE([TF_WITH_STD_TUNITAS])
    __CPPFLAGS="$CPPFLAGS"
    dnl [[FIXTHIS]] this does not work out well in development where the headers are expected to be discovered in the search path (there is yet no search path)
    dnl If you are using the development options to specify locations other than --with-std-tunitas=DIR and --with-std-scold=DIR
    dnl e.g. if you have a special feature in /build/tunitas/basics and you use --with-tunitas-basics=/build/tunitas/basics
    dnl reminder: as of Release 03 (Gnarled Manzanita), the nomenclature change of s/std/opt/ was adopted.  Compatibility with the Old Way requires duplicated lines.
    CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }${opt_tunitas_prefix:+-I$opt_tunitas_prefix/modules -I$opt_tunitas_prefix/include }"
    CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }${std_tunitas_prefix:+-I$std_tunitas_prefix/modules -I$std_tunitas_prefix/include }"
    CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }${opt_scold_prefix:+-I$opt_scold_prefix/modules -I$opt_scold_prefix/include }"
    CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }${std_scold_prefix:+-I$std_scold_prefix/modules -I$std_scold_prefix/include }"
    AC_CHECK_HEADERS([$1],
                     [ : ok found ],
                     [
                         # the (English) grammer here is difficult as [$]3 may be empty; but also [$]1 may be single or several (so plural).
                         TF_MSG_WARNING([cannot find the modules ifelse([$3], [], [around $1], [of $3])])
                         TF_MSG_WARNING([consider: dnf install $2])
                         # expect [$]4 to be a fragment of ERROR or WARNING code
                         $4 # FIXTHIS a way to disable this as a hard error from the command line
                     ])
    CPPFLAGS="$__CPPFLAGS"
    unset __CPPFLAGS
])
