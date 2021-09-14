dnl
AC_INIT(test-all-defun, 0.0.0, testy@cranky.example.org)
HGTW_INIT(AC_PACKAGE_NAME, AC_PACKAGE_VERSION, AC_PACKAGE_BUGREPORT)

dnl all the possible macros...  in somewhat the correct order

HGTW_COMPONENT_METADIRECTORY_TIERS

# these require some arguments
HGTW_WITH_META_DIRECTORY([meta], [meta], [/opt/meta], [Meta Area])
HGTW_WITH_AMBIENT_COMPONENT([ambience], [ambience], [Ambient Temperature])
HGTW_WITH_COMMON([common], [common], [Common Stuff])
HGTW_WITH_HEREIN([herein], [herein], [Herein Stuff])
HGTW_WITH_MODULE([moddy]) dnl MODUILE only accepts a single argument and presumes moddy -> module-moddy
HGTW_WITH_NONSTD([weird], [weird], [Weird Nonstandard])
HGTW_WITH_SIBLING([sibling], [sibling], [Sibling Stuff])
HGTW_WITH_STD([thing], [thing], [That Standard Thing])

HGTW_WITH_HYPOGEAL_TWILIGHT
HGTW_WITH_INCENDIARY_SOPHIST
HGTW_WITH_NONSTD_GCC
HGTW_WITH_NONSTD_MYSQL
HGTW_WITH_NONSTD_BOOST
HGTW_WITH_NONSTD_CPPUNIT
HGTW_WITH_NONSTD_CURL
HGTW_WITH_NONSTD_CURLPP
HGTW_WITH_NONSTD_JSONCPP
HGTW_WITH_NONSTD_SQLITE
HGTW_WITH_NONSTD_UUID
HGTW_DEFAULT_STD_VALUES
HGTW_WITH_VERNACULAR_DOGGEREL

HGTW_WITH_BOOST_LAYOUT
HGTW_WITH_STD_REGEX
HGTW_ENABLE_BOOST_LAYOUT
HGTW_ENABLE_DEPRECATION_NOTIFICATION
HGTW_ENABLE_GCC
HGTW_ENABLE_GDB
HGTW_ENABLE_GNU
HGTW_ENABLE_MOCK_BUILD
HGTW_ENABLE_RPM_PACKAGE_CHECKING
HGTW_ENABLE_CONFIGURE_VERBOSE
HGTW_ENABLE_CONFIGURE_DEBUG

# We have to be building something; something trivial.
AC_CONFIG_SRCDIR([main.cpp])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_HEADERS([config.h])
AC_PREREQ([2.69])
AM_PROG_AR             dnl first
AC_PROG_LIBTOOL
AC_PROG_CXX
LT_PREREQ([2.4.2])
LT_INIT                dnl second
AC_LANG([C++])
# Checks for tools
HGTW_PROG_DC

HGTW_CHECK_APACHE_HTTPD
HGTW_CHECK_BOOST
HGTW_CHECK_CPPUNIT
HGTW_CHECK_CURL
HGTW_CHECK_CURLPP
HGTW_CHECK_GCC
dnl HGTW_CHECK_JSON -------> ERROR (you can't even call it)
HGTW_CHECK_JSONCPP
HGTW_CHECK_MYSQLPP dnl ----> ERROR /usr/include/mysql++ is known bad
HGTW_CHECK_SQLITE
HGTW_CHECK_UUID
HGTW_CHECK_BOOST_LAYOUT

HGTW_CHECK_STD_FILESYSTEM

# we are not (yet) doing submodule builds here
HGTW_CONFIG_SUBMODULES([submodules], [])

HGTW_CHECK_PACKAGE([std], [module-std-devel])
HGTW_CHECK_PACKAGE([nonstd], [module-nostd-devel], [The Non-Standard C++ Library])

HGTW_MSG_VERBOSE([one arg])
HGTW_MSG_VERBOSE([first message], [second message])
HGTW_MSG_DEPRECATED([that_old_thing])

# output something
HGTW_FINALIZE
