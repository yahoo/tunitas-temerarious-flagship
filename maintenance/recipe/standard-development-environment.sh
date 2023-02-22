# This must be sourced not executed (see the usage: examples below)
# Copyright Yahoo Inc.
# Licensed under the terms of the Apache-2.0 license.
# For terms, see the LICENSE file at https://github.com/yahoo/tunitas-basics/blob/master/LICENSE
# For terms, see the LICENSE file at https://git.tunitas.technology/all/components/basics/tree/LICENSE
#
# Usage:
#
#   cd ${0%/*}/.. || exit 70
#   : ${with_build:=/build}
#   : ${with_tunitas_nearby:=${with_build?}/tunitas}
#   : ${with_temerarious_flagship:=${with_tunitas_nearby?}/temerarious-flagship}
#   source ${with_temerarious_flagship?}/maintenance/recipe/standard-development.sh || exit ${EX_SOFTWARE:-70}
#   ...blah blah blah... the rest of the "nearby" build idiom
#   start &&
#   buildconf &&
#   configure &&
#   make &&
#   make check &&
#   finish
#
# the full end-to-end build using the "nearby" development trees
#
#   buildconf
#   configure
#   make [all]
#   make check
#
# Usage:
#
#   ./maintenance/nearby     (no options)
#
#   prefix=/usr/local \
#   with_std_tunitas=/opt/tunitas \
#   with_temerarious_flagship=/opt/tunitas \
#   ./maintenance/nearby
# 
# Common Idioms:
#
#   with_build=/build maintenance/nearby
#
#   with_tunitas_nearby=/build/tunitas \
#   with_scold_nearby=/build/scold \
#   ./maintenance_nearby
#
# ... you get the idea
#
# AVOID submodules at all ---> to build without submodules
# AVOID submodules at all --->
# AVOID submodules at all --->  with_submodules=no ./maintenance/nearby       (this works because --with-THING=no is --without-THING)
# AVOID submodules at all --->
#
# The scold module "with" variables will naturally default to /opt/scold
# The tunitas "with" variables would be expected to be in /opt/tunitas
#
# Debugging the initial buildconf-configure-make
#
#   YOU SEE -----> config.status: executing depfiles commands
#   YOU SEE -----> config.status: error: in `/build/tunitas/butano':
#   YOU SEE -----> config.status: error: Something went wrong bootstrapping makefile fragments
#   YOU SEE ----->     for automatic dependency tracking.  Try re-running configure with the
#   YOU SEE ----->     '--disable-dependency-tracking' option to at least be able to build
#   YOU SEE ----->     the package (albeit without support for automatic dependency tracking).
#   YOU SEE -----> See `config.log' for more details
#
#   YOU RUN -----> enable_dependency_tracking=no ./maintenance/nearby 
#
{
    # Whereas not all development installations will have the preferred $prefix even available for use.
    # Make some judicious choices and guess what might be usable.
    # The policy-concept is that if you're running ./maintenance/nearby then you are a developer-person who is doing mantenance.
    #
    # The alternative is that the developer (that's you dear reader) will have to manually & explicitly make an appropriate choice every rebuild.
    # as follows: (ahem, no, no, don't do your development in /dev, this is an *example()
    #
    #     prefix=/dev/something/something/dark_side ./maintenance/nearby
    #
    for guess in /exp/tunitas /exp/local /usr/local ; do
        if [[ -e $guess ]] ; then
            : ${prefix:=/exp/tunitas}
        fi
    done
}
: ${with_opt:=/opt}
: ${with_exp:=/exp}
: ${with_build:=/build}
{
    #
    # Circa the preparation for Tunitas Release 03, Gnarled Manzanita, we clarified the {usage of { std, opt, exp } as follows:
    # c.f. https://wiki.tunitas.technology/page/Release_03_(Gnarled_Manzanita)
    # Whereas we rely upon the Linux Filesystem Hierarchy Standard (FHS) to guide the layout of the applications and supporting libraries.
    # We transition as follows:
    # "std" has no meaning i the FHS so it is deprecated in this context; prefer "opt"
    # "opt" is the preferred location of production 3rd-party applications (that's us!)
    # "exp" is our invention; it is like /opt but more unsupervised.
    #
    # Thus the compatibility shims of s/std/opt/
    #
    if [[ -n $with_std_tunitas ]] && [[ -z $with_opt_tunitas ]] ; then
        : ${with_opt_tunitas:=$with_std_tunitas}
    else
        : ${with_opt_tunitas:=${with_opt?}/tunitas}
    fi
    if [[ -n $with_std_scold ]] && [[ -z $with_opt_scold ]] ; then
        : ${with_opt_scold:=$with_std_scold}
    else
        : ${with_opt_scold:=${with_opt?}/scold}
    fi
    : ${with_std_tunitas:=${with_opt_tunitas?}}
    : ${with_std_scold:=${with_opt_scold}}
}
: ${with_siblings:=${PWD%/*}}
# The "build" directory is a meta-meta area, e.g. /build, with sublocations for tunitas, state-space, scold, nonstd, adhoc and so on.
: ${with_tunitas_nearby:=${with_build?}/tunitas}
: ${with_scold_nearby:=${with_build?}/scold}
: ${with_modules_nearby:=${with_build?}/modules}
: ${with_useful_nearby:=${with_build?}/useful}
: ${with_apache_nearby:=${with_build?}/apache}
: ${with_hyperledger_nearby:=${with_build?}/hyperledger}
: ${with_fabric_nearby:=${with_hyperledger_nearby?}/fabric}
: ${module_:=""} in lieu of module_=module-
{
    #
    # Guard against inadvertent command-line UX faux pas:
    #
    # Guard against microhttpd (inadvertent) vs microhttpd++ (correct)
    #
    if [[ -n ${with_microhttpd} ]] ; then
        __deprecated=with_microhttpd
        __preferred=with_microhttpd__
        __displayed=microhttpd++
        echo "${0##*/}: warning, '${__deprecated?}' should be '${__preferred?} (${__displayed?})"
        echo "${0##*/}: notice, assigning ${__deprecated?}=${with_microhttpd?} into '${__preferred?} for ${__displayed})"
        : ${with_microhttpd__:=${with_microhttpd?}}
    fi 1>&2
    #
    # Guard against level (inadvertent) vs leveldb (correct)
    #
    if [[ -n ${with_nonstd_level} ]] ; then
        __deprecated=with_nonstd_level
        __preferred=with_nonstd_leveldb
        __displayed=nonstd-leveldb
        echo "${0##*/}: warning, '${__deprecated?}' should be '${__preferred?} (${__displayed?})"
        echo "${0##*/}: notice, assigning ${__deprecated?}=${with_nonstd_level?} into '${__preferred?} for ${__displayed})"
        : ${with_nonstd_leveldb:=${with_nonstd_level?}}
    fi 1>&2
    #
    # Guard against mysql (inadvertent) vs mysql++ (correct)
    #
    if [[ -n ${with_nonstd_mysql} ]] ; then
        __deprecated=with_nonstd_mysql
        __preferred=with_nonstd_mysql__
        __displayed=nonstd-mysql++
        echo "${0##*/}: warning, '${__deprecated?}' should be '${__preferred?} (${__displayed?})"
        echo "${0##*/}: notice, assigning ${__deprecated?}=${with_nonstd_mysql?} into '${__preferred?} for ${__displayed})"
        : ${with_nonstd_mysql__:=${with_nonstd_mysql?}}
    fi 1>&2
    #
    # Guard against pgsql (inadvertent) vs pgsql++ (correct)
    #
    if [[ -n ${with_nonstd_pgsql} ]] ; then
        __deprecated=with_nonstd_pgsql
        __preferred=with_nonstd_pgsql__
        __displayed=nonstd-pgsql++
        echo "${0##*/}: warning, '${__deprecated?}' should be '${__preferred?} (${__displayed?})"
        echo "${0##*/}: notice, assigning ${__deprecated?}=${with_nonstd_pgsql?} into '${__preferred?} for ${__displayed})"
        : ${with_nonstd_pgsql__:=${with_nonstd_pgsql?}}
    fi 1>&2
}
# [[experimental]] or dubious or very new
{
    if __with=${with_fabric_nearby?}/ca; [[ -e $__with ]] ; then
        : ${with_hyperledger_fabric_ca:=$__with}
    fi
    if __with=${with_fabric_nearby?}/db; [[ -e $__with ]] ; then
        : ${with_hyperledger_fabric_db:=$__with}
    fi
    if __with=${with_modules_nearby?}/${module_?}pgsql; [[ -e $__with ]] ; then
        : ${with_module_pgsql:=${__with?}}
    fi
    if __with=${with_modules_nearby?}/${module_?}ramcloud; [[ -e $__with ]] ; then
        : ${with_module_ramcloud:=${__with}}
    fi
    if __with=${with_modules_nearby?}/${module_?}sys; [[ -e $__with ]] ; then
        : ${with_module_sys_core:=${__with?}}
    fi
}
# [[current]]
: ${with_hypogeal_twilight:=${with_scold_nearby?}/hypogeal-twilight}
: ${with_incendiary_sophist:=${with_scold_nearby?}/incendiary-sophist}
: ${with_module_cli_core:=${with_modules_nearby?}/${module_?}cli-core}
: ${with_apache_httpd_api:=${with_apache_nearby?}/httpd/api}
: ${with_microhttpd__:=${with_useful_nearby?}/microhttpd++}
: ${with_module_ares:=${with_modules_nearby?}/${module_?}ares}
: ${with_module_boost:=${with_modules_nearby?}/${module_?}boost}
: ${with_module_cli_core:=${with_modules_nearby?}/${module_?}cli-core}
: ${with_module_cli_shell:=${with_modules_nearby?}/${module_?}cli-shell}
: ${with_module_crypto:=${with_modules_nearby?}/${module_?}crypto}
: ${with_module_curl:=${with_modules_nearby?}/${module_?}curl}
: ${with_module_fmt:=${with_modules_nearby?}/${module_?}fmt}
: ${with_module_half:=${with_modules_nearby?}/${module_?}half}
: ${with_module_json:=${with_modules_nearby?}/${module_?}json}
: ${with_module_langu:=${with_modules_nearby?}/${module_?}langu}
: ${with_module_level:=${with_modules_nearby?}/${module_?}level}
: ${with_module_mysql:=${with_modules_nearby?}/${module_?}mysql}
: ${with_module_nonstd:=${with_modules_nearby?}/${module_?}nonstd}
: ${with_module_openssl:=${with_modules_nearby?}/${module_?}openssl}
: ${with_module_rabinpoly:=${with_modules_nearby?}/${module_?}rabinpoly}
: ${with_module_rigging_app:=${with_modules_nearby?}/${module_?}rigging-app}
: ${with_module_rigging_core:=${with_modules_nearby?}/${module_?}rigging-core}
: ${with_module_sqlite:=${with_modules_nearby?}/${module_?}sqlite}
: ${with_module_sys:=${with_module_sys_core?}}
# [[deprecating]]
: ${with_module_cli:=${with_module_cli_core?}}
: ${with_module_options:=${with_module_cli_core?}}
: ${with_module_rigging:=${with_module_rigging_core?}}
: ${with_module_shell:=${with_module_cli_shell?}}
if [[ -n $DEPRECATED ]] ; then
    : ${with_module_format:=no}
    : ${with_module_ip:=no}
    : ${with_module_posix:=no}
    : ${with_module_slurp:=no}
    : ${with_module_std:=no}
    : ${with_module_string:=no}
    : ${with_module_uuid:=no}
