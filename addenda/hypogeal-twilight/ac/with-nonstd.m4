dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_WITH_NONSTD(name-dashes, name_underscores, [explanation])
dnl HGTW_WITH_NONSTD(name-dashes, name_underscores, [explanation], [default-directory-root])
dnl
dnl HGTW_WITH_USR_LOCAL
dnl
dnl HGTW_WITH_NONSTD_GCC        (no arguments)
dnl HGTW_WITH_NONSTD_MYSQLPP    (no arguments)
dnl and the demi-trivial wrappers that are not remediations.
dnl HGTW_WITH_NONSTD_${COMPONENT}
dnl              for ${COMPONENT}
dnl                    BOOST                WITH_NONSTD_BOOST
dnl                    CURL                 WITH_NONSTD_CURL
dnl                    CURLPP               WITH_NONSTD_CURLPP
dnl                    HALF                 ...you get the idea...
dnl                    JSONCPP
dnl                    LEVELDB
dnl                    SQLITE
dnl                    UUID
dnl
dnl Deprecations:
dnl   The 'MYSQL' suffix becomes 'MYSQLPP'
dnl   [[deprecated]] HGTW_WITH_NONSTD_MYSQL      (no arguments, see HGTW_WITH_NONSTD_MYSQLPP)
dnl
dnl Deprecations:
dnl   The 'SCOLD' prefix.
dnl   [[deprecated]] SCOLD_WITH_NONSTD(name-dashes, name_underscores, [explanation])
dnl   [[deprecated]] SCOLD_WITH_NONSTD_GCC        (no arguments)
dnl   [[deprecated]] SCOLD_WITH_NONSTD_MYSQL      (no arguments)
dnl   [[deprecated]] SCOLD_WITH_NONSTD_MYSQLPP    (no arguments)
dnl   [[deprecated]] SCOLD_WITH_NONSTD_${COMPONENT}
dnl                                for ${COMPONENT}
dnl                                    BOOST
dnl                                    CURL
dnl                                    CURLPP
dnl                                    JSONCPP
dnl                                    LEVELDB
dnl                                    SQLITE
dnl                                    UUID
dnl
dnl the word 'nonstd' is prefixed to the names
dnl e.g. nonstd-gcc, nonstd-mysql, etc.
dnl
dnl Creates AC_SUBST for nonstd_${COMPONENT}-prefixed variables
dnl e.g.
dnl     nonstd_${COMPONENT}_prefix
dnl     nonstd_${COMPONENT}_CPPFLAGS
dnl     nonstd_${COMPONENT}_CFLAGS
dnl     nonstd_${COMPONENT}_CXXFLAGS
dnl     nonstd_${COMPONENT}_LDFLAGS
dnl
dnl If no nonstd variant is selected then the relevant $2_pefix variable is empty
dnl This is in contrast to the usual autoconf practice of setting such values to NONE.
dnl Setting the values to empty will make it easier to substitute (or not) in configure or Makefile.am

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl Concepts and compatibilities.
dnl
dnl Error out if we see --with-${COMPONENT} in lieu of --with-nonstd-${COMPONENT}
dnl Avoid doing this for certain well-known packages
dnl Handle ambiguitites.
dnl
dnl Scenarios to guard (e.g. for boost, jsoncpp, mysql++)
dnl
dnl   --enable-mysql++            disallow
dnl                               cannot "enable" mysql++,
dnl                               it is not an enable-FEATURE but a with-SUBSYSTEM
dnl                               you want --with-nonstd-mysql++=ROOT
dnl   --with-mysql++              disallow
dnl                               cannot "with" mysql++,
dnl                               it is always relevant
dnl                               you want --with-nonstd-mysql++=ROOT
dnl   --enable-nonstd-mysql++     disallow
dnl                               cannot "enable" nonstd mysql++,
dnl                               it is not an enable-FEATURE, but rather a with-SUBSYSTEM
dnl   --with-nonstd-mysql++       allow
dnl                               valid and preferred usage
dnl
dnl Also
dnl
dnl   --enable-gcc                allow
dnl                               it adds - compilation modes, e.g. std=c++2a -fconcepts
dnl                               this is distinct from --enable-nonstd-gcc which is meaningless.
dnl   --with-gcc                  disallow
dnl                               gcc use is expected,
dnl                               clang isn't expected for no reason; will you do the portification?
dnl                               you want --with-nonstd-gcc=ROOT
dnl   --enable-nonstd-gcc         disallow
dnl                               it is not an enable-FEATURE, but rather a with-SUBSYSTEM
dnl   --with-nonstd-gcc=ROOT      allow
dnl                               valid and preferred usage
dnl                               use the nonstandard compiler at ROOT
dnl
dnl Separately
dnl
dnl   --enable-scold              disallow (use SCOLD_WITH_STD for --with-std-scold=ROOT)
dnl   --with-scold                disallow, ibidem.
dnl   --enable-nonstd-scold       disallow, ibidem.
dnl   --with-nonstd-scold=ROOT    disallow, ibidem.
dnl

dnl HGTW_WITH_USR_LOCAL
dnl
dnl Allow /usr/local, or not.
dnl
dnl When prefix=/usr/local you get *most* of it but not *all* of it
dnl in particular LDFLAGS does not -Wl,rpath=/usr/local/lib64
dnl and /etc/ld.so.conf may not specify /usr/local/lib64
dnl so thus HGTW_WITH_USR_LOCAL at configure-time and Makefile_COMPILER_LDFLAGS_SET contains @usr_local_LDFLAGS_SET@
dnl
AC_DEFUN([HGTW_WITH_USR_LOCAL], [
    : ${with_usr_local:=yes}
    if { test no != ${with_usr_local?} &&
         test yes != ${with_usr_local?} &&
         test /usr/local != ${with_usr_local?} ; } then
        AC_MSG_ERROR([the values allowed for --with-usr-local can only be "yes", "no" or "/usr/local"])
    elif test yes = ${with_usr_local?} ; then
         with_usr_local=/usr/local
    fi
    HGTWinternal_WITH_ADHOC_GUARDED([usr-local], [usr_local], [Enable the /usr/local area at runtime], [usr_local])
])

