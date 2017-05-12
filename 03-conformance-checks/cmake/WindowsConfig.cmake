# Copyright (c) 2017 The Khronos Group Inc. 
#
# Licensed under the Apache License, Version 2.0 (the "License"); 
# you may not use this file except in compliance with the License. 
# You may obtain a copy of the License at 
#
#    http://www.apache.org/licenses/LICENSE-2.0 
#
# Unless required by applicable law or agreed to in writing, software 
# distributed under the License is distributed on an "AS IS" BASIS, 
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
# See the License for the specific language governing permissions and 
# limitations under the License.

#set(BUILDSYSTEM_WIN_CONFIG "MSYS2-GCC")

if (NOT BUILDSYSTEM_WIN_CONFIG)
  message(STATUS "Autodetecting best Windows configuration")
  if (EXISTS "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/ClangC2/bin/x86/clang.exe")
    set(BUILDSYSTEM_WIN_CONFIG "MSVC-Clang")
	message(STATUS "Visual Studio 14.0 clang found")
  else()
    set(BUILDSYSTEM_WIN_CONFIG "MSYS2-GCC")
    message(STATUS "Visual Studio 14.0 clang not found")
  endif()
endif()

if (NOT HOST_TOOLCHAIN_FILE)
  if (BUILDSYSTEM_WIN_CONFIG STREQUAL "MSYS2-GCC")
    message(STATUS "Using MSYS2 GCC")
	set(HOST_TOOLCHAIN_FILE SystemDefault)
  elseif (BUILDSYSTEM_WIN_CONFIG STREQUAL "MSVC-Clang")
    message(STATUS "Using Clang with Microsoft Codegen (Clang/C2)")
    set(HOST_TOOLCHAIN_FILE MSVC_v140_clang)
  endif()
endif()
