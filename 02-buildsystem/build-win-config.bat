rem Copyright (c) 2017 The Khronos Group Inc. 
rem 
rem Licensed under the Apache License, Version 2.0 (the "License"); 
rem you may not use this file except in compliance with the License. 
rem You may obtain a copy of the License at 
rem 
rem     http://www.apache.org/licenses/LICENSE-2.0 
rem 
rem Unless required by applicable law or agreed to in writing, software 
rem distributed under the License is distributed on an "AS IS" BASIS, 
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
rem See the License for the specific language governing permissions and 
rem limitations under the License.

rem Set these to the paths to your CMake and Python2 directories respectively
rem You can also comment these out and set them in environment variables instead
set CMAKE=C:\Program Files (x86)\Microsoft Visual Studio\Preview\Enterprise\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin
set PYTHON2=C:\Python27amd64

rem For MSYS2 (MINGW64):
rem set CMAKE=C:\msys64\mingw64\bin
rem set PYTHON2=C:\msys64\mingw64\bin

rem Select your MSVC toolset here -- this is the same as CMake's generator argument
rem Examples are: Visual Studio 15 2017, Visual Studio 14 2015...
rem Note: VS 2017 seems to have some problems building SPIRV-LLVM and SPIRV-Clang.  Recommended to use VS 2015 until this is fixed.
rem set BUILD_TOOL_CMAKE_G=Visual Studio 15 2017
set BUILD_TOOL_CMAKE_G=Visual Studio 14 2015 Win64

rem Optional toolset to use with MSVC
rem set OPT_BUILD_TOOL_CMAKE_T=;-T;v140

rem Use MSYS2 GCC
rem set BUILD_TOOL_CMAKE_G=Unix Makefiles

rem If you have Ninja installed and want to use MSYS2 GCC
rem set BUILD_TOOL_CMAKE_G=Ninja

rem Use whichever default is available -- likely will not work
rem set BUILD_TOOL_CMAKE_G=
