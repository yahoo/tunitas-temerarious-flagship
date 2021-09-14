dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HT_CHECK_MYSQL      (and no arguments)
dnl HT_CHECK_MARIADB    (same thing, and still no arguments)
dnl
dnl [[deprecated]] HGTW_CHECK_MYSQL       s/HGTW/HT/
dnl [[deprecated]] HGTW_CHECK_MARIADB     ibidem.
dnl [[deprecated]] HGTW_CHECK_MYSQLPP     ibidem
dnl [[deprecated]] SCOLD_CHECK_MYSQL      s/SCOLD/HT/
dnl [[deprecated]] SCOLD_CHECK_MARIADB    ibidem.
dnl [[deprecated]] SCOLD_CHECK_MYSQLPP    ibidem
dnl
dnl WATCHOUT - we supply ALL THREE POSSIBILITIES because nobody remembers which is which
dnl
dnl            MariaDB == MySQL
dnl            mysql++ is mysql because C++ is "The New C" (as far as we're concerned)
dnl
dnl MYSQL
dnl MYSQLPP
dnl MARIADB
dnl
dnl BAD --- mysql++-devel-3.2.3    is hard-coded to C++11 with dynamic exception specifications (following Java's stylings)
dnl GOOD -- mysql++-devel-3.2.4    C++17 capable with some confounding hacks for doxygen
dnl
dnl SUBST for use in a Makefile
dnl 
dnl     CPPFLAGS_mysql         NOT DEFINED --->  @CPPFLAGS_mysqlpp@ <--- NO SUCH
dnl     CFLAGS_mysql           NOT DEFINED --->  @CFLAGS_mysqlpp@ <----- NO SUCH
dnl     CXXFLAGS_mysql         NOT DEFINED --->  @CXXFLAGS_mysqlpp@ <--- NO SUCH
dnl     LDFLAGS_mysql          NOT DEFINED --->  @LDFLAGS_mysqlpp@ <---- NO SUCH
dnl

dnl ----------------------------------------------------------------------------------------------------

AC_DEFUN([SCOLD_CHECK_MYSQLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_MYSQLPP], [HT_[CHECK]_MYSQLPP])
    HT_CHECK_MYSQLPP
])
AC_DEFUN([HGTW_CHECK_MYSQLPP], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_MYSQLPP], [HT_[CHECK]_MYSQLPP])
    HT_CHECK_MYSQLPP
])
AC_DEFUN([HT_CHECK_MYSQLPP], [
  AC_MSG_NOTICE([there is no [HGTW]_[CHECK]_[MYSQLPP]; there is no special check for mysql++])
  AC_MSG_WARN([use [HGTW]_[CHECK]_[MYSQL] instead of [HGTW]_[CHECK]_[MYSQLPP] (read: MYSQL not MYSQLPP)])
  HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB
])

dnl Because when Oracle captured MySQL, the culture found a way to escape
dnl The FOSS world hsa standardized on MariaDB nowadays, but the old brand name persists.
AC_DEFUN([SCOLD_CHECK_MYSQL], [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])
AC_DEFUN([HGTW_CHECK_MYSQL],  [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])
AC_DEFUN([HT_CHECK_MYSQL],    [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])

AC_DEFUN([SCOLD_CHECK_MARIADB], [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])
AC_DEFUN([HGTW_CHECK_MARIADB],  [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])
AC_DEFUN([HT_CHECK_MARIADB],    [HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB])

dnl HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB
dnl emit that deprecation warning and then on to the main course
AC_DEFUN([HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([$1], [$2])
    HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB
])

