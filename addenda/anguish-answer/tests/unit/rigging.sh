# source ${0%/*}/framework.sh || exit 70
f=${0##*/}
b=${f%.test}
name=$b
path=/${name?}
__topdir="${0%/*}/../.."
export PATH="${__topdir?}/check/bin:$PATH"
