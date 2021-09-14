# The test case driver because this test case is a complete project.

default:
all:
check:
install:
clean:
distclean:
realclean:

default: all
check: all
install: check
realclean: distclean

srcdir = ../..

# We want to find *this* hypogeal-twilight, not some other one
HYPOGEAL_TWILIGHT := $(shell cd $(srcdir) && pwd)
$(if $(HYPOGEAL_TWILIGHT),$(__ok),$(error HYPOGEAL_TWILIGHT is still unset))

CONFIGURE_OPTIONS = \
  --disable-mock-build \
  --with-hypogeal-twilight=$(HYPOGEAL_TWILIGHT) \
  --without-incendiary-sophist \
  --without-vernacular-doggerel \
  ${end}

all:
	HYPOGEAL_TWILIGHT=$(HYPOGEAL_TWILIGHT) ./buildconf
	./configure $(CONFIGURE_OPTIONS)
	make -f Makefile

check:
	make -f Makefile check

distclean clean:
	test -f Makefile && make -f Makefile $@
