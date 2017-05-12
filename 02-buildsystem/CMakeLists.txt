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
cmake_minimum_required(VERSION 3.8.0 FATAL_ERROR)

project(OpenCLBuildSystem)

include(ExternalProject)
include(${CMAKE_CURRENT_LIST_DIR}/cmake/Common.cmake)

set(BUILDSYSTEM_BASE ${PROJECT_SOURCE_DIR})

file(GLOB REPOLISTS LIST_DIRECTORIES false ${BUILDSYSTEM_BASE}/repos/Repo*.cmake)

list(SORT REPOLISTS)

foreach(i ${REPOLISTS})
  include(${i})
  get_filename_component(FILENAME_WE ${i} NAME_WE)
  list(APPEND ALLREPOS ${${FILENAME_WE}})
endforeach(i)

add_custom_target(
  buildall 
  DEPENDS ${ALLREPOS}
)
