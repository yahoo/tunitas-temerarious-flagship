dnl
dnl ./buildconf && ./configure --prefix=$(dirname $(pwd)) && make check
dnl also see ${prefix}/etc/config.site
dnl
dnl autoreconf --force --verbose --install
dnl autoreconf -vfi
dnl
dnl recall: $prefix/etc/config.site can hold predefined settings
dnl
AC_INIT([tests-simple], [1.0.0], [/dev/null@oath.com])
TF_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

dnl See the AUTOMAKE_OPTIONS in the Makefile.am
AM_INIT_AUTOMAKE
AM_SILENT_RULES([yes])

AC_CONFIG_SRCDIR([src/main.cpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])

TF_COMPONENT_METADIRECTORY_TIERS
TF_ENABLE_GNU
TF_ENABLE_GDB
TF_ENABLE_GCC

TF_WITH_SUBSYSTEM([temerarious-flagship], [], [The Tunitas Build System])
TF_WITH_SUBSYSTEM([hypogeal-twilight], [], [The SCOLD Build System])

TF_WITH_MODULE([std])
TF_WITH_MODULE([cppunit])

TF_MSG_VERBOSE([compiler-specific (alphabetical)])
dnl order matters here, external environments go last; compiler overrides go last
TF_WITH_STD([tunitas])
TF_WITH_STD([scold])
TF_WITH_NONSTD([gcc])

LT_PREREQ([2.4.2])
AM_PROG_AR dnl must be first
LT_INIT    dnl mut be second
AC_PROG_CC
AC_PROG_CXX
AM_PROG_CC_C_O
TF_PROG_DC

datarootdir="${prefix}/share/tunitas"
AC_DEFINE_UNQUOTED([PACKAGE_DATADIR], ["$datarootdir"], [Tunitas read-only architecture-independent area])
AC_SUBST([PACKAGE_DATADIR])

TF_FINALIZE
