dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl Usage:
dnl
dnl HGTW_CHECK_PACKAGE([this.Thing], [that-devel], [This Thing in That Package])
dnl
dnl When you need to
dnl      #import this.Thing
dnl
dnl You should have performed
dnl      sudo dnf install that-devel
dnl
dnl By convention the '-devel' suffix is NOT computed from the name because ... it might or might not be
dnl part of the package's naming convention at all. (some traditions use "-dev" or "_dev"" suffixes).
dnl
dnl The plural variant works the same except ... with a plurality of this.Thing which MUST be in a
dnl (single) package named that-devel.
dnl

dnl ----------------------------------------------------------------------------------------------------

dnl HGTW_CHECK_PACKAGE(module-name, devel-package-name)
dnl HGTW_CHECK_PACKAGE(module-name, devel-package-name, package-title)
dnl
dnl Exactly like HGTW_CHECK_PACKAGEs ... the plural one ... except only a single module may be supplied.
dnl This As with AC_CHECK_HEADER(...) versus AC_CHECK_HEADERS(...)
dnl
dnl Usage, etc.  see HGTW_CHECK_PACKAGES
dnl
dnl                        dnf install module-boost-devel
dnl                                    |
dnl             #import boost          |
dnl                     |              |                     An explanation, a title
dnl                     |              |                     |
dnl                     v              v                     v
dnl HGTW_CHECK_PACKAGE([boost],       [module-boost-devel], [The Boost Mega-Package])
dnl HGTW_CHECK_PACKAGE([va.arg],      [module-c-devel], [The POSIX Variable Arguments])
dnl HGTW_CHECK_PACKAGE([std.is_same], [module-std-devel], [The C++ Type Sameness Predicate])
dnl
AC_DEFUN([HGTW_CHECK_PACKAGE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_PACKAGE], [HT_[CHECK]_PACKAGE])
    HT_CHECK_PACKAGE
])
AC_DEFUN([HGTW_CHECK_PACKAGE], [
    dnl [[FIXTHIS]] this is a cut & paste of HGTW_CHECK_PACKAGES but s/HEADERS/HEADER/g
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    AC_REQUIRE([HGTW_WITH_STD_SCOLD])
    __CPPFLAGS="$CPPFLAGS"
    CPPFLAGS="-I${std_scold_prefix?}/modules -I${std_scold_prefix?}/include"
    AC_CHECK_HEADER([$1],
                    [ : ok found ],
                    [
                        dnl grammar here is difficult as $3 may be empty; but also $1 may be single or several (so plural).
                        HGTW_MSG_WARNING([cannot find the modules ifelse([$3], [], [around $1], [of $3])])
                        HGTW_MSG_WARNING([consider: dnf install $2])
                        dnl [[FIXTHIS]] a way to disable this as a hard error from the command line
                        HGTW_MSG_WARNING([cannot proceed without $2])
                    ])
    CPPFLAGS="$__CPPFLAGS"
    unset __CPPFLAGS
])

