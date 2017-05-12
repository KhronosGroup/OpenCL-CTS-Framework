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

cmake_minimum_required(VERSION 3.8.0 FATAL_ERROR)

project(ConformanceCheck)

include(GNUInstallDirs)
#include(${PROJECT_SOURCE_DIR}/cmake/CompilerChecks.cmake)
include(${PROJECT_SOURCE_DIR}/cmake/ConformanceTestUtils.cmake)

#
# Currently this conformance demonstration does not make use of library files
# so the following LINK_DIRECTORIES() line is commented out.
#
#LINK_DIRECTORIES(write this CMake Project's library path in here)

#
# Three variables required:
# TEST_TYPE: "compiletime-host", "compiletime-device", "runtime"
# OPENCL_VERSION: major.minor (e.g. 2.1, 1.2, etc)
# VENDOR_HEADERS: the name of the vendor-specific OpenCL headers to use on a given
# platform.  If not specified, the reference OpenCL headers will be used.
#
# Extra options:
# HOST: "native" by default, may be overriden to "android-arm64" or other cross
# compilation targets
# OFFLINE_CL_COMPILER: "khronos" by defuault.  Location:
#   opencl-toolchain/opencl-${OPENCL_VERSION}/khronos/toolchain.cmake
#
#
#
#

include(${PROJECT_SOURCE_DIR}/cmake/Common.cmake)

# Check that required variables are defined:

if (NOT TEST_TYPE)
  message(FATAL_ERROR "Must define TEST_TYPE to be one of the following:
compiletime-host, runtime, compiletime-device")
else()
  message(STATUS "CONFORMANCE TEST: test type: ${TEST_TYPE}")
endif()

if (NOT OPENCL_VERSION)
   message(FATAL_ERROR "Must define OPENCL_VERSION to be a string X.Y, \
where X is the major version and Y is the minor version of the OpenCL \
implementation to be tested")
else()
  message(STATUS "CONFORMANCE TEST: OpenCL version: ${OPENCL_VERSION}")
endif()

#Set HOST to native by default (may be overridden)

if (NOT HOST)
  set(HOST "native")
endif()


if (VENDOR)
  if (NOT VENDOR_OPENCL_TOOLCHAIN AND EXISTS
    "${PROJECT_SOURCE_DIR}/opencl-toolchain/opencl-${OPENCL_VERSION}/${VENDOR}/toolchain.cmake")
    get_filename_component(VENDOR_OPENCL_TOOLCHAIN "${PROJECT_SOURCE_DIR}/opencl-toolchain/opencl-${OPENCL_VERSION}/${VENDOR}/toolchain.cmake"
      REALPATH)
  endif()
endif()

if(NOT DEFINED VENDOR_HEADERS)
  get_filename_component(VENDOR_BASE_INCL_DIR
    "${CL_REFHEADERS_BASE}/opencl-${OPENCL_VERSION}"
    REALPATH
  )
else(NOT DEFINED VENDOR_HEADERS)
  get_filename_component(VENDOR_BASE_INCL_DIR
    "${SDKS_BASE}/opencl-${OPENCL_VERSION}/${HOST}/${VENDOR_HEADERS}/include"
    REALPATH
  )
endif()

if(NOT DEFINED OFFLINE_CL_COMPILER)
  set(OFFLINE_CL_COMPILER "khronos")
endif()

get_filename_component(VENDOR_BASE_LIB_DIR
  ${SDKS_BASE}/opencl-${OPENCL_VERSION}/${HOST}/icd_loader
  REALPATH
)

if (EXISTS "${PROJECT_SOURCE_DIR}/opencl-toolchain/opencl-${OPENCL_VERSION}/${OFFLINE_CL_COMPILER}/toolchain.cmake")
  get_filename_component(VENDOR_OPENCL_TOOLCHAIN "${PROJECT_SOURCE_DIR}/opencl-toolchain/opencl-${OPENCL_VERSION}/${OFFLINE_CL_COMPILER}/toolchain.cmake"
    REALPATH)
else()
  message("OpenCL toolchain not found -- continuing without")
endif()

if(VENDOR_OPENCL_TOOLCHAIN)
  include (${VENDOR_OPENCL_TOOLCHAIN})
  message(STATUS "${BoldBlue}OpenCL offline toolchain: \
${ColourReset}${CMAKE_OPENCL_TOOLCHAIN_NAME}")
  if (CMAKE_OPENCL_C_COMPILER)
    message(STATUS "${BoldCyan}OpenCL C ${BoldBlue}offline \
compiler:${ColourReset} ${CMAKE_OPENCL_C_COMPILER}")
  endif()
  if (CMAKE_OPENCL_CXX_COMPILER)
    message(STATUS "${BoldCyan}OpenCL C++ ${BoldBlue}offline \
compiler: ${ColourReset}${CMAKE_OPENCL_CXX_COMPILER}")
    if (CMAKE_OPENCL_CXX_STDLIB)
      message(STATUS "${BoldCyan}OpenCL C++ ${BoldYellow}standard \
library${BoldBlue}: ${ColourReset}${CMAKE_OPENCL_CXX_STDLIB}")
    else()
      message(FATAL_ERROR "OpenCL C++ offline compiler defined, but no
      standard library has been selected.  Please ensure your toolchain has
      defined CL_OPENCL_CXX_STDLIB")
    endif()
  endif()
endif()

enable_testing()

set(BUILDSYSTEM_BASE "${PROJECT_SOURCE_DIR}/../02-buildsystem")
#include(${BUILDSYSTEM_BASE}/BuildSystem.cmake)

# Load the CMakeLists.txt for this conformance test...
#
add_custom_target(compiletime-host ALL)
add_custom_target(compiletime-device ALL)
add_custom_target(runtime ALL)

# TODO: support running multiple types of tests at once
# Shouldn't be too hard

# Add official Khronos tests if they exist

if(EXISTS ${CHECKS_BASE}/opencl-${OPENCL_VERSION} AND ${TEST_TYPE} STREQUAL runtime)
  set(CL_OFFLINE_COMPILER "${CMAKE_OPENCL_C_COMPILER}")
  set(CL_LIBCLCXX_DIR "${CMAKE_OPENCL_CXX_STDLIB_INCLUDE}")
  set(CL_INCLUDE_DIR "${VENDOR_BASE_INCL_DIR}")
  set(CLConform_INCLUDE_DIR ${VENDOR_BASE_INCL_DIR})
  set(CL_LIB_DIR "${VENDOR_BASE_LIB_DIR}")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ".")
  #set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${TMPDIR}")                                                                                                                                      
                                                                                                                                                                                        
  message(INFO "Invoking Khronos tests with CL_OFFLINE_COMPILER=${CL_OFFLINE_COMPILER}")                                                                                                        
  message(INFO "CL_LIBCLCXX_DIR=${CL_LIBCLCXX_DIR}" )                                                                                                                                  
  message(INFO "CL_INCLUDE_DIR=${CL_INCLUDE_DIR}")                                                                                                                                     
  message(INFO "CL_LIB_DIR=${CL_LIB_DIR}")                                                                                                                                             
                                                                                                                                                                                        
  #message(FATAL "TMPDIR: ${TMPDIR}")                                                                                                                                                   
  set(OPENCL_LIBRARIES "OpenCL")

  #Force enable -Wno-narrowing for OpenCL 2.1 and below
  if("${OPENCL_VERSION}" VERSION_LESS 2.2)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-narrowing")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-narrowing")
  endif()

  #OpenCL 2.0 and under requires pthreads
  if("${OPENCL_VERSION}" VERSION_LESS 2.1)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pthread")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -pthread")
 endif()
 
  #Workaround for 1.2 tests, CMakeLists is in a different spot
  if("${OPENCL_VERSION}" STREQUAL "1.2")
  add_subdirectory(${CHECKS_BASE}/opencl-${OPENCL_VERSION}/test_conformance
    ${KHRBUILD_BASE}/opencl-${OPENCL_VERSION})
  else("${OPENCL_VERSION}" STREQUAL "1.2")
  add_subdirectory(${CHECKS_BASE}/opencl-${OPENCL_VERSION}
    ${KHRBUILD_BASE}/opencl-${OPENCL_VERSION})
  endif("${OPENCL_VERSION}" STREQUAL "1.2")
endif()

#Add in other tests as well
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/tests/opencl-${OPENCL_VERSION}/${TEST_TYPE})