dnl HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB  (no arguments)
dnl
dnl e.g. on Fedora 19 one can find
dnl     mysql++-3.1.0-12.fc19.x86_64
dnl     mysql++-devel-3.1.0-12.fc19.x86_64
dnl     mysql++-manuals-3.1.0-12.fc19.x86_64
dnl     mariadb-5.5.39-1.fc19.x86_64
dnl     mariadb-devel-5.5.39-1.fc19.x86_64
dnl     mariadb-libs-5.5.39-1.fc19.x86_64
dnl
dnl Validates that mysql++-devel (mysql++) is available.
dnl
dnl Reminder: there is no pkg-config for either mysql++ or mariadb
dnl
dnl Postcondition: (the following are set)
dnl
dnl     CPPFLAGS_mysql
dnl     CFLAGS_mysql
dnl     CXXFLAGS_mysql
dnl     LDFLAGS_mysql
dnl
AC_DEFUN([HGTWinternal_CHECK_ORACLE_MYSQL_ESCAPED_AS_MARIADB], [
    AC_REQUIRE([HGTW_WITH_NONSTD_MYSQL])
    AC_REQUIRE([HGTW_ENABLE_RPM_PACKAGE_CHECKING])
    if test 1 = ${rpm_package_checking:-1} ; then
        # mysqlpp as established in check-nonstd.m4 NOT mysql__ as is used by autoconf
        if test -n "${nonstd_mysqlpp_prefix}" ; then
            if ! rpm -q nonstd-mysql++-devel 2>/dev/null ; then
                AC_MSG_ERROR([nonstd-mysql++-devel is required])
            fi
        else
            if ! rpm -q mysql++-devel 2>/dev/null ; then
                AC_MSG_ERROR([mysql++-devel is required])
            fi
        fi
        if ! rpm -q mariadb-devel 2>/dev/null ; then
            AC_MSG_ERROR([mariadb-devel is required])
        fi
    fi
    HGTWinternal_PROVE_MYSQLPP_USES_ENOUGH_MODERN_CXX
    if type -p mysql_config > /dev/null 2>&1 ; then
        # indeed, do the work twice to get fidelity on the error code
        mysql_config_sh=$(type -p mysql_config)
    elif test none != "${MYSQL_CONFIG:-none}" ; then
        mysql_config_sh=${MYSQL_CONFIG?}
    elif test -x /usr/bin/mysql_config ; then
        # Fedora 24 has mariadb-devel-10.1.21-3.fc24.x86_64 and only /usr/bin/mysql_config
        # let sanity prevail
        #
        mysql_config_sh=/usr/bin/mysql_config
    else
        # Fedora 19 has mariadb-5.5.39-1.fc19.x86_64 and all of 
        #
        #     /usr/bin/mysql_config -> /etc/alternatives/mysql_config
        #     /etc/alternatives/mysql_config -> /usr/lib64/mysql/mysql_config
        #
        __lib=$(if test /lib64 ; then echo lib64 ; else echo lib ; fi)
        mysql_config_sh=/usr/${__lib:-lib}/mysql_config
    fi
    if ! test -x ${mysql_config_sh?} ; then
        AC_MSG_NOTICE([use MYSQL_CONFIG=/path/.../mysql_config to override])
        AC_MSG_ERROR([cannot find mysql_config anywhere reasonable])
    fi
    HGTW_MSG_VERBOSE([found the MySQL (MariaDB) configurator ${mysql_config_sh?}])
    # You are going to have to use mysql_config here.
    # There is no pkg-config for mariadb or mysql, you have to use theirs.
    #
    # NASTY! - mysql++ requires -I/usr/include/mysql
    # wherein
    #    /usr/include/mysql++/common.h
    #    #include <mysql_version.h>
    # and yet
    #    /usr/include/mysql/mysql_version.h
    #
    mysql_config_includes=$($mysql_config_sh --include)
    test 0 == $? || AC_MSG_ERROR([cannot run $mysql_config_sh --include])
    # do not use --cflags as it appears to be how one might compile MySQL (MariaDB) server.
    # it doesn't seem relevant for the client side.
    # also, it has conflicting & poisonous compiler options (see for yourself)
    AC_MSG_NOTICE([ignoring the options from $mysql_config_sh --cflags])
    DO_NOT_USE_mysql_config_cflags=$($mysql_config_sh --cflags)
    test 0 == $? || AC_MSG_ERROR([cannot run $mysql_config_sh --cflags])
    mysql_config_libs=$($mysql_config_sh --libs)
    # choose the reentrant, multithreaded variant ... why not?
    test 0 == $? || AC_MSG_ERROR([cannot run $mysql_config_sh --libs_r])
    CPPFLAGS_mysql="${mysql_config_includes}"
    AC_SUBST(CPPFLAGS_mysql) 
    CFLAGS_mysql="${mysql_config_cflags}"
    AC_SUBST(CFLAGS_mysql) 
    CXXFLAGS_mysql="${mysql_config_cflags}"
    AC_SUBST(CXXFLAGS_mysql) 
    # erg why, oh why do they put the libraries in a subdirectory?
    LDFLAGS_mysql="-lmysqlpp ${mysql_config_libs}"
    AC_SUBST(LDFLAGS_mysql) 
])

