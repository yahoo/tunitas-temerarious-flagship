dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_STD_FILESYSTEM      (no arguments)
dnl [[deprecated]] HGTW_WITH_STD_FILESYSTEM      (no arguments)
dnl [[deprecated]] SCOLD_CHECK_STD_FILESYSTEM
dnl [[deprecated]] SCOLD_WITH_STD_FILESYSTEM     is deprecated, with a deprecation warning
dnl
dnl tl;dr you need -lstdc++fs on gcc5 and later
dnl
dnl SUBST for @libstd_filesystem@
dnl
dnl Usage:
dnl
dnl    ./configure (omitted)                            the default, guesses gcc based on `rpm -q gcc-c++`
dnl    ./configure --with-std-filesystem                adds -lstdc++fs
dnl    ./configure --with-std-filesystem=no
dnl    ./configure --without-std-filesystem
dnl    ./configure --with-std-filesystem=exp            adds -lstdc++fs
dnl    ./configure --with-std-filesystem=experimental   adds -lstdc++fs
dnl
dnl    configure.ac:  HGTW_CHECK_STD_FILESYSTEM
dnl    Makefile.am:   Makefile_COMPILER_LDFLAGS_SET = ...other-flags... @libstd_filesystem@
dnl
dnl "enable a feature"
dnl "with a component"
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl [[FIXTHIS]] does not perform a test-to-see-if-it-works as is expected for the configure methodology
dnl [[FIXTHIS]] does record what is believed to be workable based on an rpm-based Linux system (Fedora)

AC_DEFUN([SCOLD_WITH_STD_FILESYSTEM], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[STD]_FILESYSTEM], [HGTW_[CHECK]_[STD]_FILESYSTEM])
    HGTW_CHECK_STD_FILESYSTEM([$1], [$2])
])
AC_DEFUN([HGTW_WITH_STD_FILESYSTEM], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[WITH]_[STD]_FILESYSTEM], [HGTW_[CHECK]_[STD]_FILESYSTEM])
    HGTW_CHECK_STD_FILESYSTEM([$1], [$2])
])

dnl a convenience, a global variable
AC_DEFUN([HGTWinternal_DEFINE_STD_EXPERIMENTAL_FILESYSTEM_LDFLAGS], [
  libstd_experimental_filesystem_LDFLAGS=-lstdc++fs
])

dnl
dnl HGTW_CHECK_STD_FILESYSTEM      (no arguments)
dnl
dnl Whereas std::filesystem is really std::experimental::filesystem or such
dnl and GCC has not yet supplied this code in libstdc++
dnl gcc 5-series through gcc 8-series and beyond
dnl
dnl See https://gcc.gnu.org/onlinedocs/libstdc++/manual/using_dynamic_or_shared.html
dnl See https://gcc.gnu.org/onlinedocs/libstdc++/manual/using.html
dnl
dnl <quote>
dnl   GCC 5.3 includes an implementation of the Filesystem library defined
dnl   by the technical specification ISO/IEC TS 18822:2015. Because this
dnl   is an experimental library extension, not part of the C++ standard,
dnl   it is implemented in a separate library, libstdc++fs.a, and there
dnl   is no shared library for it. To use the library you should include
dnl   <experimental/filesystem> and link with -lstdc++fs. The library
dnl   implementation is incomplete on non-POSIX platforms, specifically Windows
dnl   support is rudimentary.
dnl </quote>
dnl
AC_DEFUN([SCOLD_CHECK_STD_FILESYSTEM], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_[STD]_FILESYSTEM], [HGTW_[CHECK]_[STD]_FILESYSTEM])
    HGTW_CHECK_STD_FILESYSTEM([$1], [$2])
])
AC_DEFUN([HGTW_CHECK_STD_FILESYSTEM], [
    AC_REQUIRE([HGTWinternal_DEFINE_STD_EXPERIMENTAL_FILESYSTEM_LDFLAGS])
    AC_ARG_ENABLE([std-filesystem],
                  [AS_HELP_STRING([--enable-std-filesystem], [ERROR use --with-std-filesystem])],
                  [AC_MSG_ERROR([use --with-$1=LIBRARY, e.g. --with-$2 or --with-$2=-lstdc++fs])])
    AC_ARG_WITH([std-filesystem],
                [AS_HELP_STRING([--without-std-filesystem], [do not use the -lstdc++fs of gcc])])
    case $with_std_filesystem in
    ( "" )
        dnl guess & hope (with sensible defaults based upon experience)
        case $(rpm -q gcc) in
        ( changequote([{],[}])gcc-[56789]*changequote({[},{]}) )
            # Fedora 24 -> gcc-c++-6.2.1-2.fc24.x86_64
            # Fedora 27 -> gcc-c++-7.3.1-2.fc27.x86_64
            # Fedora 28 -> ??? and gcc-8.1.0 is out 2018-Q2
            libstd_filesystem=$libstd_experimental_filesystem_LDFLAGS
            ;;
        ( gcc-* )
            AC_MSG_WARN([unknown version of gcc, is $libstd_experimental_filesystem_LDFLAGS still required?])
            # good luck
            ;;
        ( * )
            AC_MSG_WARN([unknown compiler, is gcc installed?])
            # good luck
            ;;
        esac 
        ;;
    ( yes | exp | experimental )
        libstd_filesystem=$libstd_experimental_filesystem_LDFLAGS
        ;;
    ( no )
        libstd_filesystem=
        ;;
    ( * )
        AC_MSG_CHECKING([--with-std-filesystem must be one of unspecified, yes or no])
        ;;
    esac
    AC_SUBST([libstd_filesystem])
])
