dnl
dnl TF_CHECK_<that> for BOOST, JSONCPP, MYSQLPP, UUID
dnl
dnl Some basic well-understood checkification.
dnl

AC_DEFUN([TF_CHECK_APACHE_HTTPD], [SCOLD_CHECK_APACHE_HTTPD])
AC_DEFUN([TF_CHECK_BOOST],        [SCOLD_CHECK_BOOST])
AC_DEFUN([TF_CHECK_JSONCPP],      [SCOLD_CHECK_JSONCPP])
AC_DEFUN([TF_CHECK_MYSQLPP],      [SCOLD_CHECK_MYSQLPP])
AC_DEFUN([TF_CHECK_SQLITE],       [SCOLD_CHECK_SQLITE])
AC_DEFUN([TF_CHECK_UUID],         [SCOLD_CHECK_UUID])

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