dnl
dnl HGTW_CHECK_PACKAGES(module-name-list, devel-package-name)
dnl HGTW_CHECK_PACKAGES(module-name-list, devel-package-name, package-title)
dnl
dnl Wherein
dnl   module-name-list    ::= a list of S.C.O.L.D. modules as you would name them in an #import statement
dnl   devel-package-name  ::= a single RPM package name as you would install it with dnf
dnl
dnl Examples
dnl
dnl   module-name-list
dnl     [std.is_same]                        ... a list of one S.C.O.L.D. module
dnl     [nonstd]                             ... ibidem
dnl     [sys.exits.Code sys.posix.open]      ... a list of two S.C.O.L.D. modules (both will have to be present appear)
dnl
dnl   devel-package-name
dnl     [module-std-devel]                   ... the name of the rpm package that you should install
dnl     [module-dnl-devel]                   ... ibidem
dnl     [module-sys-devel]                   ... these names are used in messaging, they are not probed with rpm -q
dnl
dnl   package-title
dnl
dnl     The Standard Library
dnl     The Non-Standard Library
dnl     The Tunias Basic Components
dnl     The MySQL C++ API
dnl     The cURL C++ API
dnl
dnl For grammatical niceness, you will likely feel the need for an article in package-title
dnl but that may not be relevant so we are not supplying it for you in $3 package-title
dnl
dnl The check does not test whether the named rpm package is actually installed.
dnl The check attempts to compile a program that uses the S.C.O.L.D. module (its C++ #include header)
dnl and based upon the failure of that test then emits the error and quits.
dnl
dnl Usage:
dnl
dnl                               dnf install module-std-devel
dnl                                           |
dnl                #import std                |
dnl                #import std.is_same        |
dnl                        |   |              |
dnl                        v   v              v
dnl   HGTW_CHECK_PACKAGES([std std.is_same], [module-std-devel], [The Standard C++ Library])
dnl   HGTW_CHECK_PACKAGES([nonstd], [module-nonstd-devel], [The Non-Standard C++ Library])
dnl   HGTW_CHECK_PACKAGES([mysqlpp], [module-mysql-devel])
dnl   HGTW_CHECK_PACKAGES([curlpp], [module-curl-devel])
dnl
AC_DEFUN([HGTW_CHECK_PACKAGES], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_PACKAGES], [HT_[CHECK]_PACKAGES])
    HT_CHECK_PACKAGES([$1], [$2], [$3])
])
AC_DEFUN([HGTW_CHECK_PACKAGES_WARN], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_PACKAGES_[WARN]], [HT_[CHECK]_PACKAGES_[WARNING]])
    HT_CHECK_PACKAGES_WARNING([$1], [$2], [$3])
])
AC_DEFUN([HGTW_CHECK_PACKAGES_WARNING], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_PACKAGES_[WARNING]], [HT_[CHECK]_PACKAGES_[WARNING]])
    HT_CHECK_PACKAGES_WARNING([$1], [$2], [$3])
])
AC_DEFUN([HGTW_CHECK_PACKAGES_ERROR], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HGTW_[CHECK]_PACKAGES_[ERROR]], [HT_[CHECK]_PACKAGES_[ERROR]])
    HT_CHECK_PACKAGES_ERROR([$1], [$2], [$3])
])
AC_DEFUN([HT_CHECK_PACKAGES], [
    dnl no deprecation warning here because we intend that "the default is to gently warn"
    HT_CHECK_PACKAGES_WARNING([$1], [$2], [$3])
])
AC_DEFUN([HGTW_CHECK_PACKAGES_WARN], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([HT_[CHECK]_PACKAGES_[WARN]], [HT_[CHECK]_PACKAGES_[WARNING]])
    HT_CHECK_PACKAGES_WARNING([$1], [$2], [$3])
])
AC_DEFUN([HT_CHECK_PACKAGES_WARNING], [
    HTinternal_CHECK_PACKAGES_CANNOT_PROCEED([$1], [$2], [$3], [
       HT_MSG_WARNING([can proceed without $2, but there may be errors])
    ])
])
AC_DEFUN([HT_CHECK_PACKAGES_ERROR], [
    HTinternal_CHECK_PACKAGES_CANNOT_PROCEED([$1], [$2], [$3], [
       HT_MSG_ERROR([cannot proceed without $2, you MUST install $3])
    ])
])
dnl
dnl $1 - module import names    minimum 1, optionally plural    suitable for use with #import .... e.g. std.variant
dnl $2 - package names          miminum 1, optionally plural    suitable for use with dnf ........ e.g. module-nonstd-devel
dnl $3 - descriptive name       multiple words                  e.g.  The Non-Standard Library, module-nonstd >= 3.9.8
dnl $4 - codefrag               shell                           e.g. HT_MSG_ERROR(...), HT_MSG_WARNING(...)
dnl
AC_DEFUN([HTinternal_CHECK_PACKAGES_CANNOT_PROCEED], [
    AC_REQUIRE([HGTW_COMPONENT_METADIRECTORY_TIERS])
    AC_REQUIRE([HGTW_WITH_STD_SCOLD])
    ifelse([$1], [],
           [AC_MSG_ERROR([empty argument 1, [HTinternal]_[CHECK]_[PACKAGES]_[CANNOT_PROCEED]({$1}, {$2}, {$3}, {$4})])],
           [ifelse([$2], [],
                   [AC_MSG_ERROR([empty argument 2, [HTinternal]_[CHECK]_[PACKAGES]_[CANNOT_PROCEED]({$1}, {$2}, {$3}, {$4})])],
                   [ifelse([$3], [],
                           [AC_MSG_ERROR([empty argument 2, [HTinternal]_[CHECK]_[PACKAGES]_[CANNOT_PROCEED]({$1}, {$2}, {$3}, {$4})])],
                           [__CPPFLAGS="$CPPFLAGS"
                            dnl Reminder: this will not work out well if you are using the development options to specify locations other than --with-std-tunitas=DIR and --with-std-scold=DIR
                            dnl e.g. if you have a special feature in /build/tunitas/basics and you use --with-tunitas-basics=/build/tunitas/basics
                            CPPFLAGS="${std_tunitas_prefix:+-I$std_tunitas_prefix/modules -I$std_tunitas_prefix/include} ${std_scold_prefix:+-Istd_scold_prefix/modules -I$std_scold_prefix/include}"
                            AC_CHECK_HEADERS([$1],
                                             [ : ok found ],
                                             [
                                                 dnl grammar here is difficult as $3 may be empty; but also $1 may be single or several (so plural).
                                                 HGTW_MSG_WARNING([cannot find the modules ifelse([$3], [], [around $1], [of $3])])
                                                 HGTW_MSG_WARNING([consider: dnf install $2])
                                                 dnl expect [$]4 to be a fragment of ERROR or WARNING code
                                                 $4 dnl [[FIXTHIS]] a way to disable this as a hard error from the command line
                                             ])
                            CPPFLAGS="$__CPPFLAGS"
                            unset __CPPFLAGS
])])])])