fi
# [[current]]
: ${with_nonstd_gcc:=no} # else /exp/gcc/${GCC:-99}}# ... WATCHOUT you, the caller must ensure that PATH is set consistenly with this
# check whether this is different than what PATH finds in the natural course.
if [[ -n $with_nonstd_gcc ]] && [[ no != $with_nonstd_gcc ]] ; then
    if type -p gcc 2>/dev/null ; then
        exe=$(type -p gcc 2>/dev/null)
        if [[ $exe != ${with_nonstd_gcc}/bin/gcc ]] ; then
            echo "${0}: notice, instead correct with_nonstd_gcc=${with_nonstd_gcc} $0"
            for w in {1..30} ; do
                echo "${0}: warning, the explicit setting with_nonstd_gcc=${with_nonstd_gcc} is not consistent with $exe from PATH"
            done
            echo "${0}: notice, permanently fix this as -- PATH=${with_nonstd_gcc}/bin:\$PATH with_nonstd_gcc=${with_nonstd_gcc} $0"
        fi 1>&2
    fi
fi
: ${with_nonstd_half:=/opt/nonstd/half} # ..................... REQUIRED because there is no "standard half"
: ${with_nonstd_c_ares:=no} # ....... else /opt/nonstd/c-ares # ..... OPTIONAL nowadays
: ${with_nonstd_curl:=no} # ......... else /opt/nonstd/curl # ....... OPTIONAL nowadays
: ${with_nonstd_curlpp:=no} # ....... else /opt/nonstd/curl # ....... OPTIONAL nowadays
: ${with_nonstd_cryptopp:=no} # ..... else /opt/nonstd/cryptopp # ... OPTIONAL nowadays
: ${with_nonstd_fmt:=no} # .......... else /opt/nonstd/fmt # ........ OPTIONAL nowadays
: ${with_nonstd_jsoncpp:=no} # ...... else /opt/nonstd/jsoncpp # .... OPTIONAL nowadays
: ${with_nonstd_leveldb:=no} # ...... else /opt/nonstd/leveldb # .... OPTIONAL nowadays
: ${with_nonstd_mysql__:=no} # ...... else /opt/nonstd/mysql++ # .... OPTIONAL nowadays
: ${with_nonstd_openssl:=no} # ...... else /opt/nonstd/openssl # .... OPTIONAL nowadays
: ${with_nonstd_pgsql__:=no} # ...... else /opt/nonstd/pgsql++ # .... OPTIONAL nowadays
: ${with_nonstd_ramcloud:=no} # ..... else /opt/nonstd/ramcloud # ... OPTIONAL nowadays
: ${with_nonstd_sqlite:=no} # ....... else /opt/nonstd/sqlite # ..... OPTIONAL nowadays
#
# The various places in Tunitas (not all of which exist, yet)
#
declare TUNITAS_UNIVERSE=(apanolio basics butano catera denniston grabtown honsinger keyston ladera lobitos montara nuff pescadero purissima rockaway scarpet tarwater temerarious-flagship woodruff)
for place in ${TUNITAS_UNIVERSE[@]} ; do
    eval ": \${with_tunitas_${place}:=\${with_tunitas_nearby?}/${place}}"
