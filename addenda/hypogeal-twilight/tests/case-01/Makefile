# An Example Makefile

default:

# created by ./configure
include mk/configured.mk
distclean: distclean-mk/configured.mk
distclean-mk/configured.mk:
	rm -f mk/configured.mk
	rm -f mk/extracted.mk
	rmdir mk || : never mind

# testing these.  any problems here?
include $(hypogeal_twilight_datarootdir)/am/EXTERNAL-PATHS.mk
include $(hypogeal_twilight_datarootdir)/am/compile.mk
include $(hypogeal_twilight_datarootdir)/am/install.mk
include $(hypogeal_twilight_datarootdir)/am/distclean.mk

default:
all:
check:
install:
clean:
distclean:
realclean:

# indeed, this doesn't do anything, it doesn't build anything
all:

check: all
default: all
realclean: distclean
install: check
