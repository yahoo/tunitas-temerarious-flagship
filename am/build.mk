# A GNU_make-included -*- Makefile -*- fragment.
#
# moved to .../am/build.am (suffix matches directory)
# deprecating .../am/build.mk (suffix DOES NOT match directory)
#
ifeq "" "$(included_temerarious_flagship_am_build_am)"
included_temerarious_flagship_am_build_mk_included := 1
$(warning temerarious flagship .../am/build.mk is deprecated in favor of .../am/build.am (where the 'am' suffix matches the 'am' directory))
$(warning instead you should 'include $(temerarious_flagship_datadir)/am/build.am' with the 'am' directory, the 'am' suffix)
include $(temerarious_flagship_datadir)/am/build.am
endif
