AC_INIT(example, 0.0.0, devops@example.org)

dnl autotools-local-preconfigure peeks in to find this declaration
AC_CONFIG_MACRO_DIR([m9])

dnl autoheader will complain that this is missing
AC_CONFIG_HEADER([config.h])

dnl automake looks for this
AM_INIT_AUTOMAKE
AC_CONFIG_FILES([Makefile])

dnl until the correct macro library is enabled, these remain unexpanded
APPLE
BANANA
CHERRY
DOG

APPLE_NEEDS
