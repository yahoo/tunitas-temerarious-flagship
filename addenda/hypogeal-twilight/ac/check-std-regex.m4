dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_CHECK_STD_REGEX       (no arguments)
dnl
dnl [[deprecating]] HGTW_WITH_STD_REGEX       is deprecating because it is "check" not "with"
dnl [[deprecating]] SCOLD_WITH_STD_REGEX      is deprecated, with a deprecation warning
dnl
dnl tl;dr -- std::regex Does.Not.Work. (we have to supply boost::regex instead)
dnl
dnl "enable a feature"
dnl "with a component"
dnl
dnl Usage:
dnl
dnl     ./configure (omitted)                the default, guesses gcc based on `rpm -q gcc-c++`
dnl     ./configure --with-std-regex         -lboost-regex or (default) -lstdc++ by compiler
dnl     ./configure --with-std-regex=yes
dnl     ./configure --with-std-regex=no
dnl     ./configure --without-std-regex
dnl     ./configure --with-std-regex=std
dnl     ./configure --with-std-regex=boost
dnl
dnl     configure.ac: HGTW_WITH_STD_REGEX
dnl     Makefile.am:  __COMPILER_LDFLAGS_SET = ...other-flags...  @libstd_regex@
dnl

dnl ----------------------------------------------------------------------------------------------------
dnl [[FIXTHIS]] does not perform a test-to-see-if-it-works as is expected for the configure methodology
dnl [[FIXTHIS]] does record what is believed to be workable based on an rpm-based Linux system (Fedora)
dnl

dnl
dnl [[deprecating]] SCOLD_WITH_STD_REGEX      (no arguments)
dnl [[deprecating]] HGTW_WITH_STD_REGEX      (no arguments)
dnl
AC_DEFUN([SCOLD_WITH_STD_REGEX], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[STD]_REGEX], [HGTW_[CHECK]_[STD]_REGEX])
    HGTW_CHECK_STD_REGEX([$1], [$2])
])
AC_DEFUN([HGTW_WITH_STD_REGEX], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_ENABLE_DEPRECATION_NOTIFICATION([HGTW_[WITH]_[STD]_REGEX], [HGTW_[CHECK]_[STD]_REGEX])
    HGTW_CHECK_STD_REGEX([$1], [$2])
])

dnl
dnl HGTW_CHECK_STD_REGEX      (no arguments)
dnl
dnl Whereas std::regex is not implemented for gcc 4
dnl     c.f. gcc 4.8 where it throws exceptions at runtime)
dnl See https://gcc.gnu.org/onlinedocs/libstdc++/manual/status.html
dnl
AC_DEFUN([HGTW_CHECK_STD_REGEX], [
    AC_REQUIRE([HGTW_CHECK_BOOST])
    AC_ARG_ENABLE([std-regex],
                  [AS_HELP_STRING([--enable-std-regex], [ERROR use --with-std-regex])],
                  [AC_MSG_ERROR([use --with-$1=ROOT, e.g. --with-$2=$prefix])])
    AC_ARG_WITH([std-regex],
                [AS_HELP_STRING([--with-std-regex], [use std::regex instead of boost::regex])])
    case $with_std_regex in
    ( "" )
        dnl guess & hope (with sensible defaults based upon experience)
        case $(rpm -q gcc) in
        ( gcc-4* )
            # Whereas std::regex is not implemented for gcc 4.8 (it throws exceptions at runtime)
            # See https://gcc.gnu.org/onlinedocs/libstdc++/manual/status.html
            #
            # std:regex -- does. not. work. (we have to supply boost::regex instead)
            #
            libstd_regex=$libboost_regex
            ;;
        ( gcc-5* )
            # untested
            libstd_regex=
            ;;
        ( changequote([{],[}])gcc-[6789]*changequote({[},{]}) )
            # Fedora 24 -> gcc-6.2.1-2.fc24.x86_64
            # gcc-6.2.1-2.fc24.x86_64 (no need for boost, std::regex just works)
            libstd_regex=
            ;;
        ( gcc-* )
            AC_MSG_WARN([unknown version of gcc, assuming that std::regex is operable.])
            libstd_regex=
            ;;
        ( * )
            AC_MSG_WARN([unknown compiler, is gcc installed?])
            # good luck
            libstd_regex=
            ;;
        esac
        ;;
    ( yes | std  )
        # -lstdc++ will have it, no need to say anything
        libstd_regex=
        ;;
    ( no | boost )
        # 
        libstd_regex=$libboost_regex
        ;;
    ( * )
        AC_MSG_CHECKING([--with-std-regex must be one of unspecified, yes or no])
        ;;
    esac
    AC_SUBST([libstd_regex])
])
