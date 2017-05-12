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

#set(ICD_VENDOR_SRC "${BUILDSYSTEM_BASE}/../03-conformance-checks/vendor-host/")

#get_filename_component(ICD_SRC ${INSTALL_BASE}/icd REALPATH)
get_filename_component(ICD_SRC ${DLOADS_BASE}/icd_loader/src/OPENCL_ICD-build/bin REALPATH)
#set(ICD_SRC "${BUILDSYSTEM_BASE}/02-installs/icd/")

#message("Removing Khronos ICD installation")
#file(REMOVE ${ICD_VENDOR_SRC})

set(KHR_VENDOR_DIRS 1.0 1.1 1.2 2.0 2.1 2.2)

foreach(i ${KHR_VENDOR_DIRS})
  #get_filename_component(ICD_DST ${SDKS_BASE}/opencl-${i}/native/khronos/lib REALPATH)
  get_filename_component(ICD_DST ${SDKS_BASE}/opencl-${i}/native/icd_loader REALPATH)
  message("Installing Khronos Native OpenCL ${i} ICD Loader into ${ICD_DST}")
  file(COPY ${ICD_SRC}/ DESTINATION ${ICD_DST})
  file(MAKE_DIRECTORY ${ICD_DST}/../vendor_headers)
endforeach()

