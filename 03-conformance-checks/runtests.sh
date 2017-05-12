#!/bin/sh

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

# Enable this script to be run from anywhere (makes working dir script dir)
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

# Read in the paths in order to set PATH variable correctly
eval $(cmake -DPATHTYPE:string=BASH -P cmake/GetPaths.cmake)

# Update PATH with bootstrapped components
export PATH=$INSTALL_BASE/cmake/bin:$INSTALL_BASE/ninja/bin:$PATH                                                                                   
hash -r 

#if [ $# -eq 0 ]; then
  # Fallback to default
#fi

if [ "$1" == "--help" ]; then
  echo "Usage: $0 <TestConfig> (-G <generator name> (-T <platform>))"
  echo "Test configurations are stored in the 'configs' subdirectory"
  echo
  echo "Example: $0 default -G Ninja"
  echo
  echo "The specified generator and platforms are passed directly to CMake if specified"
  echo "These are sometimes necessary for compilers that are tied to certain build systems."
  exit 0
else
  TEST_CONFIG="-DTEST_CONFIG=$1"
fi

if [ "$2" == "-G" ]; then
  CMAKE_G_OPTION=-DCMAKE_G_OPTION="-G;$3"
fi

if [ "$4" == "-T" ]; then
  CMAKE_T_OPTION=-DCMAKE_T_OPTION="-T;$5"
fi

cmake ${TEST_CONFIG} ${CMAKE_G_OPTION} ${CMAKE_T_OPTION} -P cmake/RunTest.cmake
