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

# Enable script to run even if ran from another working directory
dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd $dir

# Read in the paths in order to set PATH variable correctly
eval $(cmake -DPATHTYPE:string=BASH -P cmake/GenPaths.cmake)

if [ $# -eq 0 ]; then
  echo "Usage: ./clean.sh (--installs|--everything)"
  echo "Options:"
  echo "--installs: Remove installed binaries, including bootstrapped components, conformance tests, and headers"
  echo "--everything: Remove installed binaries, bootstrapped components, conformance tests, headers, downloaded sources, and build directories"
  exit 0
fi

if [ "$1" == "--everything" ]; then
  cmake -DBUILD:string="" -DDLOADS:string="" -DCHECKS:string="" -DSDKS:string="" -DCL_REFHEADERS:string="" -DSPIRV_HEADERS:string="" -DSPIRV_TOOLS:string="" -DREF_CL_TOOLCHAIN:string="" -P cmake/Clean.cmake
  exit 0
fi

if [ "$1" == "--installs" ]; then
  cmake -DCHECKS:string="" -DSDKS:string="" -DCL_REFHEADERS:string="" -DSPIRV_HEADERS:string="" -DSPIRV_TOOLS:string="" -DREF_CL_TOOLCHAIN:string="" -P cmake/Clean.cmake
  exit 0
fi
