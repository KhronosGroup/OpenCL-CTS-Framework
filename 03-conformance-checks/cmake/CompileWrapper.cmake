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

#
# This is a wrapper for compiling code, such that add_custom_command
# does not stop the build if the compile fails.  This script will save error
# output to a file under the tmp directory in the event of a failure.
#
# Expected arguments:
#   COMPILE_COMMAND_LINE -- the compile command used to build the output.
#     It is expected that this command line will have two substitutions in it,
#     @IN@ and @OUT@, to denote compiler input and output respectively.
#     This is expected to be a list, with the first element of the list being
#     the command name, and the subsequent elements being the arguments.
#   
#   IN -- The input file to be substituted into the above command
#   OUT -- The output file to be substituted into the above command (/dev/null
#     if not provided)
#   ERROR_DIR -- Where to store error output
#   RELATIVE_DIR -- For logging purposes, where to say build output is saved
#   SHOULD_FAIL -- 1 or 0, depending if the test should fail or not
#
# Example usage:
#
#   cmake
#     -DCOMPILE_COMMAND_LINE="clang;-cc1;@IN@;-o;@OUT@"
#     -DIN=test.cl
#     -DOUT=test.spirv
#     -DERROR_DIR=/tons/of/stuff/build/src
#     -DRELATIVE_DIR=/tons/of/stuff
#     -P CompileWrapper.cmake 
#

include(${CMAKE_CURRENT_LIST_DIR}/Colours.cmake)

if (NOT DEFINED OUT)
  set (OUTPUT "/dev/null")
endif()

string(CONFIGURE "${COMPILE_COMMAND_LINE}" ProcessedCommandLine)

execute_process(
  COMMAND ${ProcessedCommandLine}
  RESULT_VARIABLE CompileStatus
  OUTPUT_VARIABLE CompileStdout
  ERROR_VARIABLE  CompileStderr
)

#if((EXISTS ${OUT} AND ${SHOULD_FAIL} EQUAL 1) OR
#  ((NOT EXISTS ${OUT}) AND ${SHOULD_FAIL} EQUAL 0))
#if(NOT ${CompileStatus} EQUAL 0)
if(NOT ${CompileStatus} EQUAL ${SHOULD_FAIL})
# Failure
  file(MAKE_DIRECTORY ${ERROR_DIR})
  file(WRITE ${ERROR_DIR}/stdout.log "${CompileStdout}")
  file(WRITE ${ERROR_DIR}/stderr.log "${CompileStderr}")
  file(WRITE ${ERROR_DIR}/compile.txt "${ProcessedCommandLine}")
  if(${SHOULD_FAIL})
    file(WRITE "${ERROR_DIR}/shouldfail" "Output saved in: ${OUT}")
  endif()
  file(RELATIVE_PATH RELPATH ${RELATIVE_DIR} ${ERROR_DIR})
  message("${BoldRed}FAILED${ColourReset} -- ${Yellow}Build output saved in: ${BoldCyan}${RELPATH}/stderr.log${ColourReset}")
endif()

#if(${CompileStatus} EQUAL ${SHOULD_FAIL})
  #message(STATUS "PASSED")
#else(${CompileStatus} EQUAL ${SHOULD_FAIL})
  #message("Command line: ${ProcessedCommandLine}")
#endif()
