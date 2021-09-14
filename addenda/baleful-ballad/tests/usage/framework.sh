# source ${0%/*}/framework.sh || exit 1
f=${0##*/}
b=${f%.test}
name=$b
export PATH="${0%/*}/../../bin:$PATH"
