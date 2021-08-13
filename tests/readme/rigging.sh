# source ${0%/*}/../rigging.sh || exit ${EX_NORIGGING:-116
__topdir=$(realpath ${0%/*}/../..)
export PATH="${__topdir?}/bin:$PATH"
directory=${0%/*}
