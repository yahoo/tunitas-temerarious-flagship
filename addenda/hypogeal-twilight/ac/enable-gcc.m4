dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_ENABLE_GCC                   (no macro arguments)
dnl [[deprecated]] SCOLD_ENABLE_GCC   (no macro arguments)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl
dnl Purpose:
dnl
dnl Defines, for substitution in Makefile.am
dnl     @CPPFLAGS_gcc@
dnl     @CFLAGS_gcc@
dnl     @CXXFLAGS_gcc@
dnl     @LDFLAGS_gcc@
dnl
dnl Usage, in a Makefile.am
dnl     AM_CPPFLAGS = @CPPFLAGS_gcc@
dnl     AM_CFLAGS = @CFLAGS_gcc@
dnl     AM_CXXFLAGS = @CXXFLAGS_gcc@
dnl     AM_LDFLAGS = @LDFLAGS_gcc@
dnl
dnl The nonstandard flags are also entailed in these standard ones
dnl e.g. @CXXFLAGS_gcc@ contains @nonstd_gcc_CPPFLAGS@
dnl      @LDFLAGS_gcc@ contains @nonstd_gcc_LDFLAGS@
dnl
dnl Nomenclature (which is ambiguous)
dnl
dnl     GCC (a.k.a. gcc) is the name of the whole thing (GNU Compiler Collection)
dnl     gcc is the name of the C compiler
dnl     g++ (a.k.a. gxx) is the name of the C++ compiler
dnl
dnl [[FIXTHIS]] the duties of each of HGTW_CHECK_GCC and HGTW_ENABLE_GCC is dubious
dnl HGTW_CHECK_GCC ---- checks that gcc is even installed and has some bare minimal level
dnl HGTW_ENABLE_GCC --- enbles the relevant gcc options to acquire the best C++ language available (C++20 and beyond!)
dnl

