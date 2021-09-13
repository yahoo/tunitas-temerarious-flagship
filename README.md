# Temerarious Flagship

This is The Tunitas Build System.  This is an [autotools-based](https://www.gnu.org/software/automake/manual/html_node/index.html#Top) build system.

What's with the name?  See the [definition](#definition).

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Components](#components)
- [References](#references)
- [Contribute](#contribute)
- [License](#license)
- [Definition](#definition)

## Background

Most (almost all) projects in the Tunitas family use the Scalable Object Location Disaggregation (S.C.O.L.D.) compiler to manage the C++ declarations and definitions as "header files" in the form of _modules_. We know.  This system has something of the flavor of the upcoming _C++20 Modules TS_ but works with the existing include-by-cut&amp;-paste of the old school C Preprocessor based compiler implementations.  Elsewhere, we use C++ 20 to the fullest extent of the language standard, as it is rendered by <strike>GCC 7, GCC 8 and GCC 9</strike> GCC 10, GCC 11 and GCC 12 including any other available extensions towards C++2b, C++2c &amp; C++23 when and as such are available, __e.g.__ concepts, filesystem, network, ranges.  When modules _really_ "arrive with stability" they will be adopted with support herein.

## Installation

There is no automated installation for this project.  The installation recipe is in the `packaging` which will install the build system into `/opt/tunitas.`

Other packages, may reference this development tree directly.  Examples may be found in `./maintenance/nearby` in the other Tunitas family of packages.  This is shown in the next section.

If available, you can install from your organization's DNF repository with the following recipe:

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
The `buildconf` script is always a stock-standard boilerplate script which generates the `configure`.
<strike>Most  of the sibling</strike>All of the Tunitas projects are able to build when configured to use the development tree or the installation tree in `/opt/tunitas`.

To point the other project's build tree at _this_ copy of temerarious-flagship, the following recipe would be used:

``` bash
with_temerarious_flagship=/build/tunitas/temerarious-flagship ./buildconf &&
./configure --with-temerarious-flagship=/build/tunitas/temerarious-flagship &&
make &&
echo OK DONE
```

### The Maintenance Recipe

For many projects the `./maintenance` directory contains artifices for the project maintainer.  They are developer-centric and idiosyncratic.

`./maintenance/nearby` runs the generic build recipe with dynamic configurations to opportunistically acquire and configure to build any nearby projects.

## Components

The components of are simple _shim_-type scripts and configurations in support of the underlying autotools build tooling.

### `ac` the autoconf area

Fragments of M4 macros used by autoconf in `configure.ac` via aclocal

### `am` the automake area

Fragments of (GNU) Makefile for automake to include in the `Makefile.am`

### `bc` templates of `buildconf`

Instances of the _buildconf_ script which can be copied into any project.

### `addenda` is more

There are other (sub-)components which have not yet landed in the previous locations.
In another configuration mangement regimen they might be versioned separately.

## References

* [Experimental C++ Features](https://en.cppreference.com/w/cpp/experimental)
* [C++ Standard Draft Sources](https://github.com/cplusplus/draft)
* [ISO/IEC 14882:2020](https://www.iso.org/standard/79358.html) <em>Programming Language C++</em> (paywalled), 2020-12.
* [ISO/IEC 14882:2017](https://www.iso.org/standard/68564.html) <em>Programming Language C++</em> (paywalled), 2017.
* [ISO/IEC TS 21544:2018](https://www.iso.org/standard/71051.html) <em>Modules TS</em> (paywalled), 2018-05-15.
* [cplusplus/modules-ts](https://github.com/cplusplus/modules-ts), C++ Modules Technical Specification, [current](http://cplusplus.github.io/modules-ts/draft.pdf).  The draft Technical Specification is found in the `src` directory and is written in _LaTeX_. There is a `Makefile` that can be used to compile the sources, or you can use the `latexmk` program _e.g._ `latexmk -pdf` ts will generate a PDF.
* [n4720](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/n4720.pdf) <em>Working Draft, Extensions to C++ for Modules</em>, Gabriel Dos Rios (Microsoft), final draft, 2018-01-29.

### Selected Commentary

* [P0804R0](http://open-std.org/JTC1/SC22/WG21/docs/papers/2017/p0804r0.html) <em>Impact of the Modules TS on the C++ Tools Ecosystem, 2017-10-15.

### Implementations

* [C++ Modules for GCC](https://gcc.gnu.org/wiki/cxx-modules), GCC Wiki, updated continuously since 2018.
* [C++ Modules for CLang](https://clang.llvm.org/docs/Modules.html), CLang Wiki, viewed
* [Using C++ in Visual Studio 2017](https://blogs.msdn.microsoft.com/vcblog/2017/05/05/cpp-modules-in-visual-studio-2017/), In _Their Blog_, 2017-05-04.

## Contribute

Please refer to [contributions statement](Contributing.md) for information about how to get involved. We welcome issues, questions. Pull Requests are welcome.

## Maintainers
- Wendell Baker <wbaker@yahooinc.com>
- The Tunitas Team at Yahoo.

You may contact us at least at <tunitas@yahooinc.com>

## License

This project is licensed under the terms of the [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0) open source license. Please refer to [LICENSE](LICENSE) file at the top of this repository for the full terms.

## Definitions

[temerarious](https://en.wiktionary.org/wiki/temerarious): marked by temerity; rashness, recklessness, boldness, or presumptuousness. 
[flagship](https://en.wiktionary.org/wiki/flagship), the most important one out of a related group. 
*mnemonic*: extending the autotools with yet more macros is <em>blank</em>.
*mnemonic*: the build system of any software distribution is the <em>blank</em> of the operation.
