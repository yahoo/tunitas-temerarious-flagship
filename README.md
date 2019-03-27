# Temerarious Flagship

This is The Tunitas Build System; this is an [autotools-based](https://www.gnu.org/software/automake/manual/html_node/index.html#Top) build system.

What's with the name?  See the [definition](#definition).

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Components](#components)
- [References](#references)
- [Contribute](#contribute)
- [License](#license)

## Background

Most (almost all) projects use the Scalable Object Location Disaggregation (S.C.O.L.D.) compiler to manage the C++ declarations and definitions as "header files" in the form of _modules_. This system has something of the flavor of the upcoming _C++20 Modules TS_ but works with the existing include-by-cut&amp;-paste of the old school C Preprocessor based compiler implementations.  We use C++ 17 as supported by GCC 7, GCC 8 and GCC 9with any other available extensions towards C++2a that are available, _e.g._ concepts, filesystem, network, ranges.  When modules "arrive with stability" they will be adopted with support herein.

## Installation

To build and install this project, use the recipe shown following.  This will install the build system into `/opt/tunitas.`

``` bash
./buildconf &&
./configure &&
make &&
make check &&
make install &&
echo OK DONE
```

Alternatively, if available, you can install from your organization's DNF repository with the following recipe:

``` bash
sudo dnf install temerarious-flagship
```

## Usage

For this project and for any project in the Tunitas system, the following recipe or something rhyming with this, is expected to work.

``` bash
./buildconf &&
./configure &&
make &&
make check &&
make install &&
echo OK DONE
```

This is a standard autotools build recipe where `buildconf` is done once, `configure` is done rarely and `make` is done frequently.

The `buildconf` script is a standard boilerplate script which generates the `configure`.

Most of the sibling projects are able to build when configured to use the development tree.
  
### The Maintenance Recipe

For many projects the `./maintenance` directory contains artifices for the project maintainer.

`./maintenance/nearby` runs the generic build recipe with dynamic configurations to opportunistically acquire and configure to build any nearby projects.

## Components

### `ac` the autotools area

Fragments of M4 macros used by autoconf in `configure.ac` via aclocal

### `am` the automake area

Fragments of (GNU) Makefile for automake to include in the `Makefile.am`

### `bc` templates of `buildconf`

Instances of the _buildconf_ script which can be copied into any project.

## References

* [Experimental C++ Features](https://en.cppreference.com/w/cpp/experimental)
* [ISO/IEC TS 21544:2018](https://www.iso.org/standard/71051.html) <em>Modules TS</em> (paywalled), 2018-05-15.
* [cplusplus/modules-ts](https://github.com/cplusplus/modules-ts), C++ Modules Technical Specification, [current](http://cplusplus.github.io/modules-ts/draft.pdf).  The draft Technical Specification is found in the `src` directory and is written in _LaTeX_. There is a `Makefile` that can be used to compile the sources, or you can use the `latexmk` program _e.g._ `latexmk -pdf` ts will generate a PDF.
* [n4720](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/n4720.pdf) <em>Working Draft, Extensions to C++ for Modules</em>, Gabriel Dos Rios (Microsoft), final draft, 2018-01-29.

### Selected Commentary

* [P0804R0](http://open-std.org/JTC1/SC22/WG21/docs/papers/2017/p0804r0.html) <em>Impact of the Modules TS on the C++ Tools Ecosystem, 2017-10-15.

### Implementations

* [C++ Modules for GCC 8](https://gcc.gnu.org/wiki/cxx-modules), GCC Wiki, updated at least on 2018-10-21.
* [C++ Modules for CLang 8](https://clang.llvm.org/docs/Modules.html), CLang Wiki, viewed
* [Using C++ in Visual Studio 2017](https://blogs.msdn.microsoft.com/vcblog/2017/05/05/cpp-modules-in-visual-studio-2017/), In _Their Blog_, 2017-05-04.
### Definition

[temerarious](https://en.wiktionary.org/wiki/temerarious): marked by temerity; rashness, recklessness, boldness, or presumptuousness. 
[flagship](https://en.wiktionary.org/wiki/flagship), the most important one out of a related group. 

*mnemonic*: extending the autotools with more macros is …
*mnemonic*: the build system of any software distribution is the …

## Contribute

Please refer to [the contributing.md file](Contributing.md) for information about how to get involved. We welcome issues, questions, and pull requests. Pull Requests are welcome.

## Maintainers
Wendell Baker <wbaker@verizonmedia.com>

## License

This project is licensed under the terms of the [Apache 2.0](LICENSE-Apache-2.0) open source license. Please refer to [LICENSE](LICENSE) for the full terms.
