# This is a -*- Makefile -*- fragment which is processed by automake
# For terms and provenance see the LICENSE file at the top of this repository.
#
# To give (decent) notice when the mock build has been disabled
# and yet the caller still calls in to the interface
#
# Usage:
#
#     if ENABLE_MOCK_BUILD
#     ...blahblahblah... MOCK_CFG_NAME = example
#     ...blahblahblah... PACKAGE_SPEC_FILE = module-sqlite.spec
#     ...blahblahblah... trial-package: tar_here-rpmbuild-mock
#     ...blahblahblah...       package: git_archive-rpmbuild-mock
#     ...blahblahblah... CHECK_SPEC_FILE = tests/package/check.spec
#     ...blahblahblah... trial-check-package: thrm.check-rpmbuild-mock
#     ...blahblahblah...       check-package: nothrm.check-rpmbuild-mock
#     ...blahblahblah... include @vernacular_doggerel_datarootdir@/mk/build.mk
#     else
#     include @hypogeal_twilight_datarootdir@/am/DISABLED-MOCK-BUILD.mk <---------- be nice
#     endif
#

__disabled_KERNEL = package
__disabled_INTERFACE = $(foreach base, \
  $(foreach base, \
    $(foreach base,
      $(KERNEL), \
      $(base) $(addprefix rpm-, $(base))), \
    $(base) $(addprefix check-, $(base))),
  $(base) $(addprefix trial-, $(base)))
$(__disabled_INTERFACE):
	@echo "make $@: error, given ENABLE_MOCK_BUILD=FALSE, use --enable-mock-build to enable $@"; exit 1