# Debugging
#    not here
#    nearby, see HGTW_ENABLE_GDB
#
# Standards (C++11, 14, 17, 20)
#   recall: c++1y vs c++1z and -fconcepts
#   and c++2a is not available until gcc-7ish maybe?
#   but you want c++2a or c++2b (the best greatest one)
#
# Warnings
#   -Wall, always or else the language isn't complete (can functions without return statements, etc.)
#
#   -Wno-attributes, no warnings about unsupported attributes
#       because
#           src/c/detail/Stringn.consty.xcpp:42:10: warning: 'implicit' attribute directive ignored [-Wattributes]
#           inline [[implicit]] Stringn(Stringn<CHAR> const &);
#
#    -Wno-ignored-attributes
#       because
#           src/sys/posix/detail/exec/Core.const_stringz.xcpp:46:144: warning: ignoring attributes on template argument ‘sys::posix::detail::exec::declared::execl {aka int(const char*, const char*, ...) throw ()}’ [-Wignored-attributes]
#
# We want C++20 and as close to C++23 as possible
# Use -std=c++2a -fconcepts but do not supply the options twice.
#
# Skip -fsyntax-only to just check syntax (but codegen isn't that expensive it turns out, its use is not a performance win)

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl HGTW_ENABLE_GCC                (no arguments)
dnl
dnl default enabled
dnl
AC_DEFUN([SCOLD_ENABLE_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[ENABLE]_GCC], [HGTW_[ENABLE]_GCC])
    HGTW_ENABLE_GCC
])
AC_DEFUN([HGTW_ENABLE_GCC], [
    AC_REQUIRE([HGTW_WITH_NONSTD_GCC])
    AC_REQUIRE([HGTW_CHECK_GCC])
    AC_MSG_CHECKING([for building with gcc and g++ in C++2a, C++20 and on unto C++2b and C++2c])
    function __probe_gcc_cxx_option() {
        #
        # these options must be tested for rather than asserted (older g++ does not support or allow them)
        # e.g. /exp/gcc/7/bin/gcc, /opt/nonstd/gcc/bin/gcc
        #
        # Usage:
        #
        #   __probe_gcc_cxx_option -fconcepts
        #   __probe_gcc_cxx_option -std=c++2b -std=c++20 -std=c++2a -std=c++1z -std=c++17
        #   __probe_gcc_cxx_option -fmodules-ts -fmodules
        #   __probe_gcc_cxx_option -fcoroutines-ts
        #   __probe_gcc_cxx_option -fchar8_t
        #
        for option in $[@] ; do
            if ${CXX:-g++} -c -o /dev/null -x c++ ${option} /dev/null > /dev/null 2>&1 ; then
                echo "$option"
                return
            fi
        done
    }
    dnl WATCHOUT - these declarations must be here within the m4 defun, they cannot be at global scope
    declare -a __gcc_Wall=( -Wall )
    declare -a __gxx_Wall=( -Wall -Wno-attributes -Wno-ignored-attributes )
    #
    # WATCHOUT - turn on as many of the advanced options as possible, but don't turn on any that don't (yet) exist
    # these are in priority order in the separate tiers
    #
    # https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#C_002b_002b-Dialect-Options
    # https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#index-fconcepts
    # https://gcc.gnu.org/projects/cxx-status.html
    # https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Modules.html#C_002b_002b-Modules
    #
    # WATCHOUT -- -fconcepts-ts provides features that are no longer (never were) in the standard
    #          and -fconcepts is the default in C++20
    #
    # e.g. ---------------\\\\ (this)
    #                     ||||
    #                     ||||
    #                     vvvv
    #             concept bool Name = ...expression...
    #
    # e.g. -------------------------------------\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\ (this)
    #                                           ||||||||||||||||||||||||||||||||||||
    #                                           ||||||||||||||||||||||||||||||||||||
    #                                           vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
    #  -fconcepts-ts      { unifier.data() } -> typename UNIFIER::value_type const *;
    #  C++20              { unifier.data() } -> convertible_to<typename UNIFIER::value_type const *>;
    #
    # e.g.
    # src/re/required/Corelike.xcpp:9:38: warning: the ‘bool’ keyword is not allowed in a C++20 concept definition
    # src/re/required/Corelike.xcpp:11:27: error: return-type-requirement is not a type-constraint
    #
    # You want C++20 (minimum) and any new C++23 features that are available.
    # The past is gone.
    # Only the future is in front of us.
    #
    # gcc-8  -fconcepts
    # gcc-9  -fconcepts
    # gcc-10 -fconcepts (it is the default) but NOT -fconcepts-ts
    # gcc-11
    declare -a __gxx_Cxx=( \
      -ftemplate-backtrace-limit=0 \
      $(__probe_gcc_cxx_option -std=c++26 -std=c++2c -std=c++23 -std=c++2b -std=c++20 -std=c++2a -std=c++17 -std=c++1z) \
      $(__probe_gcc_cxx_option -fmodules -fmodules-ts) \
      -fconcepts $(: NOT NEEDED in C++20 __probe_gcc_cxx_option -fconcepts -fconcepts-ts) \
      $(__probe_gcc_cxx_option -fconcepts-diagnostics-depth=0) \
      $(__probe_gcc_cxx_option -fcoroutines -fcoroutines-ts) \
      $(__probe_gcc_cxx_option -fchar8_t) \
    )
    declare -a __gld_Wall=( -Wall )
    __answer_default_enable_gcc=yes
    AC_ARG_ENABLE([gcc],
                  [AS_HELP_STRING([--disable-gcc], [disable the gcc-specific options and warnings])],
                  [__answer_default_enable_gcc=no;
                   AS_IF([test "x$enable_gcc" != "xno"],
                         [HGTWinternal_ENABLE_GCC_MODE_SETTINGS],
                         [: not a gcc build])],
                  [__answer_default_enable_gcc=yes
                   HGTWinternal_ENABLE_GCC_MODE_SETTINGS])
    AC_MSG_RESULT([${enable_gcc:=$__answer_default_enable_gcc}])
    AC_SUBST([CPPFLAGS_gcc])
    AC_SUBST([CFLAGS_gcc])
    AC_SUBST([CXXFLAGS_gcc])
    AC_SUBST([LDFLAGS_gcc])
    if test xyes = x$__answer_default_enable_gcc ; then
        m4_changequote(<,>)
        __default_gxx_arguments="${__gxx_Wall[@]} ${__gxx_Cxx[@]}"
        m4_changequote([,])
        HGTW_MSG_VERBOSE([for lack of an explicit --disable-gcc, defaulting g++ to build with ${__default_gxx_arguments}])
    fi
    HGTW_MSG_VERBOSE([--enable-gcc=$enable_gcc CFLAGS_gcc=$CFLAGS_gcc, CXXFLAGS_gcc=$CXXFLAGS_gcc, LDFLAGS_gcc=$LDFLAGS_gcc])
])

dnl
dnl HGTWinternal_ENABLE_GCC_MODE_SETTINGS     (no macro) arguments
dnl
dnl This is to be called only from HGTW_ENABLE_GCC
dnl
AC_DEFUN([HGTWinternal_ENABLE_GCC_MODE_SETTINGS], [
    m4_changequote(<,>)
    CPPFLAGS_gcc="${nonstd_gcc_CPPFLAGS}"
    CFLAGS_gcc="${nonstd_gcc_CFLAGS} ${__gcc_Wall[@]}"
    CXXFLAGS_gcc="${nonstd_gcc_CXXFLAGS} ${__gxx_Wall[@]} ${__gxx_Cxx[@]}"
    LDFLAGS_gcc="${nonstd_gcc_LDFLAGS} ${__gld_Wall[@]}"
    m4_changequote([,])
])
