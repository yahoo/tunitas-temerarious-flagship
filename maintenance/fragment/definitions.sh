#
# within the .../maintenance/v (a.k.a. .../maintenance/v2) script of each repository
#
# Notice:
#
#   You only need any of this machinery if you are in a di
#   You don't need any of this machinery if everything is "installed"
#
# Usage:
#
#     #!/bin/bash -p
#     ...license boilerplate...
#     : ${with_temerarious_flagship:=${with_worktrees?}/temerarious-flagship/v2.${TEMERARIOUS:-${TUNITAS:-${NEARBY:-${TAG?}}}}} &&
#     true || exit 70
#
#     
#     with_build=${with_build?} \
#     with_nearby=${with_nearby:-${with_build?}/scold} \
#     with_hypogeal_twilight=${with_hypogeal_twilight?} \
#     with_module_langu=${with_module_langu:-${with_worktrees?}/langu/v0.${SCOLD:-${NEARBY:-${TAG?}}}} \
#     with_module_nonstd=${with_module_nonstd:-${with_worktrees?}/nonstd/v2.${SCOLD:-${NEARBY:-${TAG?}}}} \
#     with_module_sys=${with_module_sys:-${with_worktrees?}/sys/v2.${SCOLD:-${NEARBY:-${TAG?}}}} \
#     \
#     ...you get the idea ... \
#     with_module_cli_core=${with_module_cli_core?} \
#     with_module_cli=${with_module_cli?} \
#     with_module_options=${with_module_options?} \
#     \
#     with_module_rigging_core=${with_module_rigging_core?} \
#     with_module_rigging=${with_module_rigging?} \
#     with_nonstd_cppunit=${with_nonstd_cppunit:-no} \
#     with_module_cppunit=${with_module_cppunit:-no} \
#     \
#     with_module_c=${with_module_c:-no} \
#     with_module_format=${with_module_format:-no} \
#     with_module_ip=${with_module_ip:-no} \
#     with_module_posix=${with_module_posix:-no} \
#     with_module_slurp=${with_module_slurp:-no} \
#     with_module_std=${with_module_std:-no} \
#     with_module_string=${with_module_string:-no} \
#     \
#     with_microhttpd__=${with_microhttpd__:-${with_worktrees?}/microhttpd++/v0.${USEFUL:-${NEARBY:-${TAG?}}}} \
#     with_microhttpd=${with_microhttpd:-${with_worktrees?}/microhttpd++/v0.${USEFUL:-${HEARBY:-${TAG?}}}} \
#     \
#     with_temerarious_flagship=${with_temerarious_flagship:-${with_worktrees?}/temerarious-flagship/v2.${TEMERARIOUS:-${TUNITAS:-${NEARBY:-${TAG?}}}}} \
#     \
#     exec ${0%/*}/nearby
#
: ${with_build:=/build}
: ${with_worktrees:=${with_build?}/worktrees}
: ${with_nearby=${with_build?}/scold}
: ${TAG:=STABLE}


# some early aliasing
: ${with_hypogeal_twilight:=${with_worktrees?}/hypogeal-twilight/v0.${HYPOGEAL:-${SCOLD:-${NEARBY:-${TAG?}}}}}
source ${with_hypogeal_twilight?}/maintenance/fragment.module-cli-core.sh || exit ${EX_SOFTWARE:-70}
source ${with_hypogeal_twilight?}/maintenance/fragment.module-cli-shell.sh || exit ${EX_SOFTWARE:-70}
source ${with_hypogeal_twilight?}/maintenance/fragment.module-rigging-core.sh || exit ${EX_SOFTWARE:-70}

: ${with_nonstd_boost:=no}
: ${with_nonstd_gcc:=no}
: ${with_nonstd_cppunit:=no}