dnl
dnl HGTWinternal_PROVE_MYSQLPP_USES_ENOUGH_MODERN_CXX
dnl
dnl [[FIXTHIS]] should use the compiler to prove that the header files actually function
dnl Instead use a crude grep for the known offensive pattern of pre-C++17 dynamic exceptions.
dnl
dnl Postcondition: we're good
dnl
AC_DEFUN([HGTWinternal_PROVE_MYSQLPP_USES_ENOUGH_MODERN_CXX], [
    AC_REQUIRE([HGTW_WITH_NONSTD_MYSQLPP])
    #
    # if we're going to build nonstd, then it has to have all the patches.
    # the nonstd series starts with sufficient patching at release 9
    # e.g. BuildRequires: nonstd-mysql++-devel >= 3.2.3-9.1z
    # Else you will see
    #
    # In file included from /usr/include/mysql++/manip.h:47,
    #                  from ../../modules/mysqlpp.quote_type1:3,
    #                  from each/mysqlpp.quote_type1.cpp:1:
    # /usr/include/mysql++/stadapter.h:224:29: error: ISO C++17 does not allow dynamic exception specifications
    #   char at(size_type i) const throw(std::out_of_range);
    #                              ^~~~~
    if test -n "$nonstd_mysqlpp_prefix"
    then
        __includedir="${nonstd_mysqlpp_prefix?}/include/mysql++"
    else
        # the "standard" location of the install
        __includedir="/usr/include/mysql++"
    fi 
    if test ! -d "${__includedir?}"
    then
        AC_MSG_ERROR([failed to find mysql++ interfaces in ${includedir?}])
    fi
    AC_MSG_CHECKING([if mysql++ still uses dynamic exception specifications])
    #
    # Here we hack it.  Instead of running the compiler on every single header file to see if they work in C++23
    # we grep for known problems.  But there are cases where the grep solution is known-wrong  (false negative).
    # These are cases where the mysql++ authors are hacking around bugs/omissions/misfeatures in doxygen, a documentation.
    #
    # To wit: /usr/include/mysql++/stadapter.h circa 3.2.4
    #
    #   if !defined(DOXYGEN_IGNORE) && __cplusplus >= 201703L
    #       // Can't use MAY_THROW() here: it confuses Doxygen 1.8.14.
    #   	char at(size_type i) const noexcept(false);
    #   #else
    #   	char at(size_type i) const throw(std::out_of_range);
    #   #endif
    #
    # so ignore stladapter.h and *hope* the test of the testing works out
    # or get a better mysql++-devel
    #
    if grep -qe "noexcept *( *false *)" `find ${__includedir?} -name '*.h' ! -name stadapter.h -print` < /dev/null
    then
        AC_MSG_RESULT([no])
    else
        AC_MSG_RESULT([yes])
        AC_MSG_NOTICE([the mysql++ interfaces are at ${__includedir?}])
        AC_MSG_NOTICE([ISO C++17 does not allow dynamic exception specifications])
        AC_MSG_NOTICE([mysql++-3.2.4 was observed to have corrected this problem])
        AC_MSG_ERROR([the mysql++ is too old, it still uses dynamic exception specifications])
    fi
])
