# The Windsor Build and Testing Framework

The Windsor Build and Test Framework (WBTF) is a simple and extensible CMake-based framework for OpenCL development.  It has two main goals: to easily create an OpenCL development environment on your system and to simplify conformance testing of OpenCL implementations.  It is divided into two main subsystems:

## The Download-And-Build Subsystem

The Download-And-Build Subsystem (DABS) was created to satisfy the first goal: it simplifies OpenCL development by automatically downloading and building OpenCL related software.  Importantly, it also can automatically pull in new changes upstream and re-build when necessary.  This subsystem relies largely on CMake's [ExternalProject](https://cmake.org/cmake/help/latest/module/ExternalProject.html) module.

Currently, it downloads the following software:

* The official OpenCL conformance test suites
* The Khronos reference OpenCL ICD Loader
* The Khronos reference OpenCL headers
* The Khronos reference offline OpenCL C and OpenCL C++ compilers
* The Khronos reference OpenCL C++ standard library
* The Khronos SPIR-V headers
* The Khronos SPIR-V tools, including validator

In addition to this, the DABS also builds the following software as part of it's bootstrapping phase:

* CMake, if the system CMake is not a recent version
* The Ninja build system, if it is not a recent version

The various repository descriptions are simple and can easily be extended or replaced based on your own needs.  Indeed, it is entirely possible to use the DABS for in-house projects that reside on private servers without any added complexity.

The DABS has been tested on a variety of Linux operating systems, and also has been tested on Windows
using the GCC compiler and Microsoft Visual Studio 2015 compiler.  For more information, see the README in
02-buildsystem.

## The Build-And-Test Subsystem

The Build-And-Test Subsystem (BATS) is an optional component that was created to satisfy the second goal: it seamlessly "hooks" into the DABS to use the downloaded tools and headers to build the official OpenCL conformance tests.  It smooths over the various differences in the different OpenCL conformance test suites and provides abstractions for cross-compiling tests in the form of test configurations.

One does not need to use the BATS for developing OpenCL software, however.  A developer who is interested in getting started with OpenCL quickly can simply use the DABS to set up an environment quickly.

For more information about the BATS, see the README in 03-conformance-checks.

## Dependencies

The DABS requires these previously-installed tools:
* CMake version 2.8 or higher
* Git version 2.10 or higher
* Python version 2.7
* A C/C++ compiler capable of compiling Clang (e.g., Clang , GCC , Visual Studio C++ (2015 or 2017))

## Publication

The Windsor Build and Testing Framework was featured as a poster in IWOCL 2017.  Our publication can be viewed online on the [ACM website](http://dl.acm.org/citation.cfm?id=3078184).

## Authors

* Shane Peelar, M.Sc., University of Windsor
* Paul Preney, M.Sc., University of Windsor
