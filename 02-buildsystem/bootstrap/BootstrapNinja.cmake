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

# The purpose of this script is to ensure CMake and Ninja are installed
# and up to date on the system.
include(${CMAKE_CURRENT_LIST_DIR}/BootstrapCommon.cmake)

set(BOOTSTRAP_NINJA_BIN ${INSTALL_BASE}/ninja/bin/ninja${SUFFIX})

find_program(NINJA_SYSTEM ninja)

# Bootstrap Ninja
if(EXISTS ${BOOTSTRAP_NINJA_BIN})
  message("Bootstrapped Ninja version detected.  Bootstrap Ninja will be updated.")
  bootstrap_component(ninja)
elseif("${NINJA_SYSTEM}" STREQUAL "NINJA_SYSTEM-NOTFOUND")
  message("No bootstrap or system Ninja found.  Building bootstrap Ninja.")
  bootstrap_component(ninja)
else(EXISTS ${BOOTSTRAP_NINJA_BIN})
  execute_process(
    COMMAND ${NINJA_SYSTEM} --version
    OUTPUT_VARIABLE NINJA_VERSION
    )
  string(STRIP "${NINJA_VERSION}" NINJA_VERSION)
  if("${NINJA_VERSION}" VERSION_LESS 1.7.2)
    message("No bootstrap Ninja found and system Ninja version ${NINJA_VERSION} < 1.7.2.  Building bootstrap Ninja.")
    bootstrap_component(ninja)
  else("${NINJA_VERSION}" VERSION_LESS 1.7.2)
    message("No bootstrap Ninja found and system Ninja version ${NINJA_VERSION} >= 1.7.2.  Using system Ninja.")
  endif()
endif()

