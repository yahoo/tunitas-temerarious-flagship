# This GNU -*- Makefile -*- fragment may be included directly by automake
# Copyright 2018, 2019, Oath Inc.; Copyright 2020, Verizon Media
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-temerarious-flagship/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/build/temerarious-flagship/tree/LICENSE
#
# moved to .../am/build.am (suffix matches directory)
# deprecating .../am/build.mk (suffix DOES NOT match directory)
# 
$(info included from $(word $(shell expr $(words $(MAKEFILE_LIST)) - 1), $(MAKEFILE_LIST)))
$(warning temerarious flagship .../am/build.mk is deprecated in favor of .../am/build.am (suffix matches directory))
include $(temerarious_flagship_datadir)/am/build.am
