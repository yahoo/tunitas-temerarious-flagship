# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
hypogeal_twilight_basic_mk_included = 1

# Reminder
#   https://www.gnu.org/software/automake/manual/html_node/Include.html
# automake only works on two sorts of 'include' statements
#
#  include $(srcdir)/file
#  include $(top_srcdir)/file
#
# In particular, it does not work against includes referencing out-of-tree locations.
#
# Separately, automake sports a second level of substitution with %-variables
#
#     %D% = %reldir% = the directory relative to the Makefile.am
#     %C% = %canon_reldir% is that path Canonocalized (as defined)
#
# But this is GNU make land herein.
#

#
# some keywords, reserved words
#
__basic_empty =
ok = $(__basic_empty)
continue = $(__basic_empty)
never_mind = $(__basic_empty)
nothing = $(__basic_empty)

at = @
space = $(__basic_empty) $(__basic_empty)

#
# The Long and the Sort of the Host Name
#
# [[FIXTHIS]] ... only call this if it is needed (and used?)  Where is this used?
#
# HOSTNAME = mydevbox                       1 word
# HOSTNAME = mydevbox.devops.example.org    4 words
#
# DO NOT call `hostname --fqdn` within the build system ... it takes forever to time out
HOST_NAME_FQDN = $(HOSTNAME)$(warning hostname --fqdn does will work in mock builds)
HOST_NAME_SHORT = $(word 1, $(subst .,$0 $0,$(HOSTNAME)))
HOST_NAME       = $(HOSTNAME)