done
: ${enable_configure_debug:=no}
: ${enable_configure_verbose:=no}
: ${CPPFLAGS:=-Wno-cpp}
: ${CXXFLAGS:=-Wno-attributes -Wno-deprecated-declarations}
: ${LDFLAGS:=-O0 -ggdb -no-install}
if type -p nproc 2>/dev/null ; then
    : ${MAKEFLAGS:=-j$(nproc)}
fi
function summarize() { finish; } # compatibility with 2022 & prior
function start() {
    git status -s;
}
function finish() {
    local e=$1; shift
    if ((0 == e)); then
        echo OK DONE
        git status -s
    else
        echo FAILED
    fi
    return $e
}
function standard_idiomatic_build_recipe() {
    start &&
    eval \
        ${prefix:+prefix=$prefix} \
        ${with_hypogeal_twilight:+with_hypogeal_twilight=$with_hypogeal_twilight} \
        ${with_temerarious_flagship:+with_temerarious_flagship=$with_temerarious_flagship} \
        ./buildconf &&
    ./configure \
        ${enable_dependency_tracking:+--enable-dependency-tracking=$enable_dependency_tracking} \
        ${enable_configure_verbose:+--enable-configure-verbose=$enable_configure_verbose} \
        ${enable_configure_debug:+--enable-configure-debug=$enable_configure_debug} \
        --disable-mock-build \
        ${prefix:+--prefix=$prefix} \
        ${with_nearby:+--with-nearby=$with_nearby} ${with_external:+--with-external=$with_external} \
        ${with_submodules:+--with-submodules=$with_submodules} \
        ${with_nonstd_gcc:+--with-nonstd-gcc=$with_nonstd_gcc} \
        ${with_hypogeal_twilight:+--with-hypogeal-twilight=$with_hypogeal_twilight} \
        ${with_temerarious_flagship:+--with-temerarious-flagship=$with_temerarious_flagship} \
        ${with_apache_httpd_api:+--with-apache-httpd-api=$with_apache_httpd_api} \
        ${with_hyperledger:+--with-hyperledger=$with_hyperledger} \
        ${with_hyperledger_fabric:+--with-hyperledger-fabric=$with_hyperledger_fabric} \
        ${with_hyperledger_fabric_ca:+--with-hyperledger-fabric-ca=$with_hyperledger_fabric_ca} \
        ${with_hyperledger_fabric_db:+--with-hyperledger-fabric-db=$with_hyperledger_fabric_db} \
        ${with_microhttpd__:+--with-microhttpd++=$with_microhttpd__} \
        ${with_module_ares:+--with-module-ares=$with_module_ares} \
        ${with_nonstd_c_ares:+--with-nonstd-c-ares=$with_nonstd_c_ares} \
        ${with_module_boost:+--with-module-boost=$with_module_boost} \
        ${with_nonstd_boost:+--with-nonstd-boost=$with_nonstd_boost} \
        ${with_module_c:+--with-module-c=$with_module_c} \
        ${with_module_cli_core:+--with-module-cli-core=$with_module_cli_core} \
        ${with_module_cli_shell:+--with-module-cli-shell=$with_module_cli_shell} \
        ${with_module_cli:+--with-module-cli=$with_module_cli} \
        ${with_module_crypto:+--with-module-crypto=$with_module_crypto} \
        ${with_nonstd_cryptopp:+--with-nonstd-cryptopp=$with_nonstd_cryptopp} \
        ${with_module_curl:+--with-module-curl=$with_module_curl} \
        ${with_nonstd_curl:+--with-nonstd-curl=$with_nonstd_curl} \
        ${with_nonstd_curlpp:+--with-nonstd-curlpp=$with_nonstd_curlpp} \
        ${with_module_fmt:+--with-module-fmt=$with_module_fmt} \
        ${with_nonstd_fmt:+--with-nonstd-fmt=$with_nonstd_fmt} \
        ${with_module_half:+--with-module-half=$with_module_half} \
        ${with_nonstd_half:+--with-nonstd-half=$with_nonstd_half} \
        ${with_module_json:+--with-module-json=$with_module_json} \
        ${with_nonstd_jsoncpp:+--with-nonstd-jsoncpp=$with_nonstd_jsoncpp} \
        ${with_module_langu:+--with-module-langu=$with_module_langu} \
        ${with_module_level:+--with-module-level=$with_module_level} \
        ${with_nonstd_leveldb:+--with-nonstd-leveldb=$with_nonstd_leveldb} \
        ${with_module_mysql:+--with-module-mysql=$with_module_mysql} \
        ${with_nonstd_mysql__:+--with-nonstd-mysql++=$with_nonstd_mysql__} \
        ${with_module_nonstd:+--with-module-nonstd=$with_module_nonstd} \
        ${with_module_openssl:+--with-module-openssl=$with_module_openssl} \
        ${with_nonstd_openssl:+--with-nonstd-openssl=$with_nonstd_openssl} \
        ${with_module_options:+--with-module-options=$with_module_options} \
        ${with_module_pgsql:+--with-module-pgsql=$with_module_pgsql} \
        ${with_nonstd_pgsql__:+--with-nonstd-pgsql++=$with_nonstd_pgsql__} \
        ${with_module_posix:+--with-module-posix=$with_module_posix} \
        ${with_module_rabinpoly:+--with-module-rabinpoly=$with_module_rabinpoly} \
        ${with_module_ramcloud:+--with-module-ramcloud=$with_module_ramcloud} \
        ${with_nonstd_ramcloud:+--with-nonstd-ramcloud=$with_nonstd_ramcloud} \
        ${with_module_rigging_app:+--with-module-rigging-app=$with_module_rigging_app} \
        ${with_module_rigging_core:+--with-module-rigging-core=$with_module_rigging_core} \
        ${with_module_rigging:+--with-module-rigging=$with_module_rigging} \
        ${with_module_shell:+--with-module-shell=$with_module_shell} \
        ${with_module_slurp:+--with-module-slurp=$with_module_slurp} \
        ${with_module_std:+--with-module-std=$with_module_std} \
        ${with_module_string:+--with-module-string=$with_module_string} \
        ${with_module_sys:+--with-module-sys=$with_module_sys} \
        ${with_module_sqlite:+--with-module-sqlite=$with_module_sqlite} \
        ${with_module_uuid:+--with-module-uuid=$with_module_uuid} \
        ${with_tunitas_basics:+--with-tunitas-basics=$with_tunitas_basics} \
        ${with_tunitas_butano:+--with-tunitas-butano=$with_tunitas_butano} \
        ${with_tunitas_montara:+--with-tunitas-montara=$with_tunitas_montara} \
        ${with_tunitas_rockaway:+--with-tunitas-rockaway=$with_tunitas_rockaway} \
        ${with_tunitas_tarwater:+--with-tunitas-tarwater=$with_tunitas_tarwater} \
        ${with_tunitas_denniston:+--with-tunitas-denniston=$with_tunitas_denniston} \
        ${with_tunitas_keyston:+--with-tunitas-keyston=$with_tunitas_keyston} \
        ${with_tunitas_nuff:+--with-tunitas-nuff=$with_tunitas_nuff} \
        ${with_tunitas_woodruff:+--with-tunitas-woodruff=$with_tunitas_woodruff} \
        ${with_std_tunitas:+--with-std-tunitas=$with_std_tunitas} \
        ${with_std_scold:+--with-std-scold=$with_std_scold} \
        ${end} &&
    make ${MAKEFLAGS:+MAKEFLAGS="$MAKEFLAGS"} ${CPPFLAGS:+CPPFLAGS="$CPPFLAGS"} ${CXXFLAGS:+CXXFLAGS="$CXXFLAGS"} ${LDFLAGS:+LDFLAGS="$LDFLAGS"} &&
    make check ${MAKEFLAGS:+MAKEFLAGS="$MAKEFLAGS"} ${CPPFLAGS:+CPPFLAGS="$CPPFLAGS"} ${CXXFLAGS:+CXXFLAGS="$CXXFLAGS"} ${LDFLAGS:+LDFLAGS="$LDFLAGS"} &&
    finish
}
