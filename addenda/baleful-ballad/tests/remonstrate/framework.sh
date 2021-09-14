# source ${0%/*}/framework.sh || exit 1
f=${0##*/}
b=${f%.test}
name=$b
export PATH="${0%/*}/../../bin:$PATH"

function failure() {
    echo FAIL
    exit 1
}

# TODO - find a better way to guess where the std modules might be
# guess?
: ${module_std:=$(cd ${0%/*}/../../../module-std || cd /build/scold && pwd)}
: ${module_std_modules:=$module_std/modules}

echo "module_std=${module_std:-unset}"
echo "module_std_modules=${module_std:-unset}/modules"
echo "${0##*/}: note, if \$module_std is unset then std.uint64_t will not be an 'external' module"
if [ -n "$module_std" ]; then
    if ! [ -d "$module_std" ] ; then
        echo "${0##*/}: warning, \$module_std is set but the directory does not exist" 1>&2
    else
        specimen="$module_std/modules/std.uint64_t"
        if ! [ -f "$specimen" ] ; then
            {
                echo "${0##*/}: warning, \$module_std is set but the directory is not reasonable"
                echo "${0##*/}: warning, for example $specimen fails to exist"
            } 1>&2
        else
            echo "${0##*/}: note, \$module_std is set and the directory exists as $module_std"
        fi
    fi
fi

trap failure ERR
