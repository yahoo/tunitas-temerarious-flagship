# within a test driving -*- shell-script -*-
echo "${0##*/}: warning, compare_output.sh (singular) is deprecated, instead use compare_outputs.sh (plural)" 1>&2
source ${incendiary_sophist_riggingdir:-$prefix/lib/rigging}/compare_outputs.sh || exit 70
