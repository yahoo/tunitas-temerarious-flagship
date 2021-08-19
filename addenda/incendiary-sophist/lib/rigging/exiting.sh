# within a test driving -*- shell-script -*-
# source ${incendiary_sophist_riggingdir:-$prefix/lib/rigging}/exiting.sh || exit 70
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

#
# exiting [ expected [ actual ] ]
#
# Usage:
#
#    exiting             expected=0, captures $? on its own
#    exiting 0           expected=0, is manifest; captures $? on its own
#    exiting $ex $ac     expected and actual are manifest
#
function exiting() {
    local actual=$?
    local expected=${1:-0}; shift
    if (($#)); then
        actual=${1-0}; shift
    fi
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
    exit $ecode
}
