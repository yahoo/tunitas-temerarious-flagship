dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_PROG_PROTOC      [[preferred]]              (no arguments)
dnl HGTW_CHECK_PROTOC     [[deprecated,neverwas]]    (no arguments)
dnl
dnl The preferred form is the "PROG" form around HGTW_PROG_PROTC
dnl
dnl There "never was" a HGTW_CHECK_PROTOC, but it is a common idiomatic mistake.
dnl Thus we support it but warn that it is deprecated usage.  It was introduced in a deprecated state.

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_PROG_PROTOC      (no arguments)
dnl
dnl HGTW_PROG_PROTOC and HGTW_CHECK_PROTOC are basically same thing at this point
dnl
dnl e.g.
dnl    protobuf-compiler-3.5.0-8.fc29.x86_64 : Protocol Buffers compiler
dnl
AC_DEFUN([HGTW_PROG_PROTOC], [
    AC_ARG_VAR(PROTOC, [The Protocol Buffer Compiler])
    AC_CHECK_PROG([PROTOC], [protoc], [protoc])
])
AC_DEFUN([HGTW_CHECK_PROTOC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([[HGTW]_[CHECK]_[PROTOC]], [[HGTW]_[PROG]_[PROTOC]])
    HGTW_PROG_PROTOC
])
