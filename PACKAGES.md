# Required Packages

This document contains an estimate of the tools, components their versions which you will need to build this repository.  This repository contains the build system itself.  The build system is based upon the GNU Autotools (Autoconf, Automake & Libtool) and expects to fit within a modern C++ development environment.  Other details about installation dependencies and packaging expectations can be found in documentation for the lead repository, the Tunitas [Packaging](https://github.com/yahoo/tunitas-packaging/blob/master/PACKAGES.md).

## Development Tooling

The Tunitas projects are C++ projects.  These project approach the upcoming C++20 standard, where available. As such, a modern C++ development environment is required.  The following sections list the dependencies upon the compiler and biuld tooling.

### C++ 2a Compiler
* `gcc-c++` >= 7.2, feasible.
* `gcc-c++` >= 8.2, current.
* `gcc-c++` >= 9.0, preferred.
* gcc-c++ with [C++ Modules TS](https://gcc.gnu.org/wiki/cxx-modules).

### Build Support
* The [GNU Autotools](https://www.gnu.org/software/automake/manual/html_node/index.html#Top)
    * `automake` >= 1.16
    * `autoconf` >= 2.69
    * `libtool` >= 2.4
    * `make` >= 4.2
* The [S.C.O.L.D.](https://www.scold-lang.org) [toolchain](https://git.scold-lang.org/core) and modules
    * [hypogeal-twilight](https://git.scold-lang.org/core/hypogeal-twilight) >= 0.43, fundamental build system components.
    * [incendiary-sophist](https://git.scold-lang.org/core/incendiary-sophist) >= 0.1, the test harness, is optional.
    * [anguish-answer](https://git.scold-lang.org/core/anguish-answer) >= 0.1, the preprocessor towards a [unitary build](https://mesonbuild.com/Unity-builds.html).
* `perl` prefer `perl` >= 5.28
    * and various perl modules, surely.

## Operating System

Development commenced on Fedora 27 and has continued across Fedora 28 and Fedora 30.

A recent Ubuntu should be fine.

## Availabilities

* [Fedora](https://getfedora.com)
    * Fedora 27, possible.
    * Fedora 28, available.
    * Fedora 29, current.
    * Fedora 30, current.
* [S.C.O.L.D. C++](https://www.scold-lang.org) (Scalable Object Location Disaggregation)
    * <em>Release 02 (Maroon Iron Crow)</em>, possible.
    * <em>Release 03 (Red Mercury Goose)</em>, current
    * <em>Release 04 (Green Copper Heron)</em>, preferred.
