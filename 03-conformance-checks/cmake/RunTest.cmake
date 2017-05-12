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

include(${CMAKE_CURRENT_LIST_DIR}/Common.cmake)

if(TEST_CONFIG)
  # Allow configs/test.cmake to be implitly converted to "test"
  get_filename_component(TEST_CONFIG ${TEST_CONFIG} NAME)
  string(REPLACE ".cmake" "" TEST_CONFIG ${TEST_CONFIG})
  include(${CMAKE_CURRENT_LIST_DIR}/../configs/${TEST_CONFIG}.cmake)
else()
  include(${CMAKE_CURRENT_LIST_DIR}/../configs/default.cmake)
endif()

find_program(NINJA ninja)

# By default, use Ninja (if present)
if(NINJA AND NOT DEFINED CMAKE_G_OPTION)
  set(CMAKE_G_OPTION -G Ninja)
endif()

# TODO: include date?
get_filename_component(TMPDIR ${RESULTS_BASE}/opencl-${OPENCL_VERSION}-${TEST_TYPE} REALPATH)                                                         
file(REMOVE_RECURSE ${TMPDIR})

file(MAKE_DIRECTORY ${TMPDIR})

function(forward_arg VAR)
  if(${VAR})
    list(APPEND F_ARGS "-D${VAR}=${${VAR}}")
    #set(${FWD} "-D${VAR}=${${VAR}}" PARENT_SCOPE)
  endif()
  set(F_ARGS ${F_ARGS} PARENT_SCOPE)
endfunction(forward_arg)

if(NOT HOST)
  set(HOST "native")
  if (NOT HOST_TOOLCHAIN_FILE)
    set(HOST_TOOLCHAIN_FILE "SystemDefault")
  endif()
endif()

if(HOST_TOOLCHAIN_FILE)
  get_filename_component(CMAKE_TOOLCHAIN_FILE ${CTS_BASE}/host-toolchain/${HOST}/${HOST_TOOLCHAIN_FILE}.cmake REALPATH)
endif()

forward_arg(CMAKE_TOOLCHAIN_FILE CMAKE_TOOLCHAIN_FILE_FWD)
forward_arg(ANDROID_NDK)
forward_arg(ANDROID_ABI)
forward_arg(ANDROID_NATIVE_API_LEVEL)
forward_arg(ANDROID_TOOLCHAIN_NAME)
forward_arg(HOST)
forward_arg(TEST_TYPE)
forward_arg(OPENCL_VERSION)
forward_arg(VENDOR_HEADERS)
forward_arg(OFFLINE_CL_COMPILER)

execute_process(
  COMMAND ${CMAKE_COMMAND}
    ${CTS_BASE}
    ${CMAKE_TOOLCHAIN_FILE_FWD}
    ${F_ARGS}
    ${CMAKE_G_OPTION}
    ${CMAKE_T_OPTION}
  WORKING_DIRECTORY ${TMPDIR})

#--target ${TEST_TYPE}
execute_process(
  COMMAND ${CMAKE_COMMAND}
    --build .
  WORKING_DIRECTORY ${TMPDIR}
  )

if ("${TEST_TYPE}" STREQUAL "runtime" AND "${HOST}" STREQUAL native)
  execute_process(COMMAND ctest WORKING_DIRECTORY ${TMPDIR})
endif()
