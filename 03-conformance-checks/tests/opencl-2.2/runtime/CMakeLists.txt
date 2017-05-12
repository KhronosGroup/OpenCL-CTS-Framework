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

set(CL_OFFLINE_COMPILER "${CMAKE_OPENCL_C_COMPILER}")
set(CL_LIBCLCXX_DIR "${CMAKE_OPENCL_CXX_STDLIB_INCLUDE}")
set(CL_INCLUDE_DIR "${VENDOR_BASE_INCL_DIR}")
set(CL_LIB_DIR "${VENDOR_BASE_LIB_DIR}")
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ".")
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${TMPDIR}")

#message(INFO "Invoking test with CL_OFFLINE_COMPILER=${CL_OFFLINE_COMPILER}")
#message(INFO "CL_LIBCLCXX_DIR=${CL_LIBCLCXX_DIR}" )
#message(INFO "CL_INCLUDE_DIR=${CL_INCLUDE_DIR}")
#message(INFO "CL_LIB_DIR=${CL_LIB_DIR}")

#message(FATAL "TMPDIR: ${TMPDIR}")
set(OPENCL_LIBRARIES "OpenCL")

#add_subdirectory(${CHECKS_BASE}/opencl-2.2/runtime/khronos
#  ${RESULTS_BASE}/opencl-2.2/runtime/khronos)