dnl
dnl SCOLD_WITH_NONSTD_GCC        (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere.
dnl
AC_DEFUN([SCOLD_WITH_NONSTD_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_GCC], [HGTW_[WITH]_[NONSTD]_GCC])
    HGTW_WITH_NONSTD_GCC
])
AC_DEFUN([HGTW_WITH_NONSTD_GCC], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    #
    # The many ways to fail...
    #
    # The ./configure invocation contained
    #    --with-gcc
    #    --enable-nonstd-gcc
    #
    #  Diagnosis: the luser is invalid.
    #     Reason: lusers are sloppy.
    #  Treatment: disallow.
    #        Why: the luser needs punishment.
    # Who[fixes]: the luser, the caller of ./configure
    #    Suggest: call ./configure correctly as --with-nonstd-gcc=VALUE or --without-nonstd-gcc
    #
    # Reminder: --enable-gcc is entirely valid.  See SCOLD_ENABLE_GCC
    #
    AC_ARG_WITH([gcc],
                [AS_HELP_STRING([--with-gcc], [ERROR use --with-nonstd-gcc=ROOT])],
                [AC_MSG_WARN([instead of --with-gcc=${withval:+=$withval}, use --with-nonstd-gcc=${prefix:-ROOT}])
                 AC_MSG_ERROR([use --with-nonstd-gcc=ROOT, e.g. --with-nonstd-gcc=${prefix:-ROOT}])])
    AC_ARG_ENABLE([nonstd-gcc],
                  [AS_HELP_STRING([--enable-nonstd-gcc], [ERROR use --with-nonstd-gcc=ROOT])],
                  [AC_MSG_WARN([instead of --enable-nonstd-gcc${enableval:+=$enableval}, use --with-nonstd-gcc=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-nonstd-gcc=ROOT, e.g. --with-nonstd-gcc=${prefix:-ROOT}])])
    #
    # The ./configure invocation contained
    #    --with-compiler
    #    --with-nonstd-compiler
    #
    #  Diagnosis: the luser is old.
    #     Reason: old lusers take a long time to relearn new tricks.
    #  Treatment: remediate.
    #        Why: the luser needs re-education.
    # Who[fixes]: the luser, the caller of ./configure
    #    Suggest: call ./configure with current usage as --with-nonstd-gcc=VALUE or --without-nonstd-gcc
    #
    AC_ARG_WITH([compiler],
                [AS_HELP_STRING([--with-compiler], [ERROR use --with-nonstd-gcc=ROOT])],
                [
                     HGTW_MSG_DEPRECATED([the option --with-compiler=ROOT],
                                         [the option --with-nonstd-gcc=ROOT])
                     AC_MSG_WARN([treating --with-compiler=${withval} as --with-nonstd-gcc=${withval}])
                     with_nonstd_gcc=$withval
                ])
    AC_ARG_WITH([nonstd-compiler],
                [AS_HELP_STRING([--with-nonstd-compiler], [ERROR use --with-nonstd-gcc=ROOT])],
                [
                     HGTW_MSG_DEPRECATED([the option --with-nonstd-compiler=ROOT],
                                         [the option --with-nonstd-gcc=ROOT])
                     AC_MSG_WARN([treating --with-nonstd-compiler=${withval} as --with-nonstd-gcc=${withval}])
                     with_nonstd_gcc=$withval
                ])
    #
    # The one way to succeed
    #
    # The ./configure invocation contained
    #    --with-nonstd-gcc=ROOT
    #    --without-nonstd-gcc
    #
    # Expected usage.
    #
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-gcc],
                                     [nonstd_gcc],
                                     [non-standard GCC, e.g. modernized gcc for C++11, C++14, C++17 and on unto C++2a and Modules TS],
                                     [nonstd_gcc])
    # Then (re-)bind CC and CXX so that they are captured in Makefile.in.
    # but by default (standard gcc) or by --without-nonstd-gcc there will be no such binding
    # This is current usage, but also set CC, CXX, PATH
    # This takes effect for the remainder fof ./configure (but not the subsequent make)
    if test -n "$nonstd_gcc_prefix" ; then
        : ${CC:=${nonstd_gcc_prefix?}/bin/gcc}
        : ${CXX:=${nonstd_gcc_prefix?}/bin/g++}
        # this does not help establish CC or CXX for Makefile.am
        : pointless PATH="${nonstd_gcc_prefix?}/bin:$PATH" export PATH
    fi
    dnl some old Makefile.am still use @nonstd_compiler_prefix@
    dnl by 2018-Q1 these should be all all all gone in all known projects.
    dnl compatibility for mention of $(nonstd_compiler_prefix) in the Makefile.am
    AC_SUBST([nonstd_compiler_prefix], [$nonstd_gcc_prefix])
])

