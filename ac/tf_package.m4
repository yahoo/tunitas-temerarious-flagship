dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018-2019, Oath Inc.
dnl Licensed under the terms of the Apache-2.0 license.
dnl See the LICENSE file in https://github.com/yahoo/temerarious-flagship/blob/master/LICENSE for terms.

dnl
dnl TF_PACKAGE_VARIABLES            (no options)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_PACKAGE_VARIABLES            (no options)
dnl
AC_DEFUN([TF_PACKAGE_VARIABLES], [
  ifdef([SCOLD_PACKAGE_VARIABLES],
        [SCOLD_PACKAGE_VARIABLES],
        [TF_MSG_WARNING([[TF]_[ENABLE]_[GCC] is not implemented, ignoring it])])
])
