# usage: source ${0%/*}/library/rigging.sh || exit 255
declare HYPOGEAL_TWILIGHT=$(cd "${0%/*}/../.."; pwd)
declare NAME=$(basename "$0" .test)
function set_0dir() {
    # this gets places us in the diretory of the *.test script
    # e.g. given .../tests/configure/usage.t
    #      PWD = .../tests/configure
    cd ${0%/*} || exit 255
}
function failing() {
    local e=$?; shift
    echo "Failing (exit $e)"
    exit $e
}
function run() {
    echo "running: $@"
    "$@"
    local e=$?
    echo "done: ${1##*/} exit $e"
    return $e
}
declare -a TESTIFY_FILES=(buildconf configure.ac Makefile.am okay.cpp)
function testify() {
    # the caller (e.g. ../driver) is responsible for any *.log and *.state files
    local outdir="o.${NAME?}.d"
    (
        # WATCHOUT - neither 'set -e' nor 'trap failing ERR' work within a function
        #
        # WATCHOUT - we want to force the hypogeal-twilight in this tree (we're testing it)
        #            so we have to tell both buildconf and configure about that.
        #
        # reminder - the test for --without-hypogeal-twilight is therefore obviated.
        #
        set_0dir &&
        mkdir -p "${outdir?}" &&
        cd "./${outdir?}" &&
        run ln -f -s "${TESTIFY_FILES[@]/#/../library/}" . &&
        HYPOGEAL_TWILIGHT=${HYPOGEAL_TWILIGHT?} run ./buildconf &&
        run ./configure --with-hypogeal-twilight="${HYPOGEAL_TWILIGHT?}" "$@" &&
        : NO make -f Makefile &&
        echo OK
    )
}