dnl
dnl HGTW_WITH_NONSTD_MYSQLPP        (no arguments)
dnl
dnl "MYSQLPP" not "MYSQL"
dnl [[deprecated]] HGTW_WITH_NONSTD_MYSQL        (no arguments)
dnl [[deprecated]] SCOLD_WITH_NONSTD_MYSQL       (no arguments)
dnl
dnl So it can be used in an AC_REQUIRE clause, elsewhere.
dnl
dnl --with-nonstd-mysql++ is current
dnl --with-nonstd-mysqlpp is deprecated
dnl
AC_DEFUN([SCOLD_WITH_NONSTD_MYSQL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_MYSQL], [HGTW_[WITH]_[NONSTD]_MYSQLPP])
    HGTW_WITH_NONSTD_MYSQLPP
])
AC_DEFUN([HGTW_WITH_NONSTD_MYSQL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[WITH]_[NONSTD]_MYSQL], [HGTW_[WITH]_[NONSTD]_MYSQLPP])
    HGTW_WITH_NONSTD_MYSQLPP
])
AC_DEFUN([SCOLD_WITH_NONSTD_MYSQLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_MYSQLPP], [HGTW_[WITH]_[NONSTD]_MYSQLPP])
    HGTW_WITH_NONSTD_MYSQLPP
])
AC_DEFUN([HGTW_WITH_NONSTD_MYSQLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    #
    # The ./configure invocation contained
    #    --enable-mysqlpp
    #    --with-mysqlpp
    #    --enable-nonstd-mysqlpp
    #    --with-nonstd-mysqlpp
    #    --enable-mysql++
    #    --with-mysql++
    #    --enable-nonstd-mysql++
    #
    #  Diagnosis: the luser is invalid.
    #     Reason: lusers are sloppy.
    #  Treatment: disallow.
    #        Why: the luser needs punishment.
    # Who[fixes]: the luser, the caller of ./configure
    #    Suggest: call ./configure correctly as --with-nonstd-mysql++=VALUE or --without-nonstd-mysql++
    #
    AC_ARG_ENABLE([mysqlpp],
                  [AS_HELP_STRING([--enable-mysqlpp], [ERROR use --with-nonstd-mysql++=ROOT])],
                  [AC_MSG_WARN([instead of --enable-mysqlpp{enableval:+=$enableval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_WITH([mysqlpp],
                [AS_HELP_STRING([--with-mysqlpp], [ERROR use --with-nonstd-mysql++=ROOT])],
                [AC_MSG_WARN([instead of --with-mysqlpp=${withval:+=$withval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                 AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_ENABLE([nonstd-mysqlpp],
                  [AS_HELP_STRING([--enable-nonstd-mysqlpp], [ERROR use --with-nonstd-mysql++=ROOT])],
                  [AC_MSG_WARN([instead of --enable-nonstd-mysqlpp{enableval:+=$enableval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_WITH([nonstd-mysqlpp],
                [AS_HELP_STRING([--with-nonstd-mysqlpp], [ERROR use --with-nonstd-mysql++=ROOT])],
                [AC_MSG_WARN([instead of --with-nonstd-mysqlpp=${withval:+=$withval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                 AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_ENABLE([mysql++],
                  [AS_HELP_STRING([--enable-mysql++], [ERROR use --with-nonstd-mysql++=ROOT])],
                  [AC_MSG_WARN([instead of --enable-mysql++{enableval:+=$enableval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_WITH([mysql++],
                [AS_HELP_STRING([--with-mysql++], [ERROR use --with-nonstd-mysql++=ROOT])],
                [AC_MSG_WARN([instead of --with-mysql++=${withval:+=$withval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                 AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    AC_ARG_ENABLE([nonstd-mysql++],
                  [AS_HELP_STRING([--enable-nonstd-mysql++], [ERROR use --with-nonstd-mysql++=ROOT])],
                  [AC_MSG_WARN([instead of --enable-nonstd-mysql++{enableval:+=$enableval}, use --with-nonstd-mysql++=${prefix:-ROOT}])
                   AC_MSG_ERROR([use --with-nonstd-mysql++=ROOT, e.g. --with-nonstd-mysql++=${prefix:-ROOT}])])
    #
    # The one way to succeed
    #
    # The ./configure invocation contained
    #    --with-nonstd-mysql++=ROOT
    #    --without-nonstd-mysql++
    #
    # Expected usage.
    #
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-mysql++],
                                     [nonstd_mysqlpp],
                                     [MySQL++ supporting MySQL, MariaDB, i.e. rebuilt and hardcode-enable HAVE_MYSQL_SSL_SET],
                                     [nonstd_mysql__])
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_BOOST], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_BOOST], [HGTW_[WITH]_[NONSTD]_BOOST])
    HGTW_WITH_NONSTD_BOOST
])
AC_DEFUN([HGTW_WITH_NONSTD_BOOST], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_BOOST])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-boost], [nonstd_boost], [Non-standard Boost], [nonstd_boost])
])

AC_DEFUN([SCOLD_WITH_NONSTD_CPPUNIT], [
    AC_REQUIRE([HT_WITH_CPPUNIT])
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_CPPUNIT], [HT_[WITH]_[NONSTD]_CPPUNIT])
    HT_WITH_NONSTD_CPPUNIT
])
AC_DEFUN([HGTW_WITH_NONSTD_CPPUNIT], [
    AC_REQUIRE([HT_WITH_CPPUNIT])
    AC_REQUIRE([HT_ENABLE_DEPRECATION_NOTIFICATION])
    HT_MSG_DEPRECATED([HGTW_[WITH]_[NONSTD]_CPPUNIT], [HT_[WITH]_[NONSTD]_CPPUNIT])
    HT_WITH_NONSTD_CPPUNIT
])
AC_DEFUN([HT_WITH_NONSTD_CPPUNIT], [
    AC_REQUIRE([HT_WITH_CPPUNIT])
    AC_REQUIRE([HT_ENABLE_CONFIGURE_VERBOSE])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-cppunit], [nonstd_cppunit], [Non-standard CppUnit], [nonstd_cppunit])
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_CURL], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_CURL], [HGTW_[WITH]_[NONSTD]_CURL])
    HGTW_WITH_NONSTD_CURL
])
AC_DEFUN([HGTW_WITH_NONSTD_CURL], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_CURL])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-curl], [nonstd_curl], [Non-standard cURL], [nonstd_curl])
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_CURLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_CURLPP], [HGTW_[WITH]_[NONSTD]_CURLPP])
    HGTW_WITH_NONSTD_CURLPP
])
AC_DEFUN([HGTW_WITH_NONSTD_CURLPP], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_CURLPP])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-curlpp], [nonstd_curlpp], [Non-standard cURL++], [nonstd_curlpp])
])

dnl ibidem.
AC_DEFUN([HGTW_WITH_NONSTD_HALF], [
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-half], [nonstd_half], [non-standard Half-Float IEEE476], [nonstd_half])
])

