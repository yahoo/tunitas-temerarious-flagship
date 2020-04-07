# This is a GNU -*- Makefile -*-
# Copyright 2019, Oath Inc. Licensed under the terms of the Apache-2.0 license.
# See the LICENSE file in https://github.com/yahoo/tunitas-basics/blob/master/LICENSE for terms.
#
# moved to .../am/build.am (suffix matches directory)
# deprecating .../am/build.mk (suffix DOES NOT match directory)
# 
$(info included from $(word $(shell expr $(words $(MAKEFILE_LIST)) - 1), $(MAKEFILE_LIST)))
$(warning temerarious flagship .../am/build.mk is deprecated in favor of .../am/build.am (suffix matches directory))
include $(temerarious_flagship_datadir)/am/build.am
