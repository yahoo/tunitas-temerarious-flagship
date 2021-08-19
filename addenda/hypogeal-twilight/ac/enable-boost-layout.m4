dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_BOOST_LAYOUT                  (no arguments)
dnl
dnl [[deprecated]] SCOLD_ENABLE_BOOST_LAYOUT    (no arguments)
dnl [[deprecated]] SCOLD_CHECK_BOOST_LAYOUT     (no arguments)
dnl [[deprecated]] SCOLD_WITH_BOOST_LAYOUT      (no arguments)
dnl
dnl Defines a substitution variable for each boost library with the layout suffix
dnl e.g.
dnl
dnl    @libboost_random@
dnl    @libboost_regex@
dnl    @libboost_thread@
dnl    ...etc...
dnl
dnl Deprecation
dnl   the 'SCOLD' prefix)
dnl   confusing variants of the name.
dnl
dnl Called implicitly from HGTW_CHECK_BOOST, you should not need to call this directly.
dnl
dnl
dnl use "WITH a subsystem"
dnl use "ENABLE a feature"
dnl use "CHECK an API"
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([SCOLD_CHECK_BOOST_LAYOUT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_[BOOST]_LAYOUT],
                        [HGTW_[ENABLE]_[BOOST]_LAYOUT])
    HGTW_ENABLE_BOOST_LAYOUT
])
AC_DEFUN([HGTW_CHECK_BOOST_LAYOUT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_WARNING([there is now and never was such a call [HGTW]_[CHECK]_[BOOST]_[LAYOUT]])
    HGTW_MSG_NOTICE([instead, calling [HGTW]_[ENABLE]_[BOOST]_[LAYOUT]]) dnl WITH a subsystem, ENABLE a feature, CHECK an API
    HGTW_ENABLE_BOOST_LAYOUT
])

AC_DEFUN([SCOLD_WITH_BOOST_LAYOUT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[BOOST]_LAYOUT],
                        [HGTW_[ENABLE]_[BOOST]_LAYOUT])
    HGTW_ENABLE_BOOST_LAYOUT
])
AC_DEFUN([HGTW_WITH_BOOST_LAYOUT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_WARNING([there is now and never was such a call [HGTW]_[WITH]_[BOOST]_[LAYOUT]])
    HGTW_MSG_NOTICE([instead, calling [HGTW]_[ENABLE]_[BOOST]_[LAYOUT]]) dnl WITH a subsystem, ENABLE a feature, CHECK an API
    HGTW_ENABLE_BOOST_LAYOUT
])

