#
# Usage:
#
#   configure.ac:
#   HT_CHECK_CURLPP
#
#   Makefile.am: 
#   module_curl_datadir = $(dir $(word 1, $(wildcard $(addsuffix /mk /share/module-curl/mk,$(module_curl_prefix) $(std_scold_prefix) $(prefix)))))
#   include $(module_curl_datadir)/mk/curlpp.filter-out.LDFLAGS.mk
#
# WATCHOUT - the names 'module-curl' versus 'curlpp' (one has a "pp" suffix)
#
# WATCHOUT - the use of nonstd-curlpp is basically REQUIRED because libcurlpp.la is bothced, having unworkable ld options
# Witness: /usr/lib64/pkgconfig/curlpp.pc
#
#   ...more...
#   Libs: -Llib64 -lcurlpp -Wl,-z,relro   -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld 
#   Cflags: -Iinclude 
#
# AND to use the standard build we MUST remove the sharable linkages.
#
# REMOVE 
# -Wl,-z,relro   -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld 
#
# because you CANNOT have a comma in a filter-out pattern, and you CANNOT escape it; but you can hide it!
c = ,
LDFLAGS_curlpp_HACK  = $(filter-out -Wl$c-z$crelro   -Wl$c-z$cnow -specs=/usr/lib/rpm/redhat/redhat-hardened-ld, @LDFLAGS_curlpp@)
CXXFLAGS_curlpp_HACK = @CXXFLAGS_curlpp@
CFLAGS_curlpp_HACK   = @CFLAGS_curlpp@
CPPFLAGS_curlpp_HACK = @CPPFLAGS_curlpp@
