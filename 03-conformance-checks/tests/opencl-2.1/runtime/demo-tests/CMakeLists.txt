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

#begin_host_conformance_tests(${CONF_CHECK_TEST_TYPE})

#SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-ignored-attributes")

set(CONF_TEST_INFO
  "Section 4.1: Querying Platform Info clGetPlatformIDs 1" 
    sect-4_1-clGetPlatformIDs-1
  "Section 4.1: Querying Platform Info clGetPlatformIDs 2" 
    sect-4_1-clGetPlatformIDs-2
  "Section 4.1: Querying Platform Info clGetPlatformIDs 3" 
    sect-4_1-clGetPlatformIDs-3
)
list(LENGTH CONF_TEST_INFO CONF_TEST_INFO_LENGTH)
math(EXPR CONF_TEST_INFO_LENGTH '${CONF_TEST_INFO_LENGTH}-1')

add_custom_target(opencl21host_runtime)

set(DEPENDS "")

foreach(i RANGE 0 ${CONF_TEST_INFO_LENGTH} 2)
  unset(TMP_DESC)
  list(GET CONF_TEST_INFO ${i} TMP_DESC)

  math(EXPR TMP_NEXTIDX '${i}+1')
  unset(TMP_BASENAME)
  list(GET CONF_TEST_INFO ${TMP_NEXTIDX} TMP_BASENAME)

  #
  # Attempt to construct a compiler command line to compile a file
  # without linking using CMake variables.  TODO: This will need more work.
  #

  #Detect if C or C++
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${TMP_BASENAME}.cxx")
    set(COMPILER ${CMAKE_CXX_COMPILER})
    set(COMPILER_FLAGS ${CMAKE_CXX_FLAGS})
    set(LANG "C++")
    set(CLTEST "${TMP_BASENAME}.cxx")
  elseif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${TMP_BASENAME}.c")
    set(COMPILER ${CMAKE_C_COMPILER})
    set(COMPILER_FLAGS ${CMAKE_C_FLAGS})
    set(LANG "C")
    set(CLTEST "${TMP_BASENAME}.c")
  else()
    message(FATAL_ERROR
      "File ${CMAKE_CURRENT_SOURCE_DIR}/${CLTEST} does not exist.")
  endif()

  GET_PROPERTY(
    PROJECT_INCLUDE_DIRECTORIES DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} 
    PROPERTY INCLUDE_DIRECTORIES
  )

  #message(STATUS "${Red}Include dirs: ${PROJECT_INCLUDE_DIRECTORIES}")

  separate_arguments(COMPILER_FLAGS)

  #Workaround for MSVC-Clang:
  #Change /DWIN32 flag to -DWIN32

  string(REPLACE "/DWIN32" "-DWIN32" COMPILER_FLAGS "${COMPILER_FLAGS}")

  set(COMPILE_COMMAND_LINE
    ${COMPILER}
	${COMPILER_FLAGS}
  )

  foreach(i ${PROJECT_INCLUDE_DIRECTORIES})
    list(APPEND COMPILE_COMMAND_LINE -I ${i})
  endforeach(i)

  list(APPEND COMPILE_COMMAND_LINE
    -c
    @IN@
    -o @OUT@
  )

  add_run_time_conformance_test(${TMP_DESC} ${CLTEST}
   ${TMP_BASENAME} ${TEST_TYPE} "host" "C" "OpenCL 2.1" opencl21host_runtime
  )
    
  unset(TMP_BASENAME)
  unset(TMP_DESC)
endforeach(i)

add_dependencies(runtime opencl21host_runtime)
