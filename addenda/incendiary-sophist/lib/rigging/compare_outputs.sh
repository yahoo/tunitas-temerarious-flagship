# within a test driving -*- shell-script -*-
# source ${incendiary_sophist_riggingdir:-$prefix/lib/rigging}/compare_output.sh || exit 70
#
# Notation: (see sysexits.sh)
#
#   114 ... EX_NOGOLDEN ... the test golden file does not exist
#   115 ... EX_NOOUTPUT ... the test output file does not exist
#   118 ... EX_NOCANON .... canonicalization procedure has failed
#
# Usage
#
#    <optional>
#      function canonicalize_output_file() { local input=$1; local output=$2; ... }
#    </optional>
#
#    source ${incendiary_sophist_riggingdir:-$prefix/lib/rigging}/compare_output.sh || exit 70
#    trap cleanup EXIT
#    trap failing ERR
#    ... the caller must test something & call 'successful' to end
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

function run() {
    echo "run $@"
    "$@"
    e=$?
    local explanation
    if type ex_explain >/dev/null ; then
        explanation=" [$(ex_explain $e)]"
    fi
    echo "$1 exit $e${explanation} (pwd=$(pwd))"
    return $e
}
function cleanup() {
    : echo clean up something...
}

function compare() {
    local raw_golden=$1; shift
    local raw_output=$1; shift
    if false && : pure cmp -s ; then
        cmp -s $raws_output $raw_golden
        return $?
    else
        cooked_golden="${raw_golden%/*}/t99.${raw_golden##*/}.cooked"
        cooked_output="${raw_output%/*}/t99.${raw_output##*/}.cooked"
        canonicalize_output_file "$raw_output" "$cooked_output" &&
        canonicalize_output_file "$raw_golden" "$cooked_golden" &&
        cmp -s "$cooked_output" "$cooked_golden"
        return $?
    fi
}

# Expectation:
#
#    function canonicalize_output_file() {
#      local input=$1; shift
#      local output=$1; shift
#      ... create $output from $input             (do not edit $input in place)
#    }
#    canonicalize_output_file "$input" "$output"
#
function __canonicalize_output_file() {
    local input=$1; shift
    local output=$1; shift
    if [ ! -f "$input" ] ; then
        echo "error: missing file $input" 1>&2
        return 1
    fi
    if type -p canonicalize_output_file >/dev/null ; then
        #
        # If the project supplies its own canonicalize_output_file function then use that.
        #
        rm -f "$output" &&
            canonicalize_output_file "$input" "$output"
        # $? flows down
    else
        # WATCHOUT - as documented in perlrun(1).
        # <quote>If a file named by an argument cannot be opened for some reason,
        #        Perl warns you about it, and moves on to the next file.</quote>
        perl -p -e '
if (m/^usage:/ || m/: version/ || m/^lt-/) {
      # get rid of the known libtool honorific at the beginning of the executable name
      #   ... but it may appear elsewhere too, so this is necessary but not sufficient.
      s/lt-// ;
}
# get rid of the actual version number in output and golden files
s/version v\d+\.\d+\.\d+/version vMAJOR.MINOR.PATCH/g;
' < "$input" > "$output"
        # $? flows down
    fi
    if [[ 0 != $? ]] ; then
        echo "${0##*/}: error, canonicalization has failed"
        exit ${EX_NOCANON:-118}
    elif [[ ! -f "$output" ]] ; then
        echo "${0##*/}: error, the project-defined canonicalize_output_file function is broken"
        echo "${0##*/}: error, given input $input"
        echo "${0##*/}: error, DID NOT create output $output"
        exit ${EX_NOCANON:-118}
    fi 1>&2
}

function difference() {
    local raw_golden=$1; shift
    if [ ! -f ${raw_golden?} ] ; then
        exit ${EX_NOGOLDEN:-114}
    fi
    local raw_output=$1; shift
    if [ ! -f ${raw_output?} ] ; then
        exit ${EX_NOOUTPUT:-115}
    fi
    cooked_golden="$(dirname "${raw_golden}")/t99.${raw_golden##*/}.cooked"
    cooked_output="$(dirname "${raw_output}")/t99.${raw_output##*/}.cooked"
    __canonicalize_output_file "$raw_output" "$cooked_output" &&
    __canonicalize_output_file "$raw_golden" "$cooked_golden" && {
        # always: golden (oldies) first
        #         output (newbies) second
        diff "$cooked_golden" "$cooked_output"
    }
    return $?
}

#
# Usage #1. as a 'trap' target, with no arguments
#
#   trap failing ERR
#
# Usage #2. when called explicitly, with arguments
#
#   failing $?
#   failing $? ${EX_OK:-0}
#
function failing() {
    old_ecode=$?
    trap '' ERR
    cleanup;
    if ((0 == $#)); then
        #
        # Usage #1 (no arguments)
        # so it is a 'trap' target with $old_ecode.
        #
        local explanation
        if type ex_explain >/dev/null ; then
            explanation=" [$(ex_explain $old_ecode)]"
        else
            explanation=""
        fi
        echo "FAILING exit $old_ecode$explanation ... see ${output:-[output is unset]}"
        echo "so promote: cp ${output:-[output is unset]} ${golden:-[golden is unset]}"
        echo "or promote: cp ${output##*/} ${golden##*/}"
        exit ${EX_FAIL:-1};
    else
        #
        # Usage #2 (one or two arguments are examined)
        # so it was called explicitly with those arguments.
        #
        local ecode
        local status
        local explanation
        local actual=${1:-${old_ecode:-0}}; shift
        local expected=${1:-0}; shift
        if ((actual == expected)); then
            status=OK
            ecode=0
            explanation=" (as expected)"
        else
            status=FAIL
            ecode=1
            local actual_explanation='?'
            local expected_explanation='?'
            if type ex_explain >/dev/null ; then
                actual_explanation=" [$(ex_explain $actual)]"
                expected_explanation=" [$(ex_explain $expected)]"
            fi
            explanation=" (exit: actual $actual${actual_explanation}, but expected $expected${expected_explanation})"
        fi
        echo "$status exiting $actual${explanation}"
        exit ${ecode:-0}
    fi
}

# a callable declaration
function failure() {
    trap '' ERR
    echo "FAILING (as described)"
    if ! compare $golden $output; then
        (
            set -o pipefail
            ls -ld $golden $output
            ( diff $golden $output | head ) || echo ...more...
        )
    fi
    echo "so promote: cp $output $golden"
    echo "or promote: cp ${output##*/} ${golden##*/}"
    exit ${EX_FAIL:-1};
}

function successful() {
    cleanup;
    trap '' EXIT;
    echo OK;
    exit ${EX_OK:-0};
}
