# source ${0%/*}/framework.sh || exit 1
d=${0%/*};d=${d##*/}
f=${0##*/}
b=${f%.test}
name=$b
__topdir="${0%/*}/../../.."
export PATH="${__topdir?}/check/bin:${__topdir?}/bin:$PATH"

