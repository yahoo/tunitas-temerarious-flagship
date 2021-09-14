# included via automake, really really really is a GNU -*- Makefile -*- fragment.
#
# WATCHOUT - if this fragement is included by automake then the macro will get stripped.
# automake does not understand GNU Make (make-4) multi-line macros.
#
# Usage:
#
#    include $(empty)@hypogeal_twilight_datadir@/mk/help2man.mk
#
# Witness:
#
#   ...etc...
#   define HELP2MAN-FLOW = <----------------------------- FIRST ERROR!
#   endef
#   all-local:: all-man1_MANS
#   ...etc...
#   HELP2MAN_OPTIONS = --libtool --no-info
#   tmp = "$(@D)/t99.$$$$.$(@F)~" ; \ <------------------ SECOND ERROR!
#     mkdir -p $(@D) && \
#     help2man $(HELP2MAN_OPTIONS) $< > "$$tmp" && \
#     chmod a-w "$$tmp" && \
#     mv -f "$$tmp" $@
#

HELP2MAN_OPTIONS = --libtool --no-info
define HELP2MAN-FLOW =
  tmp="$(@D)/t99.$$$$.$(@F)~" ; \
  mkdir -p $(@D) && \
  help2man $(HELP2MAN_OPTIONS) $< > "$$tmp" && \
  chmod a-w "$$tmp" && \
  mv -f "$$tmp" $@
endef
$(if $(HELP2MAN-FLOW),$(ok),$(error HELP2MAN-FLOW is empty))
