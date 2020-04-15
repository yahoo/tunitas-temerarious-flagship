dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.

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