dnl
dnl HGTW_ENABLE_BOOST_LAYOUT      (no arguments)
dnl
dnl WATCHOUT - boost is compiled with wildly different names in each Fedora release
dnl 
dnl From Boost's build system (bjam --layout)
dnl
dnl --layout=<layout>  Determines whether to choose library names and header locations
dnl                    such that multiple versions of Boost or multiple compilers can
dnl                    be used on the same system.
dnl 
dnl versioned - Names of boost binaries include the Boost version number, name
dnl             and version of the compiler and encoded build properties.  Boost
dnl             headers are installed in a subdirectory of <HDRDIR> whose name
dnl             contains the Boost version number.
dnl 
dnl tagged - Names of boost binaries include the encoded build properties
dnl          such as variant and threading, but do not including compiler name and
dnl          version, or Boost version. This option is useful if you build several
dnl          variants of Boost, using the same compiler.
dnl 
dnl system - Binaries names do not include the Boost version number or the
dnl          name and version number of the compiler.  Boost headers are installed
dnl          directly into <HDRDIR>.  This option is intended for system integrators
dnl          who are building distribution packages.
dnl 
dnl The default value is 'versioned' on Windows, and <strike>'system' on Unix.</strike>
dnl The default on Linux is arbitrary.
dnl
dnl         tagged  Fedora 18  gcc-4.7.2-8.fc18.x86_64    boost-1.50.0-7.fc18.x86_64
dnl         tagged  Fedora 19  gcc-4.8.3-7.fc19.x86_64    boost-1.55.0-8.fc21.x86_64
dnl         ???     Fedora 20
dnl         system  Fedora 21  gcc-4.9.2-1.fc21.x86_64    boost-1.55.0-8.fc21.x86_64
dnl         ???     Fedora 22
dnl         system  Fedora 23  gcc-5.3.1-6.fc23.x86_64    boost-1.58.0-11.fc23.x86_64
dnl 2016-04 system  Fedora 24  gcc-6.2.1-2.fc24.x86_64    boost-1.60.0-7.fc24.x86_64
dnl prefer 'system' from here on out
dnl 2016-11 ???     Fedora 25
dnl 2017-05 ???     Fedora 26
dnl 2017-11 ???     Fedora 27
dnl 2018-05 ???     Fedora 28
dnl 2018-10 ???     Fedora 29
dnl 2019-05 ???     Fedora 30
dnl 2019-10 ???     Fedora 31
dnl 2020-04 ???     Fedora 32
dnl 2020-11 ???     Fedora 33
dnl 2021-04 ???     Fedora 334
dnl
AC_DEFUN([SCOLD_ENABLE_BOOST_LAYOUT], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[ENABLE]_BOOST_LAYOUT], [HGTW_[ENABLE]_BOOST_LAYOUT])
    HGTW_ENABLE_BOOST_LAYOUT
])
AC_DEFUN([HGTW_ENABLE_BOOST_LAYOUT], [
    AC_ARG_WITH([boost-layout],
                [AS_HELP_STRING([--with-boost-layout], [ERROR use --enable-boost-layout=LAYOUT])],
                [AC_MSG_ERROR([use --enable-boost-layout=lAYOUT, e.g. --enable-boost-layout=system])])
    __no="'no'"
    __system="'system'"
    __tagged="'tagged'"
    __versioned="'versioned'"
    AC_ARG_ENABLE([boost-layout],
                  [AS_HELP_STRING([--enable-boost-layout], [Specify the boost library name layout, as ${__system?} or ${__tagged?}])],
                  [ : already set ],
                  [enable_boost_layout=no])
    case ${enable_boost_layout?} in
    ( no | system )
        the_boost_suffix=
        ;;
    ( tagged )
        the_boost_suffix=-mt
        ;;
    ( versioned )
        # And which version would we choose?  They sure do make their components hard to use, don't they?
        AC_MSG_ERROR([the configuration of --enable-boost-layout=${__versioned?} is not supported])
        ;;
    ( yes | * )
        AC_MSG_ERROR([the option --enable-boost-layout=LAYOUT must be among ${__no?} (disabled), or ${__tagged?} or ${__system?}])
        ;;
    esac
    dnl gak (can they make this any harder?)
    libboost_atomic=-lboost_atomic$the_boost_suffix ; AC_SUBST([libboost_atomic])
    libboost_chrono=-lboost_chrono$the_boost_suffix ; AC_SUBST([libboost_chrono])
    libboost_context=-lboost_context$the_boost_suffix ; AC_SUBST([libboost_context])
    libboost_coroutine=-lboost_coroutine$the_boost_suffix ; AC_SUBST([libboost_coroutine])
    libboost_date_time=-lboost_date_time$the_boost_suffix ; AC_SUBST([libboost_date_time])
    libboost_filesystem=-lboost_filesystem$the_boost_suffix ; AC_SUBST([libboost_filesystem])
    libboost_graph=-lboost_graph$the_boost_suffix ; AC_SUBST([libboost_graph])
    libboost_iostreams=-lboost_iostreams$the_boost_suffix ; AC_SUBST([libboost_iostreams])
    libboost_locale=-lboost_locale$the_boost_suffix ; AC_SUBST([libboost_locale])
    libboost_log=-lboost_log$the_boost_suffix ; AC_SUBST([libboost_log])
    libboost_log_setup=-lboost_log_setup$the_boost_suffix ; AC_SUBST([libboost_log_setup])
    libboost_math_c99=-lboost_math_c99$the_boost_suffix ; AC_SUBST([libboost_math_c99])
    libboost_math_c99f=-lboost_math_c99f$the_boost_suffix ; AC_SUBST([libboost_math_c99f])
    libboost_math_c99l=-lboost_math_c99l$the_boost_suffix ; AC_SUBST([libboost_math_c99l])
    libboost_math_tr1=-lboost_math_tr1$the_boost_suffix ; AC_SUBST([libboost_math_tr1])
    libboost_math_tr1f=-lboost_math_tr1f$the_boost_suffix ; AC_SUBST([libboost_math_tr1f])
    libboost_math_tr1l=-lboost_math_tr1l$the_boost_suffix ; AC_SUBST([libboost_math_tr1l])
    libboost_prg_exec_monitor=-lboost_prg_exec_monitor$the_boost_suffix ; AC_SUBST([libboost_prg_exec_monitor])
    libboost_program_options=-lboost_program_options$the_boost_suffix ; AC_SUBST([libboost_program_options])
    libboost_python=-lboost_python$the_boost_suffix ; AC_SUBST([libboost_python])
    libboost_random=-lboost_random$the_boost_suffix ; AC_SUBST([libboost_random])
    libboost_regex=-lboost_regex$the_boost_suffix ; AC_SUBST([libboost_regex])
    libboost_serialization=-lboost_serialization$the_boost_suffix ; AC_SUBST([libboost_serialization])
    libboost_signals=-lboost_signals$the_boost_suffix ; AC_SUBST([libboost_signals])
    libboost_system=-lboost_system$the_boost_suffix ; AC_SUBST([libboost_system])
    libboost_thread=-lboost_thread$the_boost_suffix ; AC_SUBST([libboost_thread])
    libboost_timer=-lboost_timer$the_boost_suffix ; AC_SUBST([libboost_timer])
    libboost_unit_test_framework=-lboost_unit_test_framework$the_boost_suffix ; AC_SUBST([libboost_unit_test_framework])
    libboost_wave=-lboost_wave$the_boost_suffix ; AC_SUBST([libboost_wave])
    libboost_wserialization=-lboost_wserialization$the_boost_suffix ; AC_SUBST([libboost_wserialization])
])
