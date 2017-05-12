# The Windsor OpenCL Buildsystem

## Quick start guide
### Linux-like:

#### Minimal Prerequisites
Ensure you have CMake 2.8 or higher installed on your system, Git, and Python 2.7.

#### Recommended Prerequisites
If you have CMake 3.8rc4 or higher and Ninja 1.7.2 or higher installed on your system, your build will skip downloading the latest CMake and Ninja, speeding things up.

#### Building

~~~
cd 02-buildsystem
./build.sh
~~~

#### Cleaning the installation directories

~~~
cd 02-buildsystem
./clean.sh --installs
~~~

If you want to remove absolutely everything that was installed:

~~~
cd 02-buildsystem
./clean.sh --everything
~~~

### Windows

#### Configurations

##### Visual Studio 2017 Preview

NOTE: Visual Studio 2017 support is experimental and will be fully supported in the future.

Ensure that the C++ compiler, Clang/C2, Python 2.7, and Git for Windows is installed via the Visual Studio Installer.

In `build-win-config.bat`, uncomment:

~~~
rem set BUILD_TOOL_CMAKE_G=Visual Studio 15 2017
~~~

In cmd:
~~~
cd 02-buildsystem
build.bat
~~~

##### Visual Studio 2017 Release

The only difference between this and the Preview version is that Python 2.7 is not installable via the Visual Studio Installer, so you will need to install it separately.  Simply edit `build-win-config.bat` so that the Python 2.7 path reflects the path to your Python 2.7 installation on your system.
Support for VS 2017 is experimental.

##### Visual Studio 2015

This is the default configuration.
First, ensure Python 2.7, Git for Windows and CMake are present on your system.  Edit `build-win-config.bat` and modify the CMake and Python 2.7 paths to reflect those that are on your system.  Next, uncomment the line:

##### MSYS2

It is recommended that you install Ninja, CMake, and Python 2.7, and Git via `pacman` before proceeding.

~~~
pacman -S mingw-w64-x86_64-cmake mingw-w64-x86_64-python2 mingw-w64-x86_64-python2-setuptools mingw-w64-x86_64-ninja git
~~~

NOTE: Do not install the MSYS2 version of Python 2.7 and CMake.  These are not native tools -- they run under a translation layer providing POSIX semantics on Windows systems.  This is almost certainly not what you want!

###### Visual Studio

It is possible to use MSYS2's Python, CMake, Ninja, and Git but still use MSVC.
Only minor tweaking is needed to achieve this. Edit `build-win-config.bat` and choose the MSYS2 configuration for CMake and Python 2.7.  Uncomment:

~~~
rem set CMAKE=C:\\msys64\\mingw64\\bin
rem set PYTHON2=C:\\msys64\\mingw64\\bin  
~~~

Simply set the CMake generator as appropriate in `build-win-config.bat`. For example:

~~~
set BUILD_TOOL_CMAKE_G=Visual Studio 15 2017 Win64
~~~

###### GCC

Ensure GCC is installed via `pacman`:

~~~
pacman -S mingw-w64-x86_64-gcc
~~~

To use GCC, simply uncomment in `build-win-config.bat`:

~~~
rem set BUILD_TOOL_CMAKE_G=Unix Makefiles
~~~

If you already have Ninja installed, you may use it rather than makefiles to build everything.  This is much faster than using MSYS2's make.  Uncomment in `build-win-config.bat`:

~~~
rem set BUILD_TOOL_CMAKE_G=Ninja
~~~

NOTE: A lot of memory is used when building SPIRV-LLVM/SPIR-Clang with GCC.  Ensure your system has a minimum of 16 GB of memory available.

#### Building

In MINGW64 prompt:
~~~
cd 02-buildsystem
./build.bat
~~~

Alternatively, in CMD prompt:

~~~
cd 02-buildsystem
build.bat
~~~

#### Cleaning the installation directories

In CMD:
~~~
cd 02-buildsystem
clean.bat --installs
~~~

If you want to remove absolutely everything that was installed:

In CMD:
~~~
cd 02-buildsystem
clean.bat --everything
~~~

The above also works under the MINGW64 prompt.

## Advanced features

### Choosing alternative installation directories

Installation directories can be overridden in the file `cmake/Common.cmake`.  Sensible defaults are chosen, but these may not always be appropriate depending on your setup.

### Adding additional repositories

Currently, the public Khronos OpenCL repositories are already configured for the BuildSystem.

Repositories, along with configuration, build instructions, and dependencies are described using CMake's
ExternalProject functions.  Repository definitions are kept inside the `repos` subdirectory
in files with names matching the glob `Repo*.cmake`.

To add a new set of repositories to build from, simply create a new CMake file that matches
`Repo*.cmake` inside the `repos` subdirectory, and add ExternalProject definitions
in that file as you need.  The official CMake documentation on ExternalProject can be found [here](https://cmake.org/cmake/help/latest/module/ExternalProject.html).

## Authors

* Shane Peelar, M. Sc., University of Windsor
* Paul Preney, M. Sc., University of Windsor
