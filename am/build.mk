# A GNU_make-included -*- Makefile -*- fragment.
included_temerarious_flagship_am_build_mk_included := 1
ifeq "" "$(included_temerarious_flagship_am_build_am)"
$(warning instead include $(temerarious_flagship_datadir)/am/build.am - the 'am' directory, the 'am' suffix)
include $(temerarious_flagship_datadir)/am/build.am
endif
