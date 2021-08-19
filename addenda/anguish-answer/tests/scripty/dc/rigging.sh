# -*- sh -*- expects to be sourced, not exec'ed
# For terms and provenance see the LICENSE file at the top of this repository.

#
# usage
#    source ${0%/*}/rigging.sh || exit 70
#    (
#      ${exe?} ...arguments...
#    ) >& $output &&
#    diff $golden $output &&
#    successful
#

f=${0##*/}
b=${f%.test}
name=$b

# NOT exe=${PWD##*/}
# PWD is .../inoculate-fractious-physiocrat
exe=${0%/*}
exe=${exe##*/}

# we want a full path here so that testers can chdir and still get the same physiocrat executable
topdir=$(dirname $(dirname $(dirname $(cd ${0%/*}; pwd))))
datadir=$topdir/sql
guess_production_datadir="--datadir=/[/a-zA-Z0-9]*/share/scold"

bindir=${topdir?}/bin
libdir=${topdir?}/lib

export PATH="${topdir}/bin:${topdir}/libexec/scold:$PATH"

# output & golden for the test
# WATCHOUT for the ./ as command line vs Makefile.am invocations differ!
dedot0=${0#./}
output=${dedot0%.test}.out
golden=${dedot0%.test}.gold

source ${topdir?}/tests/config.sh &&
source ${incendiary_sophist_riggingdir?}/sysexits.sh &&
source ${incendiary_sophist_riggingdir?}/compare_outputs.sh ||
exit 70

# You may define your own function canonicalize_output_file
function canonicalize_output_file() {
    local input=$1; shift
    local output=$1; shift
    perl -n -e '
# get rid of the actual version number in output and golden files
s/version v\d+\.\d+\.\d+/version vMAJOR.MINOR.PATCH/g;
s/\blt-dc\b/dc/g;
# remove the ./ at the beginning of path names (it comes and goes)
s,"\./,",g;
# remove any extraneous remaining debug statements
next if m/DEBUG/;
# explicit print ... because of -n
print;
' "$input" > "$output" || return 99
}

trap cleanup EXIT
trap failing ERR
# ... the caller must test something & call 'successful' to end
