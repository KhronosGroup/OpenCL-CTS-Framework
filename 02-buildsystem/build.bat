@echo off
setlocal

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


rem Enable script to work even if executed from another directory
cd /d %~dp0

call build-win-config.bat

set BUILDSYSTEM_BASE=%cd%

rem Include VS 2017 Preview CMake just in case
set PATH=%PATH%%CMAKE%

rem Get buildsystem paths (install, build, dload, etc)
for /f "delims=;" %%i in ('cmake "-DPATHTYPE=CMD" -P cmake/GenPaths.cmake') do %%i

rem Prefer to use bootstrapped utilities
set PATH=%INSTALL_BASE%\cmake\bin;%INSTALL_BASE%\ninja\bin;%PATH%;%PYTHON2%

rem Bootstrap CMake if necessary
cmake -DBUILD_TOOL_CMAKE_G:string="-G;%BUILD_TOOL_CMAKE_G%%OPT_BUILD_TOOL_CMAKE_T%" -P bootstrap/BootstrapCMake.cmake 

rem Disable warnings for Ninja -- causes build problems
set CFLAGS="/w"
rem Bootstrap Ninja if necessary (using new CMake)
cmake -DBUILD_TOOL_CMAKE_G:string="-G;%BUILD_TOOL_CMAKE_G%%OPT_BUILD_TOOL_CMAKE_T%" -P bootstrap/BootstrapNinja.cmake
set CFLAGS=

rem Build the Khronos OpenCL C/C++/SPIR/SPIRV compiler toolset
rem using the previously built CMake and Ninja.

rem Disable warnings to prevent build problems
set CFLAGS="/w"
set CXXFLAGS="/w"
cmake -DBUILD_TOOL_CMAKE_G:string="-G;%BUILD_TOOL_CMAKE_G%%OPT_BUILD_TOOL_CMAKE_T%" -P cmake/BuildOpenCLToolset.cmake
set CFLAGS=
set CXXFLAGS=