dnl and with the warning message
AC_DEFUN([HGTW_WITH_NONSTD_LIBHTTPSERVER], [
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-libhttpserver], [nonstd_libhttpserver],
                                     [a non-standard libHTTPServer (with IPv6 and threading patches)],
                                     [nonstd_libhttpserver])
    if test -z "$nonstd_libhttpserver_prefix"
    then
        # Patches are involved; at least nonstd-libhttpserver-0.9.0-7.0.ipv6
        HGTW_MSG_NOTICE([the build is now configured --without-nonstd-libhttpserver])
        HGTW_MSG_NOTICE([the build may (will) exhibit problems])
        HGTW_MSG_NOTICE([the standard build of libhttpserver-0.9.0 does not accept server port assignments on IPv6])
        HGTW_MSG_NOTICE([neither the standard nor the non standard build of libhttpserver-0.9.0 supports INTERNAL_SELECT correctly])
        HGTW_MSG_NOTICE([the non-standard build, nonstd-libhttpserver-0.9.0, is patched for IPv6 and some thread management problems])
        HGTW_MSG_WARNING([the use of --with-nonstd-libhttpserver is effectively required])
    fi
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_JSONCPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_JSONCPP], [HGTW_[WITH]_[NONSTD]_JSONCPP])
    HGTW_WITH_NONSTD_JSONCPP
])
AC_DEFUN([HGTW_WITH_NONSTD_JSONCPP], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_JSONCPP])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-jsoncpp], [nonstd_jsoncpp], [Non-standard JsonCpp], [nonstd_jsoncpp])
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_LEVELDB], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_LEVELDB], [HGTW_[WITH]_[NONSTD]_LEVELDB])
    HGTW_WITH_NONSTD_LEVELDB
])
AC_DEFUN([HGTW_WITH_NONSTD_LEVELDB], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_LEVELDB])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-leveldb], [nonstd_leveldb], [Non-standard LevelDB], [nonstd_leveldb])
])

dnl
dnl SCOLD_WITH_NONSTD_SQLITE    (no arguments)
dnl
dnl The singleton SCOLD_WITH_NONSTD_SQLITE exists so that it can be mentionedin AC_REQUIRE.
dnl it is not "wrong" or "old" in any sense to use WITH_NONSTD(sqlite, sqlite, [...reason...])
dnl so we don't even emit a warning, or even a notice ... it is a verbose (informational) message.
dnl
AC_DEFUN([SCOLD_WITH_NONSTD_SQLITE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_SQLITE], [HGTW_[WITH]_[NONSTD]_SQLITE])
    HGTW_WITH_NONSTD_SQLITE
])
AC_DEFUN([HGTW_WITH_NONSTD_SQLITE], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_SQLITE])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-sqlite], [nonstd_sqlite], [Non-standard SQLite], [nonstd_sqlite])
])

dnl ibidem.
AC_DEFUN([SCOLD_WITH_NONSTD_UUID], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_[NONSTD]_UUID], [HGTW_[WITH]_[NONSTD]_UUID])
    HGTW_WITH_NONSTD_UUID
])
AC_DEFUN([HGTW_WITH_NONSTD_UUID], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    HGTW_MSG_VERBOSE([treating as [SCOLD]_[WITH]_[NONSTD]_UUID])
    HGTWinternal_WITH_NONSTD_GUARDED([nonstd-uuid], [nonstd_uuid], [Non-standard UUID (to supplant libuuid)], [nonstd_uuid])
])

