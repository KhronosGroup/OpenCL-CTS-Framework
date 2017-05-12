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

set(BOOTSTRAP_CMAKE_BIN ${INSTALL_BASE}/cmake/bin/cmake${SUFFIX})

# Bootstrap CMake
if(EXISTS ${BOOTSTRAP_CMAKE_BIN})
  message("Bootstrapped CMake version detected.  Bootstrap cmake will be updated.")
  bootstrap_component(cmake)
elseif(${CMAKE_VERSION} VERSION_LESS 3.8.0)
  message("No bootstrap CMake found and system CMake version ${CMAKE_VERSION} < 3.8.0.  Bootstrap latest cmake.")
  bootstrap_component(cmake)
else(EXISTS ${BOOTSTRAP_CMAKE_BIN})
  message("No bootstrap CMake found and system CMake version ${CMAKE_VERSION} >= 3.8.0.  Using system CMake.")
endif()

