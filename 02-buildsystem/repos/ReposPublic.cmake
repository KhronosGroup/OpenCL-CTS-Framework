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

#############################################################################
# Khronos Public Repositories
#############################################################################
message("Including Khronos Public OpenCL Repositories")

externalproject_add(
  SPIRVLLVM PREFIX "${DLOADS_BASE}/spirv-llvm"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/SPIRV-LLVM.git"
  #GIT_REPOSITORY "https://github.com/InBetweenNames/SPIRV-LLVM.git"
  GIT_TAG "khronos/spirv-3.6.1"
  GIT_SHALLOW 1
  INSTALL_DIR "${REF_CL_TOOLCHAIN_BASE}/compiler"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)

externalproject_add(
  SPIRVCLANG PREFIX "${DLOADS_BASE}/spirv-clang"
  DEPENDS SPIRVLLVM
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/SPIR.git"
  #GIT_REPOSITORY "https://github.com/InBetweenNames/SPIR.git"
  GIT_TAG "spirv-1.1"
  GIT_SHALLOW 1
  INSTALL_DIR "${REF_CL_TOOLCHAIN_BASE}/compiler"
  CMAKE_ARGS
  -DCMAKE_PREFIX_PATH=<INSTALL_DIR> -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
)

externalproject_add(
  LIBCLCXX PREFIX "${DLOADS_BASE}/libclcxx"
  DEPENDS SPIRVLLVM SPIRVCLANG
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/libclcxx.git"
  GIT_SHALLOW 1
  INSTALL_DIR "${REF_CL_TOOLCHAIN_BASE}/stdlib"
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> -DLIT_EXECUTABLE:FILEPATH=${REF_CL_TOOLCHAIN_BASE}/compiler/bin/llvm-lit -DPYTHON_EXECUTABLE:FILEPATH=python3
)

externalproject_add_step(
  LIBCLCXX finalize
  COMMAND ${CMAKE_COMMAND} -DBUILDSYSTEM_BASE=${BUILDSYSTEM_BASE} -P ${BUILDSYSTEM_BASE}/repos/LibclcxxFinalize.cmake 
  DEPENDEES install
)

externalproject_add_step(
  SPIRVCLANG finalize
  COMMAND ${CMAKE_COMMAND} -DBUILDSYSTEM_BASE=${BUILDSYSTEM_BASE} -P ${BUILDSYSTEM_BASE}/repos/SPIRFinalize.cmake
  DEPENDEES install
)

externalproject_add(
  OPENCL_HEADERS PREFIX "${DLOADS_BASE}/opencl_headers"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-Headers"
  GIT_TAG "master"
  GIT_SHALLOW 1
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND ${CMAKE_COMMAND} -DBUILDSYSTEM_BASE=${BUILDSYSTEM_BASE} -P ${BUILDSYSTEM_BASE}/repos/HeadersFinalize.cmake
)

externalproject_add(
  OPENCL_ICD PREFIX "${DLOADS_BASE}/icd_loader"
  DEPENDS OPENCL_HEADERS
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-ICD-Loader"
  GIT_TAG "master"
  GIT_SHALLOW 1
  CMAKE_ARGS -DCMAKE_C_FLAGS=-I${CL_REFHEADERS_BASE}/opencl-2.2 #-DCMAKE_PREFIX_PATH=<INSTALL_DIR> -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
  #INSTALL_COMMAND cmake -E copy_directory <BINARY_DIR>/bin <INSTALL_DIR>
  INSTALL_COMMAND ${CMAKE_COMMAND} -DBUILDSYSTEM_BASE=${BUILDSYSTEM_BASE} -P ${BUILDSYSTEM_BASE}/repos/ICDFinalize.cmake
  )

externalproject_add(
  OPENCL_CONFTESTS_12 PREFIX "${DLOADS_BASE}/opencl_conftests_1.2"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-CTS.git"
  GIT_TAG "cl12_trunk"
  GIT_SHALLOW 1
  INSTALL_DIR "${CHECKS_BASE}/opencl-1.2/"
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
)

externalproject_add(
  OPENCL_CONFTESTS_20 PREFIX "${DLOADS_BASE}/opencl_conftests_2.0"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-CTS.git"
  GIT_TAG "cl20_trunk"
  GIT_SHALLOW 1
  INSTALL_DIR "${CHECKS_BASE}/opencl-2.0/"
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
)

externalproject_add(
  OPENCL_CONFTESTS_21 PREFIX "${DLOADS_BASE}/opencl_conftests_2.1"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-CTS.git"
  GIT_TAG "cl21_trunk"
  GIT_SHALLOW 1
  INSTALL_DIR "${CHECKS_BASE}/opencl-2.1/"
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
)

externalproject_add(
  OPENCL_CONFTESTS_22 PREFIX "${DLOADS_BASE}/opencl_conftests_2.2"
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/OpenCL-CTS.git"
  GIT_TAG "master"
  GIT_SHALLOW 1
  INSTALL_DIR "${CHECKS_BASE}/opencl-2.2/"
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR> <INSTALL_DIR>
)

externalproject_add(
  SPIRV_HEADERS PREFIX ${DLOADS_BASE}/spirv_headers
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/SPIRV-Headers.git"
  GIT_TAG "master"
  GIT_SHALLOW 1
  INSTALL_DIR ${SPIRV_HEADERS_BASE}
  CONFIGURE_COMMAND cmake -E echo "CONFIGURE: No operation."
  BUILD_COMMAND cmake -E echo "BUILD: No operation."
  INSTALL_COMMAND cmake -E copy_directory <SOURCE_DIR>/ <INSTALL_DIR>
)

externalproject_add(
  SPIRV_TOOLS PREFIX ${DLOADS_BASE}/spirv_tools
  DEPENDS SPIRV_HEADERS
  EXCLUDE_FROM_ALL 1
  GIT_REPOSITORY "https://github.com/KhronosGroup/SPIRV-Tools.git"
  GIT_TAG "master"
  GIT_SHALLOW 1
  INSTALL_DIR ${SPIRV_TOOLS_BASE}
  CMAKE_ARGS -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR> -DSPIRV-Headers_SOURCE_DIR:PATH=${SPIRV_HEADERS_BASE}
)

set(ReposPublic SPIRVLLVM SPIRVCLANG LIBCLCXX OPENCL_HEADERS OPENCL_ICD OPENCL_CONFTESTS_12
  OPENCL_CONFTESTS_20 OPENCL_CONFTESTS_21 OPENCL_CONFTESTS_22 SPIRV_HEADERS SPIRV_TOOLS)
