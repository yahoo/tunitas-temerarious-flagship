# This is a -*- Makefile -*- containing GNU make constructs.
ifeq "" "$($(hypogeal_twilight_datadir)/mk/autotools/autoconf.mk)"
$(hypogeal_twilight_datadir)/mk/autotools/autoconf.mk := 1

# chatter for the hypogeal-twilight world of the Generated Config (GC)
#
# Usage:
#
#    something-something: dark side
#      $(V_HTGC) generate
#      $(V_HTGC) validate
#      $(V_HTGC) test -e $@
#
V_HTGC = $(__v_HTGC_$(V))
__v_HTGC_ = $(__v_HTGC_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "0123456789ab
__v_HTGC_0 = @echo "  HGTW-GC  ($@)";
__v_HTGC_1 = 
htGC = $(hypogeal_twilight_libexecdir)/generate-autotools-Config-module-from-config-header

#
# Usage:
#
#   clean-local:
#       $(V_HGTRM) rm -f this
#       $(V_HGTRM) rm -f that
#
V_HTRM = $(__v_HTRM_$(V))
__v_HTRM_ = $(__v_HTRM_$(AM_DEFAULT_VERBOSITY))
# ........ = @echo "0123456789ab
__v_HTRM_0 = @echo "  HGTW-RM  ($@)";
__v_HTRM_1 = 

endif
