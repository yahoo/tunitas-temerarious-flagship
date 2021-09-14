dnl
dnl HT_PROG_GCC                         (no arguments)
dnl
dnl [[deprecated]] HT_CHECK_GCC         (no arguments)
dnl [[deprecated]] HGTW_CHECK_GCC       (no arguments)
dnl [[deprecated]] SCOLD_CHECK_GCC      (no arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl   The 'HGTW' prefix.
dnl   The 'CHECK' midfix
dnl
dnl Environment:
dnl   You will need at least gcc7 for -std=c++1z and -fconcepts.
dnl   We are requiring C++17 and the C++20 constructs, as much C++ as has been implemented.
dnl 
dnl [[FIXTHIS]] the duties of each of HT_PROG_GCC, HT_CHECK_GCC and HT_ENABLE_GCC is dubious
dnl HT_PROGK_GCC ------ checks that gcc is the at least of a certain reasonable version
dnl HGTW_CHECK_GCC ---- checks that gcc is even installed and has some bare minimal level
dnl HGTW_ENABLE_GCC --- enbles the relevant gcc options to acquire the best C++ language available (C++20 and beyond!)
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl [[deprecated]] HT_CHECK_GCC         (no arguments)
dnl [[deprecated]] HGTW_CHECK_GCC       (no arguments)
dnl [[deprecated]] SCOLD_CHECK_GCC      (no arguments)
dnl
AC_DEFUN([SCOLD_CHECK_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[CHECK]_GCC], [HT_[PROG]_GCC])
    HT_PROG_GCC
])
AC_DEFUN([HGTW_CHECK_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_GCC], [HT_[PROG]_GCC])
    HT_PROG_GCC
])
AC_DEFUN([HT_CHECK_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HT_[CHECK]_GCC], [HT_[PROG]_GCC])
    HT_PROG_GCC
])

AC_DEFUN([HT_PROG_GCC], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_WITH_NONSTD_GCC])
    AC_REQUIRE([AC_PROG_CXX])
    #
    # Don't check the rpm version number for gcc because an ad hoc compiler might be in play
    # Elsewhere see --with-nonstd-gcc=ROOT
    #
    if ! type -p ${CC:-gcc} >/dev/null 2>&1 ; then
       AC_MSG_NOTICE([nonstd_gcc_prefix is ${nonstd_gcc_prefix:-unset}])
       AC_MSG_ERROR([cannot find ${CC:-gcc}, is --with-nonstd-gcc=ROOT set appropriately?])
    fi
    if ! type -p ${CXX:-g++} >/dev/null 2>&1 ; then
       AC_MSG_NOTICE([nonstd_gcc_prefix is ${nonstd_gcc_prefix:-unset}])
       AC_MSG_ERROR([cannot find ${CXX:-g++}, is --with-nostd-gcc=ROOT set appropriately?])
    fi
    #
    # Anything below GCC 9 is unusable; see https://en.cppreference.com/w/cpp/compiler_support
    # While GCC 9 won't give you (fullish) C++20, it gives you "enough" for the #ifdefs to carry you the rest of the way.
    #
    # Specimen:
    #
    #    $ gcc --version
    #    gcc (GCC) 9.3.1 20200413
    #    ...blah blah blah...
    #
    gcc_require_MAJOR=9
    gcc_require_MINOR=3
    #
    # Whereas others have tried, and have some hints
    # https://stackoverflow.com/questions/7067385/find-the-gcc-version
    gcc_have_VERSION=$(set -o pipefail ; ${CC:-gcc} --version | head -1)
    if test 0 != $? ; then
       AC_MSG_ERROR([cannot acquire the ${CC:-gcc} version number])
    fi
    if expr "x.$gcc_have_VERSION" : "x..*(GCC) [0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]* .*" > /dev/null; then
       AC_MSG_ERROR([cannot acquire the ${CC:-gcc} version number])
    fi
    dnl WATCHOUT - the use of [ ] for quote conflicts with regex [0-9]
    m4_changequote([{], [}])
    gcc_have_MAJOR=$(expr "x.$gcc_have_VERSION" : "x\..*(GCC) \([0-9][0-9]*\)\..*")
    gcc_have_MINOR=$(expr "x.$gcc_have_VERSION" : "x\..*(GCC) [0-9][0-9]*\.\([0-9][0-9]*\)\..*")
    gcc_have_PATCH=$(expr "x.$gcc_have_VERSION" : "x\..*(GCC) [0-9][0-9]*\.[0-9][0-9]*\.\([0-9][0-9]*\) .*")
    m4_changequote({[}, {]})
    HGTW_MSG_VERBOSE([gcc version is $gcc_have_VERSION as $gcc_have_MAJOR.$gcc_have_MINOR.$gcc_have_patch])
    AC_MSG_CHECKING([for at least gcc ${gcc_require_MAJOR?}.${gcc_require_MINOR?} and the C++11, C++14, C++17 & C++2a capabilities])
    if { test ${gcc_require_MAJOR?} = ${gcc_have_MAJOR?} && test ${gcc_require_MINOR?} -le ${gcc_have_MINOR?} ; } || { test ${gcc_require_MAJOR?} -lt ${gcc_have_MAJOR?} ; } ; then
       AC_MSG_RESULT([ok ($gcc_have_VERSION)])
    else
       AC_MSG_ERROR([failing because only ${gcc_have_VERSION?} is available])
    fi
])
