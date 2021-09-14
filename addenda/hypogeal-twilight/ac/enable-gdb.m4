dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_GDB                    (no macro arguments)
dnl [[deprecated]] SCOLD_ENABLE_GDB    (no macro arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Postconditions
dnl
dnl   The SUBST variables in @VAR@ and $(VAR) form.
dnl
dnl   CPPFLAGS_gdb is defined  (but ins invariant-empty).
dnl   CFLAGS_gdb is defined.
dnl   CXXFLAGS_gdb is defined.
dnl   LDFLAGS_gdb is defined.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_ENABLE_GDB                (no arguments)
dnl
AC_DEFUN([SCOLD_ENABLE_GDB], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[ENABLE]_GDB], [HGTW_[ENABLE]_GDB])
    HGTW_ENABLE_GDB
])
AC_DEFUN([HGTW_ENABLE_GDB], [
  AC_MSG_CHECKING([for the debug build with gdb symbols, and no optimization])
  AC_ARG_ENABLE([gdb],
                [AS_HELP_STRING([--disable-gdb], [disable the gdb-capable debug build])],
                [AS_IF([test "x$enable_gdb" != "xno"],
                       [HGTWinternal_ENABLE_GDB_MODE_SETTINGS],
                       [: not a debug build])],
                [default_enable_gdb=yes
                 HGTWinternal_ENABLE_GDB_MODE_SETTINGS])
  AC_MSG_RESULT([$enable_gdb])
  AC_SUBST([CPPFLAGS_gdb])
  AC_SUBST([CFLAGS_gdb])
  AC_SUBST([CXXFLAGS_gdb])
  AC_SUBST([LDFLAGS_gdb])
  if test xyes = x$default_enable_gdb ; then
      HGTW_MSG_VERBOSE([for lack of an explicit --disable-gdb, defaulting into the debug building mode])
  fi
  HGTW_MSG_VERBOSE([--enable-gdb=$enable_gdb CFLAGS_gdb=$CFLAGS_gdb, CXXFLAGS_gdb=$CXXFLAGS_gdb, LDFLAGS_gdb=$LDFLAGS_gdb])
])

dnl
dnl HGTWinternal_ENABLE_GDB_MODE_SETTINGS     (no macro) arguments
dnl
dnl This is to be called only from HGTW_ENABLE_GDB
dnl
AC_DEFUN([HGTWinternal_ENABLE_GDB_MODE_SETTINGS], [
    # reminder ... -gdb and -O2 do not play well together
    enable_gdb=yes
    : DO NOT - this destroys the preciousness of these variables from the environment
    if false ; then
        CFLAGS=
        CXXFLAGS=
        LDFLAGS=
    fi
    CPPFLAGS_gdb=
    CFLAGS_gdb=-ggdb
    CXXFLAGS_gdb=-ggdb
    LDFLAGS_gdb=-ggdb
])
