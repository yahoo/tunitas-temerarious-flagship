# A GNU_make-included -*- Makefile -*- fragment.
#
# moved to .../am/build.am (suffix matches directory)
# deprecating .../am/build.mk (suffix DOES NOT match directory)
#
included_temerarious_flagship_am_build_mk_included := 1
ifeq "" "$(included_temerarious_flagship_am_build_am)"
$(warning temerarious flagship .../am/build.mk is deprecated in favor of .../am/build.am (suffix matches directory))
$(warning instead include $(temerarious_flagship_datadir)/am/build.am - the 'am' directory, the 'am' suffix)
include $(temerarious_flagship_datadir)/am/build.am
endif
