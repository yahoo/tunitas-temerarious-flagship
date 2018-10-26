dnl
dnl TF_PROG_<that>
dnl for <that> in DC (the SCOLD Disaggregation Compiler, DC)
dnl
dnl Some basic well-understood checkification of tools (programs).
dnl Following the paradigm of AC_PROG_CXX, etc.
dnl

AC_DEFUN([TF_PROG_DC], [
    AC_ARG_VAR([DC], [The SCOLD CPP Language Disaggregation Compiler (DC)])
    : ${DC:=remonstrate}
    if ! type -p ${DC?} ; then
        AC_MSG_WARN([The SCOLD preprocessor ${DC} is not present or is not in your path])
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