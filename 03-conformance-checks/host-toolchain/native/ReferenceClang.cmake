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

# WARNING: Do not use this for Khronos tests--Clang 3.6 does not implement
#          all required GCC extensions

include(${CMAKE_CURRENT_LIST_DIR}/../../cmake/Common.cmake)

set(CMAKE_C_COMPILER ${REF_CL_TOOLCHAIN_BASE}/compiler/bin/clang)
set(CMAKE_CXX_COMPILER ${CMAKE_C_COMPILER}++)
