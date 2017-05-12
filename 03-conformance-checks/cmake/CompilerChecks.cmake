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

#############################################################################

cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

#############################################################################
# Load required modules...
#############################################################################
include(CheckCCompilerFlag)
include(CheckCSourceCompiles)
include(CheckCSourceRuns)
include(CheckCXXCompilerFlag)
include(CheckCXXSourceCompiles)
include(CheckCXXSourceRuns)

#############################################################################

check_c_compiler_flag("-fdiagnostics-color=auto" C_COMPILER_FLAG_COLOUR)
if(C_COMPILER_FLAG_COLOUR)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdiagnostics-color=auto")
endif()

if(NOT C_COMPILER_STD_FLAG_SET)
  check_c_compiler_flag("-std=gnu99" C_COMPILER_FLAG_STD_C99)
  if(C_COMPILER_FLAG_STD_C99)
    set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu99")
    set(C_COMPILER_STD_FLAG_SET true)
  endif(C_COMPILER_FLAG_STD_C99)
endif()

if(NOT C_COMPILER_STD_FLAG_SET)
  check_c_compiler_flag("-std=c99" C_COMPILER_FLAG_STD_C99)
  if(C_COMPILER_FLAG_STD_C99)
    set(CMAKE_C_FLAGS "${CMAKE_CXX_FLAGS} -std=c99")
    set(C_COMPILER_STD_FLAG_SET true)
  endif(C_COMPILER_FLAG_STD_C99)
endif()

check_c_compiler_flag("-Wno-ignored-attributes" C_COMPILER_FLAG_NO_IGNORED_ATTRS)
if(C_COMPILER_FLAG_NO_IGNORED_ATTRS)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-ignored-attributes")
endif()

#check_c_compiler_flag("-Werror" C_COMPILER_FLAG_WARNS_ARE_ERRORS)
#if(C_COMPILER_FLAG_WARNS_ARE_ERRORS)
#  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Werror")
#endif()

#############################################################################

#
# Treat all warnings as errors...
#
#check_cxx_compiler_flag("-Werror" CXX_COMPILER_FLAG_WARNS_ARE_ERRORS)
#if(CXX_COMPILER_FLAG_WARNS_ARE_ERRORS)
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Werror")
#endif()

check_cxx_compiler_flag("-Wno-ignored-attributes" CXX_COMPILER_FLAG_NO_IGNORED_ATTRS)
if(CXX_COMPILER_FLAG_NO_IGNORED_ATTRS)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-ignored-attributes")
endif()


#
# Using C++14 as the highest, ask the C++ compiler to use a more
# recent standard than C++98 (which is currently presumed to be the default).
#
if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=gnu++14" CXX_COMPILER_FLAG_STD_CXX14)
  if(CXX_COMPILER_FLAG_STD_CXX14)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++14")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX14)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=c++14" CXX_COMPILER_FLAG_STD_CXX14)
  if(CXX_COMPILER_FLAG_STD_CXX14)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX14)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=gnu++1y" CXX_COMPILER_FLAG_STD_CXX1Y)
  if(CXX_COMPILER_FLAG_STD_CXX1Y)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++1y")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX1Y)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=c++1y" CXX_COMPILER_FLAG_STD_CXX1Y)
  if(CXX_COMPILER_FLAG_STD_CXX1Y)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX1Y)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=gnu++11" CXX_COMPILER_FLAG_STD_CXX11)
  if(CXX_COMPILER_FLAG_STD_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++11")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX11)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=c++11" CXX_COMPILER_FLAG_STD_CXX11)
  if(CXX_COMPILER_FLAG_STD_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX11)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=gnu++0x" CXX_COMPILER_FLAG_STD_CXX0X)
  if(CXX_COMPILER_FLAG_STD_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++0x")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX0X)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

if(NOT CXX_COMPILER_STD_FLAG_SET)
  check_cxx_compiler_flag("-std=c++0x" CXX_COMPILER_FLAG_STD_CXX0X)
  if(CXX_COMPILER_FLAG_STD_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    set(CXX_COMPILER_STD_FLAG_SET true)
  endif(CXX_COMPILER_FLAG_STD_CXX0X)
endif(NOT CXX_COMPILER_STD_FLAG_SET)

#
# Produce colour output for errors if possible...
#
check_cxx_compiler_flag("-fdiagnostics-color=auto" CXX_COMPILER_FLAG_COLOUR)
if(CXX_COMPILER_FLAG_COLOUR)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color=auto")
endif()

#
# Support C++ Concepts TS if possible...
#
check_cxx_compiler_flag("-fconcepts" CXX_COMPILER_FLAG_CONCEPTS)
if(CXX_COMPILER_FLAG_CONCEPTS)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fconcepts")
endif()

#
# For now drop warnings when an attribute is not used to prevent noise from 
# the use of __attribute__ in Khronos headers...
#
#check_cxx_compiler_flag("-Wno-ignored-attributes" CXX_COMPILER_FLAG_NO_IGNORED_ATTRS)
#if(CXX_COMPILER_FLAG_NO_IGNORED_ATTRS)
#  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-ignored-attributes")
#endif()

#############################################################################

#
# GLIBC 2.25 defines POSIX' issubnormal() (as a macro) which conflicts with
# Khronos headers' extern function definition issubnormal. If 
# issubnormal() is defined without the Khronos headers then the following
# CMake variables are set:
#
#   C_COMPILER_ISSUBNORMAL_IS_DEFINED
#   CXX_COMPILER_ISSUBNORMAL_IS_DEFINED
#
# as this will allow either an #undef issubnormal or for the Khronos headers
# to NOT define the extern function. Technically in C99 there is a macro
# FP_SUBNORMAL defined as well:
#   http://en.cppreference.com/w/c/numeric/math/FP_categories
#
# See:
#   https://www.gnu.org/software/libc/manual/html_node/Floating-Point-Classes.html#index-issubnormal
#     - which notes that issubnormal() is from TS 18661-1:2014, i.e.,
#       - https://www.iso.org/standard/63146.html
#

CHECK_C_SOURCE_COMPILES(
"
#include <math.h>
#include <stdio.h>
int main() 
{
  float x = 0.0F;
  printf(\"%d\",issubnormal(x));
}
"
  C_COMPILER_ISSUBNORMAL_IS_DEFINED
)

CHECK_CXX_SOURCE_COMPILES(
"
#include <cmath>
#include <cstdio>

using namespace std;

int main() 
{
  float x = 0.0F;
  printf(\"%d\",issubnormal(x));
}
"
  CXX_COMPILER_ISSUBNORMAL_IS_DEFINED
)

#############################################################################

