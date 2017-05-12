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

# Needed to print to stdout cleanly
function(CleanMessage)
  execute_process(COMMAND ${CMAKE_COMMAND} -E echo "${ARGN}")
endfunction()

if(PATHTYPE STREQUAL BASH)
  function(printvar VAR)
    CleanMessage("${VAR}=${${VAR}}")
  endfunction(printvar)
else(PATHTYPE STREQUAL CMD)
  function(printvar VAR)
    CleanMessage("set ${VAR}=${${VAR}}")
  endfunction(printvar)
endif()

printvar(INSTALL_BASE)
printvar(BUILD_BASE)
printvar(DLOADS_BASE)
printvar(CHECKS_BASE)
printvar(SDKS_BASE)
printvar(BUILDSYSTEM_BASE)
printvar(CTS_BASE)
