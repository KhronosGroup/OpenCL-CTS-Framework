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
cmake_minimum_required(VERSION 3.8.0)

get_filename_component(BUILDSYSTEM_BASE ${CMAKE_SOURCE_DIR}/../.. REALPATH)

include(ExternalProject)
include(${BUILDSYSTEM_BASE}/cmake/Common.cmake)

file(MAKE_DIRECTORY ${INSTALL_BASE}/ninja/bin)

if(DEFINED WIN32)
  set(SUFFIX ".exe")
endif()

ExternalProject_Add(
  NINJA
  PREFIX "${DLOADS_BASE}/ninja"
  GIT_REPOSITORY "https://github.com/ninja-build/ninja.git"
  GIT_TAG "release"
  GIT_SHALLOW 1
  INSTALL_DIR "${INSTALL_BASE}/ninja/"
  CONFIGURE_COMMAND ""
  BUILD_COMMAND python <SOURCE_DIR>/configure.py --bootstrap
  INSTALL_COMMAND cmake -E copy <BINARY_DIR>/ninja${SUFFIX}
    ${INSTALL_BASE}/ninja/bin/
)

