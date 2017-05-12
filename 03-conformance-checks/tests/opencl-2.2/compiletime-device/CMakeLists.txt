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

cmake_minimum_required(VERSION 3.6.0 FATAL_ERROR)

include(${PROJECT_SOURCE_DIR}/cmake/CompilerChecks.cmake)

if (NOT CMAKE_OPENCL_CXX_COMPILER)
  message(FATAL_ERROR "You have requested to run the CTS on your OpenCL 2.2 \
  implementation with a compiletime-device test, but did not specify your OpenCL \
  toolchain correctly (CMAKE_OPENCL_CXX_COMPILER is not defined).")
endif()

set(CLCXX ${CMAKE_OPENCL_CXX_COMPILER})
set(LIBCLCXX_INCLUDE "${CMAKE_OPENCL_CXX_STDLIB}/include")

#begin_device_conformance_tests(${CONF_CHECK_TEST_TYPE} "clcxx")

# TODO: Do this automatically.  This is needed so that there is a directory 
#       to put logs and object files in.
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/demo-tests)
file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/libclcxx-imported)

# The following demo-tests subdirectory is a demonstration of how
# to write custom tests. (Uncomment it to try using it.)
#
#set(CONF_TEST_INFO
#  "Sect 3.5.2.1: global class"
#  demo-tests/sect-3_5_2_1
#
#  "Sect 3.10.1.1: Header <opencl_work_item>"
#  demo-tests/sect-3_10_1_1
#
#  "Sect 3.10.4.1: Header <opencl_math>"
#  demo-tests/sect-3_10_4_1
#)

# Add the files in libclcxx-imported
# TODO: Refactor this as it's not clean
file(GLOB_RECURSE TESTS_LIBCLCXX
  "${CHECKS_BASE}/opencl-2.2/compiletime-device/khronos/*.cl" )

# TODO: For now, it's OK to just glob these.  In the future
#       it would be wise to use add_subdirectory instead
foreach(i ${TESTS_LIBCLCXX})
  get_filename_component(READABLE ${i} NAME_WE)
  get_filename_component(DIR ${i} DIRECTORY)
  file(RELATIVE_PATH RELPATH ${CMAKE_CURRENT_SOURCE_DIR} ${DIR})
  list(APPEND CONF_TEST_INFO ${READABLE} ${RELPATH}/${READABLE})
  file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/${RELPATH})
  #message(STATUS "Importing: ${READABLE} -- ${RELPATH}/${READABLE}.cl")
endforeach(i)

list(LENGTH CONF_TEST_INFO CONF_TEST_INFO_LENGTH)
math(EXPR CONF_TEST_INFO_LENGTH '${CONF_TEST_INFO_LENGTH}-1')

set(DEPENDS "")

foreach(i RANGE 0 ${CONF_TEST_INFO_LENGTH} 2)
  unset(TMP_DESC)
  list(GET CONF_TEST_INFO ${i} TMP_DESC)
  
  math(EXPR TMP_NEXTIDX '${i}+1')
  unset(TMP_BASENAME)
  list(GET CONF_TEST_INFO ${TMP_NEXTIDX} TMP_BASENAME)
  
  #unset(TMP_BASELANG)
  #math(EXPR TMP_NEXTNEXTIDX '${i}+2')
  #list(GET CONF_TEST_INFO ${TMP_NEXTNEXTIDX} TMP_BASELANG)

  # Compiler command lines to use below

  #if(${TEST_LANGUAGE} STREQUAL "clcxx")
  #  set(COMPILE_COMMAND_LINE
  #    "${CLANG_CL};-cc1;-emit-spirv;-triple;spir-unknown-unknown;-cl-std=c++;-I;${VENDOR_BASE_INCL_DIR};-x;cl;-o;@OUT@;@IN@")
  #elseif(${TEST_LANGUAGE} STREQUAL "clc")
  #  set(COMPILE_COMMAND_LINE
  #    "${CLANG_CL};-cc1;-emit-spirv;-triple;spir-unknown-unknown;-cl-std=CL2.0;-include;opencl.h;-x;cl;-o;@OUT@;@IN@")
  #else(${TEST_LANGUAGE} STREQUAL "clcxx")
  #  message(FATAL_ERROR "Language ${TEST_LANGUAGE} not recognized!")
  #endif(${TEST_LANGUAGE} STREQUAL "clcxx")

  #set(COMPILE_COMMAND_LINE
  #  "${CLANG_CL};-cc1;-emit-spirv;-triple;\
  #spir-unknown-unknown;-cl-std=c++;-I;${VENDOR_BASE_INCL_DIR};-x;cl;-o;@OUT@;@IN@")

  # Made more flexible...but still may require work
  set(COMPILE_COMMAND_LINE
    ${CMAKE_OPENCL_CXX_COMPILER}
    ${CMAKE_OPENCL_CXX_DEFAULT_FLAGS}
    ${CMAKE_OPENCL_CXX_INCLUDE_FLAG} ${CMAKE_OPENCL_CXX_STDLIB_INCLUDE}
    ${CMAKE_OPENCL_CXX_OUTPUT_FLAG} @OUT@
    ${CMAKE_OPENCL_CXX_INPUT_FLAG} @IN@
  )


  add_compile_time_conformance_test(${TMP_DESC}
    ${TMP_BASENAME}.cl
    ${TMP_BASENAME}.spv
    ${TEST_TYPE} "device" "OpenCL C++" "OpenCL 2.2"
    "${COMPILE_COMMAND_LINE}" DEPENDS)

  unset(TMP_BASENAME)
  unset(TMP_DESC)
endforeach(i)

#cl_lang_to_string("clcxx" CL_LANG)

end_compile_time_conformance_tests(${TEST_TYPE}
  opencl22cxx_compiletime-device
  "device" "OpenCL C++" "OpenCL 2.2" "${DEPENDS}")

add_dependencies(compiletime-device opencl22cxx_compiletime-device)
