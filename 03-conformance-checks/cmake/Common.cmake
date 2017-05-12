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

# Configuration details

get_filename_component(CTS_BASE ${CMAKE_CURRENT_LIST_DIR}/.. REALPATH)
get_filename_component(REPO_BASE ${CMAKE_CURRENT_LIST_DIR}/../.. REALPATH)

# First see if 02-buildsystem is adjacent to 03-conformance-checks
# If so, pull paths directly from it

if(EXISTS ${REPO_BASE}/02-buildsystem)
  #message("02-buildsystem detected in ajacent directory to 03-conformance-checks -- using its configuration")
  get_filename_component(BUILDSYSTEM_BASE ${REPO_BASE}/02-buildsystem REALPATH)
else(EXISTS ${REPO_BASE}/02-buildsystem)
  # TODO: Enable full separation of buildsystem and CTS
  message(FATAL_ERROR "02-buildsystem not found")
endif()

# Get Buildsystem configuration for paths
include(${BUILDSYSTEM_BASE}/cmake/Common.cmake)

# Define a test result directory -- can be overridden
get_filename_component(RESULTS_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-results REALPATH)

# Define a build directory for tests
get_filename_component(TESTBUILD_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-testbuilds REALPATH)

get_filename_component(KHRBUILD_BASE ${REPO_UPPERDIR}/${REPO_BASENAME}-khrbuilds REALPATH)

