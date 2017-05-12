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


rem Enable script to work even if ran from another directory
cd /d %~dp0

rem Get buildsystem paths (install, build, dload, etc)                                                                                                         
for /f "delims=;" %%i in ('cmake "-DPATHTYPE=CMD" -P cmake/GenPaths.cmake') do %%i 

if "%1" == "" goto usage
if "%1" == "--everything" goto cleanall
if "%1" == "--installs" goto cleaninstalls

:usage
  echo Usage: clean.bat (--installs) (--everything)
  echo Options:
  echo --installs: Remove installed binaries, including bootstrapped components, conformance tests, and headers
  echo --everything: Remove installed binaries, bootstrapped components, conformance tests, headers, downloaded sources, and build directories
  exit /b 0

:cleanall
  cmake -DBUILD:string="" -DDLOADS:string="" -DCHECKS:string="" -DSDKS:string="" -DCL_REFHEADERS:string="" -DSPIRV_HEADERS:string="" -DSPIRV_TOOLS:string="" -DREF_CL_TOOLCHAIN:string="" -P cmake/Clean.cmake
  exit /b 0

:cleaninstalls
  cmake -DCHECKS:string="" -DSDKS:string="" -DCL_REFHEADERS:string="" -DSPIRV_HEADERS:string="" -DSPIRV_TOOLS:string="" -DREF_CL_TOOLCHAIN:string="" -P cmake/Clean.cmake

