# usage: source ${0%/*}/../library/rigging.sh || exit 255
function set_PATH() {
    local top=$(cd ${0%/*}/../../.. && pwd)
    # circa v0.41 and here in development on v0.42 ... for a while.
    local old="${top?}/ac"
    # in v0.42 and hence
    local new="${top?}/libexec"
    export PATH="${new?}:${old?}:$PATH"
}
function set_0dir() {
    cd ${0%/*} || exit 255
}
declare outdir
function make_outdir() {
    local basename=${0##*/}
    outdir="o.${basename%.test}.d"
    mkdir -p ${outdir?} || exit 255
}
function run() {
    # just run it
    echo "running: $@"
    "$@"
    local e=$?
    echo "done: $1 exit $e"
    return $e
}
function good() {
    # expect this to succeed
    run "$@"
}
function fail() {
    # expect this to fail
    if run "$@" ; then
        false;
    else
        true
    fi
}
function either() {
    # expect this to succeed or fail (but only exit 0 or 1, nothing weird)
    run "$@"
    local e=$?
    if ((0 == e || 1 == e)); then
        true
    else
        false
    fi
}

declare autotools_exe=autotools-local-preconfigure
declare boilerplate_exe=boilerplate-simplistic-configure-for-untooled-packages
declare establish_exe=establish-config-settings
declare generate_exe=generate-autotools-Config-module-from-config-header
declare insert_exe=insert-config-settings-in-configure

set_PATH
set_0dir
