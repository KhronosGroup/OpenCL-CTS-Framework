# The Windsor OpenCL Conformance Test Suite

## Quick Start Guide

If you have the Windsor OpenCL Buildsystem installed, your configuration from that can be directly used.

### Linux

First, set up your buildsystem.  This will pull in all required utilities, conformance tests, compilers, ICDs, and libraries.
From the repository root:
~~~
cd 02-buildsystem
./build.sh
~~~

Now, try running some tests:

~~~
cd 03-conformance-checks
./runtests.sh
~~~

### Windows

On Windows it is highly advised to use the Windsor Buildsystem.  Instructions are similar:

~~~
cd 02-buildsystem
build-win.bat
~~~

For more configuration options, see README.md in `02-buildsystem`.

(TODO) Now try running some tests:

~~~
cd 03-conformance-checks
runtests.bat
~~~

## Advanced configuration

### Build Definitions

These definitions are inspired from target triples in various popular compilers.

* **Build system** ***(not to be confused with 02-buildsystem)*** - The system on which the CTS is executing (i.e. the system on which you are building the tests)
* **Host system** - The system which will be executing the tests ("native" and "android" are supported for now)
* **Device** - The OpenCL device which is attached to the Host system

### Test Definitions

* **Run-time test** - A Host program which is linked against the OpenCL implementation being tested that tests various OpenCL calls, including enqueueing kernels on the Device.
* **Compile-time test** - A C or C++ source file that #includes OpenCL headers and whose resulting code after compilation (if successful) is not intended to be executed.  The test itself occurs during compilation of the source file.  Failure to compile the source file indicates a test failure--typically a helpful message will be reported in this case. If the file does compile, then the test is successful.  A C++14-onwards compiler is all that is required for these tests--at no point is the code ever linked against an OpenCL implementation (if any).  Two types of compile-time tests are supported:
    * **Compile-time host test** - A compile-time test that is ran with a **Host** compiler.  This does not involve **Device** OpenCL code at all.  This is intended to check **Host** headers for validity.
    * **Compile- time device test** - A compile-time test that is ran with an OpenCL C or OpenCL C++ offline compiler.  This is intended to check the offline compiler and/or it's standard library's validity.
* **Header-only test** - A synonym for a compile-time test.
* **Test Configuration** - A CMake file that defines the parameters for the tests being performed (e.g. OpenCL 2.1, compile-time testing of Khronos headers)

### Test Configurations

Test configurations are kept in the `configs` subdirectory.  Some sample configurations are provided that cover a few use cases.
To invoke a specific configuration, simply run:

~~~
./runtests.sh <config_name>
./runtests.sh configs/<config_name>
./runtests.sh configs/<config_name>.cmake
~~~

The above invocations are all equivalent.  You may find it useful if you have a shell that has autocompletion features to simply pass in the path to the configuration file.  For example, try running:

~~~
./runtests.sh configs/offline-opencl-2.2-khronos.cmake
~~~

A Test Configuration defines variables that affect how the tests are built and run.
Specifically, Test Configurations set up the **Host** system and **Device** for your particular build, along with the particular OpenCL implementation being tested.

The supported variables are documented below:

* **OPENCL_VERSION** - Defines which OpenCL version is to be tested.  Tests are automatically pulled in from the appropriate source.
* **TEST_TYPE** - May be "runtime", "compiletime-host", or "compiletime-device", depending on the nature of what is being tested.
* **VENDOR** - Define which vendor's OpenCL implementation will be used.  Automatically selects OpenCL toolchain as well
* **HOST_TOOLCHAIN_FILE** - May be used to override which toolchain CMake uses to build the tests
* **HOST** - Currently "native" and "android" are supported.  This corresponds to the **Host** system that will be running the tests.  That is, this sets up cross compilation.
* **ANDROID_NDK** - Android specific -- this should be set to your Android NDK
* **ANDROID_ABI** - Android specific -- this should be set to the appropriate Android ABI
* **ANDROID_NATIVE_API_LEVEL** - Android specific -- this should be set to the appropriate API level with which to compile Android binaries
* **ANDROID_TOOLCHAIN_NAME** - Android specific -- the name of the toolchain used for building Android binaries.

Additionally, library and include paths can be overridden in these files for more customization.  An override
can be applied to which offline OpenCL toolchain is in use as well.

* **VENDOR_BASE_INCL_DIR** - Override default include directory to this path for **Host** code
* **VENDOR_BASE_LIB_DIR** - Override default libarry directory to this path for **Host** code
* **VENDOR_OPENCL_TOOLCHAIN** - Override OpenCL toolchain that is used.

### Host toolchains

A Host toolchain is simply a CMake Toolchain file.  These are documented [here](https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html).
This toolchain will be used for building Host code.  By default, an empty toolchain is used, and your compiler will be inferred from your `CC` and `CXX` environment variables.  Sometimes it may be desirable to explicitly use one compiler.  For example, a toolchain for Visual Studio's experimental Clang compiler is provided for Windows systems.

### Device toolchains

We have extended the notion of CMake Toolchains to devices as well.  Device toolchains describe offline OpenCL C and OpenCL C++ compilers.  An example toolchain
is provided for the reference Khronos OpenCL C++ compiler under `opencl-toolchain/opencl-2.2/khronos`.  The following variables should be set in a custom toolchain file:

* **CMAKE_OPENCL_TOOLCHAIN_NAME** - A string that can be used to describe the compiler
* **CMAKE_OPENCL_C_COMPILER** - Analogous to CMake's **CMAKE_C_COMPILER** variable.  This is the path to the OpenCL C compiler binary
* **CMAKE_OPENCL_CXX_COMPILER** - Analogous to CMake's **CMAKE_CXX_COMPILER** variable.  This is the path to the OpenCL C++ compiler binary
* **CMAKE_OPENCL_CXX_STDLIB** - This is the path to the OpenCL C++ compiler's standard library.  OpenCL C++ standard libraries are assumed to be header-only for now.
* **CMAKE_OPENCL_CXX_INCLUDE_FLAG** - Used when passing in additional includes to the OpenCL C or OpenCL C++ compiler.  A typical definition is "-I".
* **CMAKE_OPENCL_CXX_OUTPUT_FLAG** - Used when informing the compiler where to place the output binary.  A typical definition is "-o".
* **CMAKE_OPENCL_CXX_INPUT_FLAG** - Used when passing in the source file's path to the OpenCL or OpenCL C++ compiler.  With the reference Clang, this is left unset.
* **CMAKE_OPENCL_DEFAULT_FLAGS** - Default flags that are passed with every invocation of the compiler.


### (TODO) Hooks

For running the tests...

### (TODO) Adding tests

Test are added by...

## Authors                                                                                                                                                                                                        
* Shane Peelar, M.Sc., University of Windsor
* Paul Preney, M.Sc., University of Windsor
