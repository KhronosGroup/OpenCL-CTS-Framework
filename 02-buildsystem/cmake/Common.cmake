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

# This file contains some common definitions for the buildsystem

if(NOT DEFINED BUILDSYSTEM_BASE)
  get_filename_component(BUILDSYSTEM_BASE ${CMAKE_CURRENT_LIST_DIR}/.. REALPATH)
endif()

#get_filename_component(CTS_BASE ${BUILDSYSTEM_BASE}/../03-conformance-checks REALPATH)

get_filename_component(REPO_BASE ${BUILDSYSTEM_BASE}/.. REALPATH)
get_filename_component(REPO_BASENAME ${REPO_BASE} NAME)

get_filename_component(REPO_UPPERDIR ${BUILDSYSTEM_BASE}/../.. REALPATH)

# These can be overridden as needed.  Changes are automatically propogated 
# through the buildsystem...

# Where prefixes for various programs are located (e.g. LLVM/CLANG, CMake, Ninja)
get_filename_component(INSTALL_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-installs REALPATH) 
# The "main" build directory for the buildsystem.  Contains only state about external projects.
get_filename_component(BUILD_BASE ${REPO_BASE}/buildsystem_state REALPATH) 
# Where external projects are stored.  For example, the local git repo of LLVM or CMake.
get_filename_component(DLOADS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-dloads REALPATH) 
# Where downloaded conformance test suites are stored
get_filename_component(CHECKS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-opencl/checks REALPATH) 
# Where downloaded OpenCL SDKs are stored
get_filename_component(SDKS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-opencl/sdks REALPATH) 
# Where downloaded OpenCL Khronos reference headers are stored
get_filename_component(CL_REFHEADERS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-opencl/refheaders REALPATH) 

# Where SPIRV headers go
get_filename_component(SPIRV_HEADERS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-spirv/headers REALPATH) 
# Where SPIRV tools go
get_filename_component(SPIRV_TOOLS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-spirv/tools REALPATH) 
# Where OpenCL C/OpenCL C++ compiler toolchains go
get_filename_component(CL_TOOLCHAIN_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-opencl/toolchains REALPATH)

get_filename_component(REF_CL_TOOLCHAIN_BASE ${CL_TOOLCHAIN_BASE}/khronos REALPATH)

set(ALL_BASE_VARS INSTALL_BASE BUILD_BASE DLOADS_BASE CHECKS_BASE SDKS_BASE
  CL_REFHEADERS_BASE SPIRV_HEADERS_BASE SPIRV_TOOLS_BASE REF_CL_TOOLCHAIN_BASE)
