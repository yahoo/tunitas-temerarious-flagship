dnl Copyright 2019, Oath Inc. Licensed under the terms of the Apache-2.0 license. See LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.
dnl
dnl TF_CHECK_<that> for BOOST, JSONCPP, MYSQLPP, UUID
dnl
dnl Some basic well-understood checkification.
dnl

AC_DEFUN([TF_CHECK_APACHE_HTTPD], [SCOLD_CHECK_APACHE_HTTPD])
AC_DEFUN([TF_CHECK_BOOST],        [SCOLD_CHECK_BOOST])
AC_DEFUN([TF_CHECK_CPPUNIT],      [SCOLD_CHECK_CPPUNIT])
AC_DEFUN([TF_CHECK_JSONCPP],      [SCOLD_CHECK_JSONCPP])
AC_DEFUN([TF_CHECK_MYSQLPP],      [SCOLD_CHECK_MYSQLPP])
AC_DEFUN([TF_CHECK_SQLITE],       [SCOLD_CHECK_SQLITE])
AC_DEFUN([TF_CHECK_UUID],         [SCOLD_CHECK_UUID])

AC_DEFUN([TF_CHECK_STD_FILESYSTEM], [
   # Any reasonable and recent version of gcc needs this
   # e.g.
   #   /usr/lib/gcc/x86_64-redhat-linux/8/libstdc++fs.a
   #   /usr/lib/gcc/x86_64-redhat-linux/8/32/libstdc++fs.a
   #
   AC_SUBST([libstd_filesystem], [-lstdc++fs])
])

# Reminder, and documenting "uuid" vs "libuuid" ...
#
# USE -----> libuuid-devel has uuid.pc
# USE -----> libuuid-devel-2.24.2-1.fc20.x86_64
#
# AVOID ---> uuid-devel does not
# AVOID ---> uuid-devel-1.6.2-21.fc20.x86_64
#
# WATCHOUT - package 'libuuid' has pkgconfig named 'uuid.pc'
# rpm -q -f /usr/lib64/pkgconfig/uuid.pc 
# libuuid-devel-2.24.2-1.fc20.x86_64
#
