# within a test driving -*- shell-script -*-
# source ${incendiary_sophist_riggingdir:-$prefix/lib/rigging}/sysexits.sh || exit 70
#
# Expectation:
#
#    configure.ac contains
#
#         AC_CONFIG_FILES([Makefile lib/tests/config.sh])
#
#    lib/tests/config.sh.in contains
#
#       incendiary_sophist_prefix=@incendiary_sophist_prefix@
#       incendiary_sophist_libdir=@incendiary_sophist_libdir@
#       incendiary_sophist_riggingdir=@incendiary_sophist_riggingdir@
#

# see /usr/include/sysexits.h
readonly EX_OK=0
readonly EX_FAIL=1
readonly EX_USAGE=64		# command line usage error
readonly EX_DATAERR=65		# data format error
readonly EX_NOINPUT=66		# cannot open input
readonly EX_NOUSER=67		# addressee unknown (no such user)
readonly EX_NOHOST=68		# host name unknown
readonly EX_UNAVAILABLE=69	# service unavailable
readonly EX_SOFTWARE=70		# internal software error
readonly EX_OSERR=71		# system error (e.g., can't fork)
readonly EX_OSFILE=72		# critical OS file missing
readonly EX_CANTCREAT=73	# can't create (user) output file
readonly EX_IOERR=74		# input/output error
readonly EX_TEMPFAIL=75		# temp failure; user is invited to retry
readonly EX_PROTOCOL=76		# remote error in protocol
readonly EX_NOPERM=77		# permission denied
readonly EX_CONFIG=78		# configuration error
readonly EX_CANTREMOVE=79	# can't remove (user) output file
readonly EX_NOGROUP=80          # no such group
# ours
readonly EX_TESTING=111         # the application exited early, from within a test mode (see cli::exits::constants::TESTING)
readonly EX_UNIMPLEMENTED=112   # the function is unimplemented (see cli::exits:constants::UNIMPLEMENTED)
readonly EX_UNCOMMITTED=113	# there are uncommitted changes
readonly EX_NOGOLDEN=114	# the gold file is missing (validate & copy *.out to*.gold)
readonly EX_NOOUTPUT=115	# the out file is missing (why?)
readonly EX_NOCONFIG=116	# the config.sh or incendiary-sophist boilerplate couldn't be sourced
readonly EX_NORIGGING=117	# the rigging.sh of the local test suite could not be sourced
readonly EX_NOCANON=118		# the canonicalization procedure has failed
readonly EX_NOCWD=119		# the cwd is bad; e.g. cd ${0%/*}/.. failed
# bash (posix)
readonly EX_NOCOMMAND=127	# command not found; i.e. a shell error

readonly -a EX_ENUM=( \
    0=EX_OK \
    1=EX_FAIL \
    64=EX_USAGE \
    65=EX_DATAERR \
    66=EX_NOINPUT \
    67=EX_NOUSER \
    68=EX_NOHOST \
    69=EX_UNAVAILABLE \
    70=EX_SOFTWARE \
    71=EX_OSERR \
    72=EX_OSFILE \
    73=EX_CANTCREAT \
    74=EX_IOERR \
    75=EX_TEMPFAIL \
    76=EX_PROTOCOL \
    77=EX_NOPERM \
    78=EX_CONFIG \
    79=EX_CANTREMOVE \
    80=EX_NOGROUP \
    111=EX_TESTING \
    112=EX_UNIMPLEMENTED \
    113=EX_UNCOMMITTED \
    114=EX_NOGOLDEN \
    115=EX_NOOUTPUT \
    116=EX_NOCONFIG \
    117=EX_NORIGGING \
    118=EX_NOCANON \
    119=EX_NOCWD \
    120=EX_WONTBUILD \
    127=EX_NOCOMMAND \
)

readonly -a EX_EXPLAIN=( \
    0="OK" \
    1="FAIL" \
    64="command line usage error" \
    65="data format error" \
    66="cannot open input" \
    67="addressee unknown (no such user)" \
    68="host name unknown" \
    69="service unavailable" \
    70="internal software error" \
    71="system error (e.g., can't fork)" \
    72="critical OS file missing" \
    73="can't create the output file" \
    74="input/output error" \
    75="temporary failure; you (luser) are is invited to retry" \
    76="remote error in protocol" \
    77="permission denied" \
    78="application configuration error" \
    79="can't remove the file (or directory)" \
    80="no such group" \
    111="test mode, took an early exit" \
    112="unimplemented function" \
    113="there are uncommitted changes" \
    114="the *.gold file is missing" \
    115="the *.out file is missing" \
    116="could not load the incendiary-sophist configuration" \
    117="could not load the local test suite rigging.sh" \
    118="canonicalization procedure has failed" \
    119="the current working directory is bad (i.e. cd .. failed)" \
    120="cannot or will not build this configuration" \
    127="command not found" \
)

function ex_explain() {
    case $1 in
    ( $EX_OK) echo OK;;
    ( $EX_FAIL ) echo FAIL;;
    ( $EX_USAGE ) echo "command line usage error";;
    ( $EX_DATAERR) echo "data format error";;
    ( $EX_NOINPUT ) echo "cannot open input";;
    ( $EX_NOUSER ) echo "addressee unknown";;
    ( $EX_NOHOST ) echo "host name unknown";;
    ( $EX_UNAVAILABLE ) echo "service unavailable";;
    ( $EX_SOFTWARE ) echo "internal software error";;
    ( $EX_OSERR ) echo "system error (e.g., can't fork)";;
    ( $EX_OSFILE ) echo "critical OS file missing";;
    ( $EX_CANTCREAT ) echo "can't create (user) output file";;
    ( $EX_IOERR ) echo "input/output error";;
    ( $EX_TEMPFAIL ) echo "temp failure; user is invited to retry";;
    ( $EX_PROTOCOL ) echo "remote error in protocol";;
    ( $EX_NOPERM ) echo "permission denied";;
    ( $EX_CONFIG ) echo "configuration error";;
    ( $EX_CANTREMOVE ) echo "can't remove (user) output file";;
    ( $EX_NOGROUP ) echo "no such group";;
    ( $EX_TESTING ) echo "test mode, took an early exit";;
    ( $EX_UNIMPLEMENTED ) echo "unimplemented function";;
    ( $EX_UNCOMMITTED ) echo "there are uncommitted changes";;
    ( $EX_NOGOLDEN ) echo "the *.gold file is missing";;
    ( $EX_NOOUTPUT ) echo "the *.out file is missing";;
    ( $EX_NOCOMMAND ) echo "command not found";;
    ( $EX_NOCONFIG ) echo "could not load the incendiary-sophist test configuration";;
    ( $EX_NORIGGING ) echo "could not load the local test suite rigging.sh";;
    ( $EX_NOCANON ) echo "canonicalization procedure has failed";;
    ( $EX_NOCWD ) echo "the current working directory is bad (i.e. cd .. failed)";;
    ( $EX_WONTBUILD ) echo "cannot or will not build this configuration";;
    ( * ) echo "exit $1 no reason defined";;
    esac
}
