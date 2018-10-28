# A GNU_make-included -*- Makefile -*- fragment.
#
# moved to .../am/build.am (suffix matches directory)
# deprecating .../mk/build.mk (suffix matches directory BUT the use case is with automake includes)
#
ifeq "" "$(included_temerarious_flagship_am_build_am)"
included_temerarious_flagship_mk_build_mk_included := 1
$(warning temerarious flagship .../mk/build.mk is deprecated in favor of .../am/build.am (where the automake 'am' suffix matches the 'am' directory))
$(warning instead you should 'include $(temerarious_flagship_datadir)/am/build.am' where the 'am' directory, the 'am' suffix)
include $(temerarious_flagship_datadir)/am/build.am
endif
