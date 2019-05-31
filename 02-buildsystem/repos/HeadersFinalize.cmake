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

set(KHR_OCL_VERSIONS 1.0 1.1 1.2 2.0 2.1 2.2)

foreach(V ${KHR_OCL_VERSIONS})
  string(REPLACE "." "" VNODOT ${V})
  get_filename_component(KHRONOS_SDK_SRC
    ${DLOADS_BASE}/opencl_headers/src/OPENCL_HEADERS/CL REALPATH)

  get_filename_component(KHRONOS_SDK_DST
    ${CL_REFHEADERS_BASE}/opencl-${V} REALPATH)

  message("Cleaning old Khronos reference OpenCL ${V} headers")
  file(REMOVE ${KHRONOS_SDK_DST})

  message("Installing Khronos Reference OpenCL ${V} Headers")
  file(INSTALL ${KHRONOS_SDK_SRC}/ DESTINATION ${KHRONOS_SDK_DST})

endforeach(V)
