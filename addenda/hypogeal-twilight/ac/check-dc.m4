dnl Of course this is -*- m4 -*- to be processed by aclocal and autoconf
dnl For terms and provenance see the LICENSE file at the top of this repository.
dnl
dnl HGTW_PROG_DC     [[preferred]]       (no arguments)
dnl HGTW_CHECK_DC                        (no arguments)
dnl
dnl Deprecating:
dnl   HGTW_CHECK_REMONSTRATE             (no arguments)
dnl   SCOLD_CHECK_REMONSTRATE            (no arguments)
dnl
dnl Prove that a disaggregation compiler exists
dnl This defaults to 'remonstrate' the 2nd generation SCOLD disaggregation compiler) exists.
dnl Observe the DC environment variable as does .../mk/compile.mk
dnl
dnl See, nearby:
dnl
dnl   anguish-answer ........................... available yesterday and tomorrow (a rudimentary DC)
dnl   baleful-ballad ........................... available today
dnl   ceremonial-contortion .................... some day.
dnl   demonstratable-deliciousness ............. some day
dnl
dnl Environment:
dnl
dnl   /opt/scold                the "standard" "production" version of remonstrate
dnl   /opt/scold/bootstrap      the bootstrapped variant
dnl 

dnl ----------------------------------------------------------------------------------------------------

dnl
dnl [[deprecated]] HGTW_CHECK_REMONSTRATE      (no arguments)
dnl [[deprecated]] SCOLD_CHECK_REMONSTRATE     (no arguments)
dnl
AC_DEFUN([SCOLD_CHECK_REMONSTRATE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([[SCOLD]_[CHECK]_[REMONSTRATE]],
                        [[HGTW]_[CHECK]_[DC]])
    HGTW_CHECK_DC
])
AC_DEFUN([HGTW_CHECK_REMONSTRATE], [
    AC_REQUIRE([HGTW_ENABLE_DEPRECATION_NOTIFICATION])
    HGTW_MSG_DEPRECATED([[HGTW]_[CHECK]_[REMONSTRATE]],
                        [[HGTW]_[CHECK]_[DC]])
    HGTW_CHECK_DC
])

dnl
dnl HGTW_PROG_DC      (no arguments)
dnl
dnl HGTW_PROG_DC and HGTW_CHECK_DC are basically same thing at this point
dnl
AC_DEFUN([HGTW_PROG_DC], [
    AC_REQUIRE([HGTW_ENABLE_CONFIGURE_VERBOSE])
    AC_REQUIRE([HGTW_WITH_STD_SCOLD])
    AC_REQUIRE([HGTW_WITH_BALEFUL_BALLAD])
    #
    # Don't check the rpm version number for baleful-ballad because
    # 0. an ad hoc compiler might be in play
    # 1. anguish-answer has several generations of compatible alternatives
    # 2. baleful-ballad has a "bootstrap only" package variant for historical reasons
    # 3. ceremonial-contortion can become a compatible alternative
    # 4. demonstratable-deliciousness can become a compatible alternative
    #
    : ${DC:=remonstrate}
    if ! type -p ${DC:-remonstrate} >/dev/null 2>&1 ; then
       AC_MSG_NOTICE([std_scold_prefix is ${std_scold_prefix:-unset}])
       AC_MSG_NOTICE([baleful_ballad_prefix is ${baleful_ballad_prefix:-unset}])
       AC_MSG_NOTICE([is --with-std-scold=ROOT set appropriately?])
       AC_MSG_ERROR([cannot find ${DC:-remonstrate}])
    fi
    if ! ${DC:-remonstrate} --help >/dev/null 2>&1 ; then
       AC_MSG_ERROR([${DC:-remonstrate} fails trivially])
    fi
    dnl [[FIXTHIS]] make it actually do some remonstrate-type work
    AC_SUBST([DC])
    # Enable the warning in HGTW_FINALIZE
    HGTW_PROG_DC_was_called=1
])

dnl
dnl HGTW_CHECK_DC      (no arguments)
dnl
AC_DEFUN([HGTW_CHECK_DC], [
    AC_REQUIRE([HGTW_PROG_DC])
    if ! ${DC:-remonstrate} --help >/dev/null 2>&1 ; then
       AC_MSG_ERROR([cannot run ${DC:-remonstrate}, see config.log])
    fi
    # Enable the warning in HGTW_FINALIZE
    HGTW_CHECK_DC_was_called=1
])
