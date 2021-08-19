dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_STATIC_EXECUTABLES (no arguments)
dnl
dnl    --enable-static-executables=yes
dnl    --enable-static-executables=no
dnl
dnl Deprecations
dnl
dnl   avoid  @STATIC_EXECUTABLES_LDFLAGS@
dnl   prefer @static_EXECUTABLES_LDFLAGS@
dnl
dnl Establishes the variables
dnl   @STATIC_EXECUTABLES_LDFLAGS@                  containing empty or -static
dnl   @static_EXECUTABLES_LDFLAGS@                  containing empty or -static
dnl   @all_static_EXECUTABLES_LDFLAGS@              containing empty or -all-static
dnl   @static_libtool_libs_EXECUTABLES_LDFLAGS@     containing empty or -static-libtool-libs
dnl
dnl That's all it does.
dnl The final link CAN use -static if @static_EXECUTABLES_LDFLAGS@ is mentioned in LDFLAGS as shown below
dnl
dnl To build completely static, there are many other switches.
dnl For example --enable-static, which is distinct from and independent of --enable-static-executables
dnl 
dnl Also WATCHOUT WATCHOUT WATCHOUT - libtool has redefined what -static means in final-link
dnl Also WATCHOUT WATCHOUT WATCHOUT - the sense of gcc (g++) -static is NOT the sense (see below)
dnl amply documented in the libtool documentation and also at https://wiki.scold-lang.org/page/Libtool
dnl
dnl   -all-static
dnl      If output-file is a library, then only create a static library. This flag cannot be used together with disable-static (see LT_INIT).
dnl      If output-file is a program, then do not link it against any shared libraries at all. 
dnl  -static
dnl      If output-file is a library, then only create a static library.
dnl      If output-file is a program, then do not link it against any uninstalled shared libtool libraries. 
dnl  -static-libtool-libs
dnl      If output-file is a library, then only create a static library.
dnl      If output-file is a program, then do not link it against any shared libtool libraries. 
dnl
dnl Usage (./configure, the reasonable combinations):
dnl
dnl   ./configure --enable-static  --enable-static-executables     ... static & dynamic libraries, static executables
dnl   ./configure --enable-static  --disable-static-executables    ... static & dynamic libraries, dynamic executables
dnl   ./configure --disable-static --disable-static-executables    ... dynamic libraries, dynamic executables
dnl
dnl Usage (.../Makefrag.am, for some executable)
dnl
dnl   sbin_executable = sbin/executable
dnl   sbin_executable_LDADD = ...libraries...
dnl   sbin_executable_LDFLAGS =  @static_EXECUTABLES_LDFLAGS@ $(PACKAGE_LDFLAGS_SET)
dnl   sbin_executable_MODULES = $(call SCOLD_SOURCEStoMODULES,$(sbin_executable_SOURCES))
dnl   sbin_executable_SOURCES = ...sources...
dnl
dnl Usage (command line)
dnl
dnl   make LDFLAGS=-all-static
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([HGTW_ENABLE_STATIC_EXECUTABLES], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    unset STATIC_EXECUTABLES_LDFLAGS
    unset static_EXECUTABLES_LDFLAGS
    unset all_static_EXECUTABLES_LDFLAGS
    unset static_libtool_libs_EXECUTABLES_LDFLAGS
    AC_MSG_CHECKING([force static linking of executables])
    AC_ARG_ENABLE([static-executables],
                  [AC_HELP_STRING([--enable-static-executables], [use -static to final-link the executables])],
                  [
                      case $enableval in
                      ( yes | "" )
                          AC_MSG_RESULT([yes])
                          STATIC_EXECUTABLES_LDFLAGS=-static # deprecating
                          static_EXECUTABLES_LDFLAGS=-static # prefer
                          all_static_EXECUTABLES_LDFLAGS=-all-static
                          static_libtool_libs_EXECUTABLES_LDFLAGS=-static-libtool-libs
                          ;;
                      ( no )
                          AC_MSG_RESULT([no])
                          # they are already unset from the preamble
                          ;;
                      ( * )
                          AC_MSG_RESULT([unclear])
                          AC_MSG_WARN([found --enable-static-executables=${enableval:-(empty)}])
                          AC_MSG_ERROR([the value for static-executables must be "yes" or "no"])
                          ;;
                      esac
                  ],
                  [
                      AC_MSG_RESULT([no])
                      # they are already unset from the preamble
                  ])
    HGTW_MSG_NOTICE([executables can be final-linked with static_EXECUTABLES_LDFLAGS ${static_EXECUTABLES_LDFLAGS:-contains no flags}])
    HGTW_MSG_NOTICE([executables can be final-linked with all_static_EXECUTABLES_LDFLAGS ${all_static_EXECUTABLES_LDFLAGS:-contains no flags}])
    HGTW_MSG_NOTICE([executables can be final-linked with static_libtool_libs_EXECUTABLES_LDFLAGS ${static_libtool_libs_EXECUTABLES_LDFLAGS:-contains no flags}])
    AC_SUBST([STATIC_EXECUTABLES_LDFLAGS]) dnl avoid, deprecating
    AC_SUBST([static_EXECUTABLES_LDFLAGS]) dnl prefer
    AC_SUBST([all_static_EXECUTABLES_LDFLAGS])
    AC_SUBST([static_libtool_libs_EXECUTABLES_LDFLAGS])
])
