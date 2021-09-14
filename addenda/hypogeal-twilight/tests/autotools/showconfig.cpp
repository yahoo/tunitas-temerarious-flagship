// -*- c++ -*- being plain old C++2a
#include <iostream>

// testing these, which are exported
#include <autotools>
#include <autotools.autoconf>
#include <autotools.autoconf.Config>
#include <autotools.autoconf.Config.hypogeal.twilight.CONFIG> // generated (we're testing this)

// the test rigging (hand-coded)
#include <tests.quoting>

auto main() -> int {
  using ac = autotools::autoconf::Config<hypogeal::twilight::CONFIG>;
  using tests::quoting::q;
  std::cout << "package = " << q(ac::package())
            << "\npackage_bugreport = " << q(ac::package_bugreport())
            << "\npackage_name = " << q(ac::package_name())
            << "\npackage_string = " << q(ac::package_string())
            << "\npackage_version = " << q(ac::package_version())
            << "\npackage_version_string = " << q(ac::package_version_string())
            << "\nversion = " << q(ac::version())
            << "\nOK\n";
  return 0;
}
