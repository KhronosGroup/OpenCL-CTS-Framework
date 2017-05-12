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

# Build the Khronos OpenCL C/C++/SPIR/SPIR-V compiler toolset as well as
# Khronos OpenCL ICD using the previously built CMake and Ninja

message("Configuring buildsystem")
file(MAKE_DIRECTORY ${BUILD_BASE})
execute_process(
  COMMAND cmake
  ${BUILDSYSTEM_BASE}
  ${BUILD_TOOL_CMAKE_G}
  WORKING_DIRECTORY ${BUILD_BASE}
)

message("Building all projects...")
execute_process(
  COMMAND cmake
  --build .
  --target buildall
  WORKING_DIRECTORY ${BUILD_BASE}
)