SCOLD_UNIVERSE=( \
    hypogeal-flagship/v0/HYPOGEAL \
    module-ares \
    module-archive \
    module-boringssl \
    module-cbor \
    module-cli-core/v2 \
    module-cli-shell/v2 \
    module-langu \
    module-json \
    module-html \
    module-level \
    module-nonstd/v2 \
    module-mysql \
    module-openssl \
    module-pgsql \
    module-ramcloud \
    module-sqlite \
    module-sys/v2 \
    module-rabinpoly \
    module-rigging-app \
    module-rigging-core/v2 \
    module-xml \
    \
    module-c/no \
    module-cppunit/no \
    module-format/no \
    module-ip/no \
    module-posix/no \
    module-slurp/no \
    module-std/no \
    module-string/no \
    module-uuid/no \
)
USEFUL_UNIVERSE=( \
  apache-httpd-api \
  apache-httpd-mod \
  microhttpd++ \
  nomlons \
)
TUNITAS_UNIVERSE=( \
    temerarious-flagship/v2/TEMERARIOUS \
    basics/v2/BASICS \
    apanolio \
    bogess \
    butano/v1 \
    calera \
    denniston \
    gazos \
    grabtown \
    honsinger \
    keyson \
    kingston \
    lobitos \
    montara \
    nuff \
    pescadero \
    pilaritos \
    pomponio \
    portola \
    purissima \
    rheem \
    rockaway \
    scarpet \
    walker \
)
function extract_long_directory_name() {
    local split=($(echo -n $1 | sed -e 's,/, ,g'))
    local candidate=${split[0]}
    echo -n ${candidate#module-} | tr -c '[\-a-zA-Z0-9_+]' _ # + (plus) is allowed for microhttpd++ and - (dash) is allowed for rigging-app etc.
}
function extract_short_directory_name() {
    local long=$(extract_long_directory_name $1)
    echo -n ${long#module-}
}
function extract_is_no() {
    local split=($(echo -n $1 | sed -e 's,/, ,g'))
    if ((1 < ${#split[@]})); then
        if [[ no == ${split[1]} ]] ; then
           return 0 # is "no"
        fi
    fi
    return 1 # is not "no"
}
function extract_version() {
    local split=($(echo -n $1 | sed -e 's,/, ,g'))
    if ((1 < ${#split[@]})); then
        echo -n ${split[1]}
    else
        echo -n v0
    fi
}
function extract_with() {
    local split=($(echo -n $1 | sed -e 's,/, ,g'))
    local candidate=${split[0]}
    echo -n with_${candidate} | tr -c '[a-zA-Z0-9_]' _ # + is not allowed for with_microhttpd__
}
function extract_VARIABLE() {
    local split=($(echo -n $1 | sed -e 's,/, ,g'))
    if ((2 < ${#split[@]})); then
        echo -n ${split[2]}
    else
        local short=$(extract_short_directory_name $1)
        echo -n ${short?} | tr -d + | tr -c '[a-zA-Z0-9_]' _ | tr a-z A-Z # + is not allowed for MICROHTTPD (no plus or underscore)
    fi
}
function load_series() {
    local cluster=$1; shift
    local SERIES=$1; shift
    for spec in $@ ; do
        local long_project=$(extract_long_directory_name $spec)
        local short_project=$(extract_short_directory_name $spec)
        with=$(extract_with $spec)
        if extract_is_no $spec ; then
            eval ": \${$with:=no}"
        else
            version=$(extract_version $spec)
            VARIABLE=$(extract_VARIABLE $spec)
            if [[ -d ${with_worktrees?}/$short_project ]] ; then
                eval ": \${$with:=\${with_worktrees?}/$short_project/$version.\${$VARIABLE:-\${$SERIES:-\${NEARBY:-\${TAG?}}}}}"
            elif [[ -d $cluster/$long_project ]] ; then
                eval ": \${$with:=$cluster/$long_project}"
            elif [[ -d $cluster/$short_project ]] ; then
                eval ": \${$with:=$cluster/$short_project}"
            else
                eval ": \${$with:=no}"
            fi
        fi
        eval echo "DEBUG $with=\$$with"
    done
}
load_series /build/scold SCOLD ${SCOLD_UNIVERSE[@]}
load_series /build/useful USEFUL ${USEFUL_UNIVERSE[@]}
load_series /build/tunitas TUNITAS ${TUNITAS_UNIVERSE[@]}

# some aliased behaviors
: ${with_module_leveldb:=${with_module_level?}}
: ${with_microhttpd:=${with_microhttpd__?}}
: ${with_tunitas_basics:=${with_basics?}}
: ${with_tunitas_butano:=${with_butano?}}
: ${with_tunitas_lobitos:=${with_lobitos?}}
set +xv
