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

set(CMAKE_OPENCL_TOOLCHAIN_NAME "Khronos reference OpenCL C/C++ compiler with\
 SPIR-V")

get_filename_component(CMAKE_OPENCL_C_COMPILER "${REF_CL_TOOLCHAIN_BASE}/compiler/bin/clang-cl" REALPATH)

set(CMAKE_OPENCL_CXX_COMPILER "${CMAKE_OPENCL_C_COMPILER}")

get_filename_component(CMAKE_OPENCL_CXX_STDLIB "${REF_CL_TOOLCHAIN_BASE}/stdlib" REALPATH)

get_filename_component(CMAKE_OPENCL_CXX_STDLIB_INCLUDE "${CMAKE_OPENCL_CXX_STDLIB}/include/openclc++" REALPATH)

set(CMAKE_OPENCL_CXX_INCLUDE_FLAG "-I")

set(CMAKE_OPENCL_CXX_OUTPUT_FLAG "-o")

set(CMAKE_OPENCL_CXX_INPUT_FLAG "")

set(CMAKE_OPENCL_CXX_DEFAULT_FLAGS
    -cc1
    -emit-spirv
    -triple spir-unknown-unknown
    -cl-std=c++
    -x cl
  )

