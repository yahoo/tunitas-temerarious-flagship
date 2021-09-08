dnl This is a GNU -*- autoconf -*- specification that is processed by Autoconf.
dnl Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
dnl Licensed under the terms of the Apache-2.0 license.
dnl For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
dnl For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE

dnl
dnl For <that> in DC (the SCOLD Disaggregation Compiler, DC)
dnl    ... there is at present but one member of this distinguished set
dnl
dnl TF_PROG_<that>
dnl
dnl Tests for DC, PRTOC and others

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl TF_PROG_<that>
dnl for <that> in DC (the SCOLD Disaggregation Compiler, DC)
dnl
dnl Some basic well-understood checkification of tools (programs).
dnl Following the paradigm of AC_PROG_CXX, etc.
dnl
AC_DEFUN([TF_PROG_DC], [
    AC_ARG_VAR([DC], [The S.C.O.L.D. CPP Language Disaggregation Compiler (DC)])
    : ${DC:=remonstrate}
    if ! type -p ${DC?} ; then
        AC_MSG_WARN([The S.C.O.L.D. preprocessor ${DC} is not present or is not in your path])
        DC=/opt/scold/bin/remonstrate
        AC_MSG_WARN([the default and expected location is ${DC?}])
        AC_MSG_WARN([the build process will use that in the absence of any other definition])
	if test ! -x ${DC?} ; then
	    AC_MSG_WARN([the disaggregation compiler DC=${DC?} does not exist])
	    if rpm -q baleful-ballad >& /dev/null; then
	        AC_MSG_WARN([the package baleful-ballad is installed, but there is no ${DC?}])
            else
	        AC_MSG_WARN([the package baleful-ballad provides ${DC?}])
	        AC_MSG_WARN([try: dnf install baleful-ballad])
            fi
	    AC_MSG_WARN([this build can reasonably be expected to fail])
	fi			    
    fi
])

AC_DEFUN([TF_PROG_PROTOC], [
    ifdef([HGTW_PROG_PROTOC], [HGTW_PROG_PROTOC], [
        AC_ARG_VAR([PROTOC], [The Protocol Buffer Compiler])
        AC_CHECK_PROG([PROTOC], [protoc], [protoc])
    ])
])

AC_DEFUN([TF_PROG_PROTOC], [
    ifdef([HGTW_PROG_PROTOC], [HGTW_PROG_PROTOC], [
        AC_ARG_VAR([PROTOC], [The Protocol Buffer Compiler])
        AC_CHECK_PROG([PROTOC], [protoc], [protoc])
    ])
])

dnl end