dnl SCOLD_WITH_NONSTD(name-dashes, name_underscores, [explanation])
dnl SCOLD_WITH_NONSTD($1, $2, $3)
dnl    $1 - argument name-with-dashes          e.g. gcc-8, mysql
dnl    $2 - argument name_with_underscores     e.g. gcc_8
dnl    $3 - explanation fragment               e.g. GNU Compiler Collection (GCC), Generation Eight
dnl
dnl ... and any other compatibility enhancements that might be relevant
dnl
dnl     compiler        -> nonstd-gcc
dnl     nonstd-compiler -> nonstd-gcc
dnl
dnl The concern here is the locus of the problem.
dnl
dnl (a) the problem is in configure.ac
dnl     and as such as an API usage issue.
dnl
dnl (b) the problem is in ./configure,
dnl     being called by the maintainer
dnl     being called by a script; e.g. in .../release/package.spec 
dnl
AC_DEFUN([SCOLD_WITH_NONSTD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([SCOLD_[WITH]_NONSTD], [HGTW_[WITH]_NONSTD])
    HGTW_WITH_NONSTD([$1], [$2], [$3])
])
AC_DEFUN([HGTW_WITH_NONSTD], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    # pesky: must generate a single-quote character at runtime
    #        because the emacs bra-ket matching is confused by it in m4-mode
    q=$(printf "\x27") # pesky
    ifelse([nonstd], m4_bpatsubst([$1], [nonstd.*], [nonstd]), [
        #
        # The configure.ac contained
        #    HGTW_WITH_NONSTD([nonstd-THING], [nonstd_THING], [...])
        #
        #  Diagnosis: it is mis-coded.
        #     Reason: the noun "nonstd" cannot appear here.
        #  Treatment: disallow.
        #        Why: the leading "nonstd" is implicit, and herein we are too lazy to remediate-and-retry.
        # Who[fixes]: the maintainer of configure.ac
        #    Suggest: fix configure.ac
        #
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_WARN([convert to [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[m4_bpatsubst({$1}, {^nonstd.}, {})], [m4_bpatsubst({$2}, {^nonstd.}, {})], [$3]m4_changequote({[}, {]}))])
        AC_MSG_ERROR([the name cannot begin with ${q}nonstd${q}, the ${q}nonstd${q} is implicit.])
    ], [ifelse([std], m4_bpatsubst([$1], [std.*], [std]), [
        #
        # The configure.ac contained
        #    HGTW_WITH_NONSTD([std-THING], [std_THING], [...])
        #
        #  Diagnosis: mis-coded.
        #     Reason: the noun "std" cannot appear here.
        #  Treatment: disallow.
        #        Why: the leading "std" does not belong here, rather use HGTW_WITH_STD
        # Who[fixes]: the maintainer of configure.ac
        #    Suggest: fix configure.ac
        #
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_WARN([convert to [SCOLD]_[WITH]_[STD](m4_changequote([{], [}])[m4_bpatsubst({$1}, {^std.}, {})], [m4_bpatsubst({$2}, {^std.}, {})], [$3]m4_changequote({[}, {]}))])
        AC_MSG_ERROR([the name cannot begin with ${q}std${q}, also call [SCOLD]_[WITH]_[STD] for this usage.])
    ], [ifelse([scold], [$1], [
        #
        # The configure.ac contained
        #    HGTW_WITH_NONSTD([scold], [scold], [...])
        #
        #  Diagnosis: it is mis-coded.
        #     Reason: the "scold" cannot appear here.
        #  Treatment: disallow.
        #        Why: the correct usage is with HGTW_WITH_STD
        # Who[fixes]: the maintainer of configure.ac
        #    Suggest: fix configure.ac
        # 
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_WARN([convert to [SCOLD]_[WITH]_[STD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_ERROR([there is no ${q}nonstd-scold${q}, only ${q}std-scold${q}])
    ], [ifelse([gcc], [$1], [
        #
        # The configure.ac contained
        #    HGTW_WITH_NONSTD([gcc], [gcc], [...])
        #
        # And the caller of ./configure will use
        #   --with-nonstd-gcc=ROOT
        #
        HGTW_WITH_NONSTD_GCC
    ], [ifelse([compiler], [$1], [
        #
        # The configure.ac contained:
        #    HGTW_WITH_NONSTD([compiler], [compiler], [...])
        #
        #  Diagnosis: configure.ac is old.
        #     Reason: the noun "compiler" is deprecated & abandoned.
        #  Treatment: allow, with remediation.
        #        Why: because there is lots of old usage out in configure.ac (plural) out in the wild.
        # Who[fixes]: the maintainer of configure.ac
        #    Suggest: should have used HGTW_WITH_NOSTD_GCC.
        #
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_WARN([treating as [SCOLD]_[WITH]_[NONSTD]_GCC])
        HGTW_WITH_NONSTD_GCC
    ], [ifelse([c++], m4_bpatsubst([$1], m4_changequote([{], [}]){^[cg]++$}m4_changequote({[}, {]}), [c++]), [
        #
        # The configure.ac contained
        #    HGTW_WITH_NONSTD([c++], [...], [...])
        #    HGTW_WITH_NONSTD([g++], [...], [...])
        #
        #  Diagnosis: it is mis-coded.
        #     Reason: this never was a usage, there is no "nonstd-c++", only nonstd-gcc.
        #  Treatment: disallow.
        #        Why: catch silly mis-coding.
        # Who[fixes]: the maintainer of configure.ac
        #    Suggest: fix configure.ac
        # 
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_ERROR([there is no ${q}nonstd-$2${q}, use ${q}nonstd-gcc${q}])
    ], [ifelse([boost], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_BOOST
    ], [ifelse([cppunit], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_CPPUNIT
    ], [ifelse([curl], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_CURL
    ], [ifelse([curlpp], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_CURLPP
    ], [ifelse([half], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_HALF
    ], [ifelse([jsoncpp], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_JSONCPP
    ], [ifelse([leveldb], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_LEVELDB
    ], [ifelse([libhttpserver], [$1], [
        # IS ACTUALLY a remediation; a large warning message is emitted.
        HGTW_WITH_NONSTD_LIBHTTPSERVER
    ], [ifelse([mysqlpp], [$1], [
        #
        # configure.ac contained
        #   HGTW_WITH_NONSTD([mysqlpp], [mysqlpp], [...])
        #
        #  Diagnosis: configure.ac is old.
        #     Reason: code gets old, we move on.
        #  Treatment: allow, remediate to the newer usage
        #        Why: because there is lots of old usage out in configure.ac (plural) in the wild
        # Who[Fixes]: the maintainer of configure.ac
        #    Suggest: fix configure.ac
        #
        HGTW_MSG_DEPRECATED([[SCOLD_WITH_NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))],
                            [[HGTW_WITH_NONSTD](m4_changequote([{], [}])[mysql++], [$2], [$3]m4_changequote({[}, {]}))])
        AC_MSG_WARN([treating as [SCOLD]_[WITH]_[NONSTD]_MYSQLPP])
        HGTW_WITH_NONSTD_MYSQLPP
    ], [ifelse([sqlite], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_SQLITE
    ], [ifelse([uuid], [$1], [
        # not a remediation; see the commentariat before.
        HGTW_WITH_NONSTD_UUID
    ], [ifelse([$2], m4_bpatsubst([$2],
                                  m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}),
                                  [_]), [
        #
        # The configure.ac contained
        #   HGTW_WITH_NONSTD([...], [identifier], [...])
        #
        # Therefore
        #   $1 is ...thisthing..., even an invalid shell variable (e.g. ImageMagick++)
        #   $2 is an identifier, a valid shell variable name.
        #
        # See the commentariat at HGTWinternal_WITH_NONSTD_GUARDED
        #
        HGTWinternal_WITH_NONSTD_GUARDED([nonstd-$1],
                                         [nonstd_$2],
                                         [$3],
                                         m4_bpatsubst([nonstd_$1],
                                                      m4_changequote([{], [}]){[^a-zA-Z0-9_]}m4_changequote({[}, {]}),
                                                      [_]))
    ], [
        #
        # Therefore
        # $1 is ...anything...,
        # $2 is not a valid shell variable.
        #
        #  Diagnosis: configure.ac is old
        #  Treatment: disllow
        #        Why: the call site at configure.ac is bad.
        # Who[Fixes]: the maintainer of configure.ac
        # 
        AC_MSG_WARN([see [SCOLD]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3])}m4_changequote({[}, {]})])
        AC_MSG_ERROR([invalid usage of $q$2$q in a shell variable])
    ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ]) ])
])

dnl
dnl HGTWinternal_WITH_ADHOC_GUARDED(name-dashes, name_underscores, [explanation], name_autoconf)
dnl HGTWinternal_WITH_ADHOC_GUARDED($1, $2, $3, $4)
dnl    $1 - argument name-with-dashes          e.g. nonstd-name-pattern
dnl    $2 - argument name_with_underscores     e.g. nonstd-name_pattern
dnl    $3 - explanation fragment               e.g. Non-Standard NAME stuff
dnl    $4 - the autoconf name for $1, they map illegal characters to _ (underscore)
dnl         we will map what autoconf finds at $4 to $2, a name we like better
dnl
dnl e.g.
dnl
dnl    $1 = ares
dnl    $2 = ares
dnl    $3 = ...some messaging...
dnl    $4 = ares
dnl
dnl    $1 = microhttpd++ <----------------- invalid identifier
dnl    $2 = microhttpdpp <----------------- we wish to use this
dnl    $3 = ...some messaging...
dnl    $4 = microhttpd__ <------------------ autoconf does this, we may use something else.
dnl
AC_DEFUN([HGTWinternal_WITH_ADHOC_GUARDED], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    ifelse([$1], [],
           [AC_MSG_ERROR([empty argument 1, [HGTWinternal]_[WITH]_[ADHOC]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$2], [],
           [AC_MSG_ERROR([empty argument 2, [HGTWinternal]_[WITH]_[ADHOC]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$3], [],
           [AC_MSG_ERROR([empty argument 3, [HGTWinternal]_[WITH]_[ADHOC]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$4], [],
           [AC_MSG_ERROR([empty argument 4, [HGTWinternal]_[WITH]_[ADHOC]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
        HGTWinternal_WITH_UNGUARDED_CALL_ONLY_FROM_GUARDED([$1], [$2], [$3], [$4])
    ]) ]) ]) ])
])

dnl
dnl HGTWinternal_WITH_NONSTD_GUARDED(name-dashes, name_underscores, [explanation], name_autoconf)
dnl HGTWinternal_WITH_NONSTD_GUARDED($1, $2, $3, $4)
dnl    $1 - argument name-with-dashes          e.g. nonstd-name-pattern
dnl    $2 - argument name_with_underscores     e.g. nonstd-name_pattern
dnl    $3 - explanation fragment               e.g. Non-Standard NAME stuff
dnl    $4 - the autoconf name for $1, they map illegal characters to _ (underscore)
dnl         we will map what autoconf finds at $4 to $2, a name we like better
dnl
dnl e.g.
dnl
dnl    $1 = nonstd-boost
dnl    $2 = nonstd_boost
dnl    $3 = ...some messaging...
dnl    $4 = nonstd_boost
dnl
dnl    $1 = nonstd-mysql++ <----------------- invalid identifier
dnl    $2 = nonstd_mysqlpp <----------------- we wish to use this
dnl    $3 = ...some messaging...
dnl    $4 = nonstd_mysql__ <------------------ autoconf does this, we may use something else.
dnl
AC_DEFUN([HGTWinternal_WITH_NONSTD_GUARDED], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    ifelse([$1], [],
           [AC_MSG_ERROR([empty argument 1, [HGTWinternal]_[WITH]_[NONSTD]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$2], [],
           [AC_MSG_ERROR([empty argument 2, [HGTWinternal]_[WITH]_[NONSTD]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$3], [],
           [AC_MSG_ERROR([empty argument 3, [HGTWinternal]_[WITH]_[NONSTD]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([$4], [],
           [AC_MSG_ERROR([empty argument 4, [HGTWinternal]_[WITH]_[NONSTD]_[GUARDED]({$1}, {$2}, {$3}, {$4})])], [
    ifelse([nonstd/nonstd/nonstd],
           m4_bpatsubst([$1], [^nonstd-.*], [nonstd])/m4_bpatsubst([$2], [^nonstd_.*], [nonstd])/m4_bpatsubst([$4], [^nonstd_.*], [nonstd]), [
        #
        # The ./configure command line contained
        #   --enable-$1     e.g. --enable-nonstd-boost
        #
        #  Diagnosis: the luser is invalid.
        #     Reason: lusers are sloppy.
        #  Treatment: disallow
        #        Why: the luser needs punishment.
        # Who[Fixes]: the luser, the caller of ./configure
        #    Suggest: call ./configure correctly as --with-$1=VALUE or --without-$1 
        #
        AC_ARG_ENABLE([$1],
                      [AS_HELP_STRING([--enable-$1], [ERROR use --with-$1=ROOT])],
                      [AC_MSG_ERROR([use --with-$1=ROOT, e.g. --with-$1=${prefix:-ROOT}])])
        HGTWinternal_WITH_UNGUARDED_CALL_ONLY_FROM_GUARDED([$1], [$2], [$3], [$4])
    ], [
        dnl This error indicates a mis-coded call within this file.
        dnl, all of $1, $2, $4 must begin with "nonstd"
        AC_MSG_ERROR([must use "nonstd-" prefix in [HGTWinternal]_[WITH]_[NONSTD]_[GUARDED]])
    ]) ]) ]) ]) ])
])

dnl
dnl HGTWinternal_WITH_UNGUARDED_CALL_ONLY_FROM_GUARDED($1, $2, $3, $4)
dnl
dnl    $1 - argument name-with-dashes          e.g. nonstd-name-pattern
dnl    $2 - argument name_with_underscores     e.g. nonstd-name_pattern
dnl    $3 - explanation fragment               e.g. Non-Standard NAME stuff
dnl    $4 - the autoconf name for $1, they map illegal characters to _ (underscore)
dnl         we will map what autoconf finds at $4 to $2, a name we like better
dnl
dnl Just that: only call from the functions named *_GUARDED($1, $2, $3, $4)
dnl
AC_DEFUN([HGTWinternal_WITH_UNGUARDED_CALL_ONLY_FROM_GUARDED], [
    ifelse([$4], [], [
        dnl The 4th argument was omitted.  Find the call site and fix that.
        AC_MSG_WARN([see [HGTWinterna]_[WITH]_[NONSTD]_[GUARDED](m4_changequote([{], [}])[$1], [$2], [$3], [$4]m4_changequote({[}, {]}))])
        AC_MSG_ERROR([invalid call within [HGTW]_[WITH]_[NONSTD](m4_changequote([{], [}])[$1], [$2], [$3]m4_changequote({[}, {]}))]) 
    ], [
        AC_ARG_WITH([$1],
                    [AS_HELP_STRING([--without-$1], [without the $1 subsystem])])
        AC_MSG_CHECKING([non-standard subsystem $1])
        if test "x$with_$4" = "xno" ||
           test "x$with_$4" = "xNONE" ||
           test "x$with_$4" = "x"
        then
            AC_MSG_RESULT([no])
            unset $2_prefix
        elif test "x$with_$4" = "xyes"
        then
            AC_MSG_RESULT([FAIL])
            AC_MSG_ERROR([--with-$1=ROOT must specify a path but --with-$1=${with_$4?} appears])
        else
            AC_MSG_RESULT([${with_$4?}])
            $2_prefix=${with_$4?}
        fi
        HGTW_MSG_VERBOSE([acting as if presented with --with-$1=${with_$4:-no}, making that choice explicit for possible recursion])
        HGTW_APPEND_SUBCONFIGURE_ARGUMENT([--with-$1], [${$2_prefix:-no}])
        if test x != x${$2_prefix}
        then
            HGTWinternal_WITH_PREFIX_IS_SET_CHECK_AND_ACT([$1], [$2], [$3], [$4])
        fi
        with_module_accretion_list="$with_module_accretion_list $1" # for use in [HGTW]_[FINALIZE]
        AC_SUBST($2_prefix)
        AC_SUBST($2_bindir)
        AC_SUBST($2_includedir)
        AC_SUBST($2_libdir)
        AC_SUBST($2_CPPFLAGS)
        AC_SUBST($2_CFLAGS)
        AC_SUBST($2_CXXFLAGS)
        AC_SUBST($2_LDFLAGS)
        AC_SUBST($2_PKG_CONFIG_PATH)
    ])
])

dnl
dnl HGTW_WITH_PREFIX_IS_SET_CHECK_AND_ACT($1, $2, $3, $4)
dnl
dnl    $1 - argument name-with-dashes          e.g. nonstd-name-pattern
dnl    $2 - argument name_with_underscores     e.g. nonstd-name_pattern
dnl    $3 - explanation fragment               e.g. Non-Standard NAME stuff
dnl    $4 - the autoconf name for $1, they map illegal characters to _ (underscore)
dnl         we will map what autoconf finds at $4 to $2, a name we like better
dnl
dnl Postconditions:
dnl
dnl   Sets the following variables
dnl
dnl     $2_CPPFLAGS
dnl     $2_CFLAGS
dnl     $2_CXXFLAGS
dnl     $2_LDFLAGS
dnl
dnl Same arguments as
dnl HGTWinternal_WITH_UNGUARDED_CALL_ONLY_FROM_GUARDED($1, $2, $3, $4)
dnl
AC_DEFUN([HGTWinternal_WITH_PREFIX_IS_SET_CHECK_AND_ACT], [
    #
    # Whereas $2_prefix is set, we must check it and act upon it.
    #
    if ! test -d ${$2_prefix?}
    then
        AC_MSG_ERROR([no directory ${$2_prefix} exists for --with-$1=${$2_prefix?}])
    fi

    {
        $2_bindir=${$2_prefix?}/bin
        if test ! -d ${$2_bindir?}
        then
            # just a notice, not a warning
            AC_MSG_WARN([the directory ${$2_bindir?} is missing])
        fi
        HGTW_MSG_VERBOSE([using (executable) path ${$2_bindir?}])
    }; {
        $2_includedir=${$2_prefix?}/include
        if test ! -d ${$2_includedir?}
        then
            AC_MSG_WARN([the directory ${$2_includedir?} is missing])
        fi
        HGTW_MSG_VERBOSE([using searchpath ${$2_includedir?}])
    }; {
        $2_libdir=${$2_prefix?}/lib64
        AC_MSG_CHECKING([for a separable 64-bit library area])
        if test -d ${$2_libdir?}
        then
            AC_MSG_RESULT([yes])
        else
            AC_MSG_RESULT([no])
            $2_libdir=${$2_prefix}/lib
            if test ! -d ${$2_libdir?}
            then
                AC_MSG_WARN([the directory ${$2_libdir?} is missing])
            fi
        fi
        HGTW_MSG_VERBOSE([using loadpath ${$2_libdir?}])
    }; {
        $2_PKG_CONFIG_PATH=${$2_libdir?}/pkgconfig
        AC_MSG_CHECKING([for a pkgconfig area])
        if ! test -d ${$2_PKG_CONFIG_PATH?}
        then
             AC_MSG_RESULT([no])
             AC_MSG_NOTICE([the directory ${$2_PKG_CONFIG_PATH?} is missing])
             AC_MSG_NOTICE([apparently $1 does not use the pkgconfig system])
         else
             AC_MSG_RESULT([yes])
             HGTW_MSG_VERBOSE([the pkgconfig path will include ${$2_PKG_CONFIG_PATH?}])
             # WATCHOUT - these things can have funky names ... (with dangerous shell metachars?)
             __nonstd_pkgconfig_file="m4_bpatsubst([$1], [^nonstd-], []).pc"
             __nonstd_pkgconfig_path="${$2_libdir?}/pkgconfig/${__nonstd_pkgconfig_file?}"
             AC_MSG_CHECKING([for a pkgconfig file named ${__nonstd_pkgconfig_file?}])
             if test ! -f "${__nonstd_pkgconfig_path?}"
             then
                 AC_MSG_RESULT([no])
             else
                 AC_MSG_RESULT([yes])
                 dnl Being "with" the nonstandard subsystem does not mean that it is checked and ready.
                 dnl See the separable CHECK directives, e.g.
                 dnl SCOLD_CHECK_{ BOOST, CPPUNIT, CURL, CURLPP, JSONCPP, MYSQL (MYSQLPP), SQLITE, UUID }
                 HGTW_MSG_VERBOSE([not loading the pkg-config ${__nonstd_pkgconfig_file?}, just yet])
             fi
        fi
    }
    HGTW_MSG_VERBOSE([using loadpath ${$2_libdir?}])
    # WATCHOUT - these things can have funky names ... (with dangerous shell metachars?)
    __nonstd_pkgconfig_file="m4_bpatsubst([$1], [^nonstd-], [])"
    __nonstd_pkgconfig_path="${$2_libdir}/pkgconfig/${__nonstd_pkgconfig_file?}"
    AC_MSG_CHECKING([for a pkgconfig file named ${__nonstd_pkgconfig_file?}])
    if test ! -f "${__nonstd_pkgconfig_path?}"
    then
        AC_MSG_RESULT([no])
    else
        AC_MSG_RESULT([yes])
    fi
    nonstd_cppflags=""
    nonstd_cflags=""
    nonstd_cxxflags=""
    nonstd_ldflags=""
    case $1 in
    ( nonstd-gcc )
        dnl We "enable" the features of gcc separately.
        dnl The flags and searchpath for gcc are SCOLD_ENABLE_GCC, nearby
        dnl NOT HERE ---> nonstd_cxxflags="-std=c++1z -fconcepts"
        ;;
    ( * )
        dnl Being "with" the nonstandard subsystem does not mean that it is checked and ready.
        dnl See the separable CHECK directives, e.g.
        dnl SCOLD_CHECK_{ BOOST, CPPUNIT, CURL, CURLPP, JSONCPP, MYSQL (MYSQLPP), SQLITE, UUID }
        HGTW_MSG_VERBOSE([not loading the pkg-config ${__nonstd_pkgconfig_file?}, just yet])
        ;;
    esac
    #
    # These variables are now available "as a resource"
    # They are not yet entrained into the compilation flow.
    #
    # See the Makefile.am stanza around PACKAGE, CHECK and AND_CHECK ${TOOL}FLAGS_SET
    # Also
    #   nonstd_${COMPONENT}_${TOOL}FLAGS     established herein
    #   ${TOOL}FLAGS_${COMPONENT}            established by SCOLD_CHECK_${COMPONENT}
    #
    $2_CPPFLAGS="-I${$2_includedir?}${nonstd_cppflags:+ ${nonstd_cppflags}}"
    $2_CFLAGS="${nonstd_cflags?}"
    $2_CXXFLAGS="${nonstd_cxxflags?}"
    # the -L and -rpath are both individually & separately required
    # also equivalent is "-Xlinker -rpath=${$2_libdir}"
    $2_LDFLAGS="-L${$2_libdir?} -Wl,-rpath -Wl,${$2_libdir?}${nonstd_ldflags:+ ${nonstd_ldflags}}"
])
