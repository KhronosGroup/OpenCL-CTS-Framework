#! /bin/sh

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

# Enable script to work even if started in another directory
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

# Read in the paths in order to set PATH variable correctly
eval $(cmake -DPATHTYPE:string=BASH -P cmake/GenPaths.cmake)

# Use bootstrapped utilities if possible
BUILDSYSTEM_BASE=$(pwd)
export PATH=$INSTALL_BASE/cmake/bin:$INSTALL_BASE/ninja/bin:$PATH
hash -r

# Bootstrap CMake if necessary
cmake -P bootstrap/BootstrapCMake.cmake

# Bootstrap Ninja if necessary (using new CMake)
cmake -P bootstrap/BootstrapNinja.cmake

#
# Build the Khronos OpenCL C/C++/SPIR/SPIRV compiler toolset
# using the previously built CMake and Ninja.
#
cmake -DBUILD_TOOL_CMAKE_G:string="-G;Ninja" -P cmake/BuildOpenCLToolset.cmake
