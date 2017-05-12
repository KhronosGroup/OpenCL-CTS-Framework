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

include(${BUILDSYSTEM_BASE}/cmake/Common.cmake)

#set(LIBCLCXX_VENDOR_SRC
#  "${BUILDSYSTEM_BASE}/../03-conformance-checks/vendor-opencl-toolchain/opencl-2.2/khronos/stdlib/include")

get_filename_component(LIBCLCXX_TESTS_DST
  "${CHECKS_BASE}/opencl-2.2/compiletime-device/khronos" REALPATH)

get_filename_component(LIBCLCXX_TESTS_SRC
  "${REF_CL_TOOLCHAIN_BASE}/stdlib/tests/libclcxx" REALPATH)

#set(LIBCLCXX_INCLUDES "${BUILDSYSTEM_BASE}/02-installs/libclcxx/include/openclc++/")
#set(LIBCLCXX_TESTS "${BUILDSYSTEM_BASE}/02-installs/libclcxx/tests/libclcxx/")

#message("Removing opencl-2.2-device-cxx libclcxx installation")
#file(REMOVE ${LIBCLCXX_VENDOR_SRC})

message("Cleaning old libclcxx tests")
file(REMOVE ${LIBCLCXX_TESTS_DST})
		
#message("Installing libclcxx includes into vendor-opencl-toolchain/opencl-2.2/khronos")
#file(INSTALL ${LIBCLCXX_INCLUDES} DESTINATION ${LIBCLCXX_VENDOR_SRC})

message("Installing libclcxx tests into ${CHECKS_BASE}/opencl-2.2/compiletime-device/khronos")
file(INSTALL ${LIBCLCXX_TESTS_SRC}/ DESTINATION ${LIBCLCXX_TESTS_DST})
