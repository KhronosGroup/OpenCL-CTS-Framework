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

include (${CMAKE_CURRENT_LIST_DIR}/Colours.cmake)

# Global INCLUDE and LIB settings...
#include_directories(${VENDOR_BASE_INCL_DIR})
#link_directories(${VENDOR_BASE_LIB_DIR})

#
# Function: cl_lang_to_string(language)
#
#   Converts lang (either "clc" or "clcxx") to a human readable string ("OpenCL C" or "OpenCL C++" respectively)
#
function(cl_lang_to_string TEST_LANGUAGE OUTPUT_VARIABLE)
  if (${TEST_LANGUAGE} STREQUAL "clcxx")
    SET (CL_LANG "OpenCL C++")
  elseif(${TEST_LANGUAGE} STREQUAL "clc")
    SET (CL_LANG "OpenCL C")
  else(${TEST_LANGUAGE} STREQUAL "clcxx")
    SET (CL_LANG "Unknown")
  endif(${TEST_LANGUAGE} STREQUAL "clcxx")
  set(${OUTPUT_VARIABLE} ${CL_LANG} PARENT_SCOPE)
endfunction(cl_lang_to_string)

function(parse_llvm_lit_run_line RUNLINE OUTPUT_VARIABLE)

  # First get component of run line that is relevant
  string(REPLACE "// RUN: " "" RUNLINE "${RUNLINE}")
  
  if(${RUNLINE} MATCHES "not.*")
    set(${OUTPUT_VARIABLE} "" PARENT_SCOPE)
    return()
  endif()
  # Skip the run line if it mentions FileCheck
  if(${RUNLINE} MATCHES ".*FileCheck.*")
    #message("Unsupported RUN line (skipping): ${RUNLINE}")
    set(${OUTPUT_VARIABLE} "" PARENT_SCOPE)
  else(${RUNLINE} MATCHES ".*FileCheck.*")
    # TODO: Have this do ${CLC} too
    string(REPLACE "%clang_cc1" "${CMAKE_OPENCL_CXX_COMPILER} -cc1" RUNLINE "${RUNLINE}")
    string(REPLACE "%s" "${CMAKE_OPENCL_CXX_INPUT_FLAG} @IN@" RUNLINE "${RUNLINE}")
    # TODO: Must escape quotes or eliminate them (decide which is better)
    string(REPLACE "\"" "" RUNLINE "${RUNLINE}")
    # TODO: Properly remove "-o" (don't rely on compiler being smart)
    #string(REPLACE "-o -" "" RUNLINE "${RUNLINE}")
    #string(REPLACE "-o /dev/null" "" RUNLINE "${RUNLINE}")
    #string(REPLACE "-o" "" RUNLINE "${RUNLINE}")

    # TODO: These tests use -emit-llvm, but should use -emit-spirv
    separate_arguments(RUNLINE)
    list(APPEND RUNLINE
      "${CMAKE_OPENCL_CXX_INCLUDE_FLAG}" "${CMAKE_OPENCL_CXX_STDLIB_INCLUDE}"
      "${CMAKE_OPENCL_CXX_OUTPUT_FLAG}" "@OUT@"
    )
    set(${OUTPUT_VARIABLE} ${RUNLINE} PARENT_SCOPE)
  endif()

endfunction(parse_llvm_lit_run_line)

#
# add_compile_time_conformance_test(in,out,type,hostdev,lang,clver,cli,output)
#
function(add_compile_time_conformance_test READABLE_NAME CLTEST_IN CLTEST_OUT
    TEST_TYPE HOSTDEV TEST_LANGUAGE CLVERSION
    COMPILE_COMMAND_LINE OUTPUT_DEPENDS)

  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${CLTEST_IN}")
    #set(CLTEST_BASENAME "${CLTEST_IN}")
    get_filename_component(CLTEST_BASENAME "${CLTEST_IN}" NAME_WE)
  else()
    message(FATAL_ERROR "File ${CMAKE_CURRENT_SOURCE_DIR}/${CLTEST_IN} does not exist.")
  endif()
  set(CLTEST_SRCFILE "${CMAKE_CURRENT_SOURCE_DIR}/${CLTEST_IN}")

  file(RELATIVE_PATH CLTEST_REL ${PROJECT_SOURCE_DIR} ${CLTEST_SRCFILE}) 
  #cl_lang_to_string(${TEST_LANGUAGE} CL_LANG)

  set(CLTEST_DSTFILE "${CMAKE_CURRENT_BINARY_DIR}/${CLTEST_OUT}")

  # Determine if expected-no-diagnostics is contained in the file
  # TODO: Parse lit comment strings
  set(SHOULD_FAIL 0)
  file(STRINGS ${CLTEST_IN} LINES REGEX "// XFAIL:.*")
  if(NOT "${LINES}" STREQUAL "")
    #message(STATUS "${Yellow}Skipping test ${CLTEST_IN} because it has expected failures.${ColourReset}")
    #return()
    set(SHOULD_FAIL 1)
  else(NOT "${LINES}" STREQUAL "")
  endif()

  # Parse lit RUN lines
  file(STRINGS ${CLTEST_IN} LINES REGEX "// RUN: .*")
  if(NOT "${LINES}" STREQUAL "")
    #list(GET LINES 0 i)  # TODO: One target for each run line
    set(COUNT 0)
    foreach(i ${LINES})

      parse_llvm_lit_run_line(${i} LIT_COMMAND_LINE)
      if (NOT "${LIT_COMMAND_LINE}" STREQUAL "")
        math(EXPR COUNT "${COUNT} + 1")
        add_custom_command(
          OUTPUT ${CLTEST_DSTFILE}.run${COUNT}
          COMMAND ${CMAKE_COMMAND}
          "-DCOMPILE_COMMAND_LINE=\"${LIT_COMMAND_LINE}\""
          -DIN=${CLTEST_SRCFILE}
          "-DOUT=${CLTEST_DSTFILE}.run${COUNT}"
          -DERROR_DIR=${CMAKE_CURRENT_BINARY_DIR}/${CLTEST_IN}.run${COUNT}/
          -DRELATIVE_DIR=${PROJECT_SOURCE_DIR}/run
          -DSHOULD_FAIL=${SHOULD_FAIL}
          -P ${PROJECT_SOURCE_DIR}/cmake/CompileWrapper.cmake
          WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
          MAIN_DEPENDENCY ${CLTEST_SRCFILE}
          COMMENT "${ColourReset}Performing llvm-lit ${BoldYellow}${HOSTDEV} \
${BoldCyan}${TEST_LANGUAGE}${ColourReset} \
(${ColourBold}${CLVERSION}${ColourReset}) \
${BoldBlue}compile-time${ColourReset} tests for \
${BoldMagenta}${READABLE_NAME}${ColourReset} \
(${BoldGreen}${CLTEST_IN}.run${COUNT}${ColourReset})..."    
        )
        list(APPEND ${OUTPUT_DEPENDS} "${CLTEST_DSTFILE}.run${COUNT}")
        set(${OUTPUT_DEPENDS} "${${OUTPUT_DEPENDS}}" PARENT_SCOPE)   
      else(NOT "${LIT_COMMAND_LINE}" STREQUAL "")
        message("Skipping test ${CLTEST_IN} due to FileCheck or 'not' line (unsupported)")
      endif()
    endforeach(i)
  else(NOT "${LINES}" STREQUAL "")
    #Use default compile command line
    add_custom_command(
      OUTPUT ${CLTEST_DSTFILE} 
      COMMAND ${CMAKE_COMMAND}
      "-DCOMPILE_COMMAND_LINE=\"${COMPILE_COMMAND_LINE}\""
      -DIN=${CLTEST_SRCFILE}
      -DOUT=${CLTEST_DSTFILE}
      -DERROR_DIR=${CMAKE_CURRENT_BINARY_DIR}/${CLTEST_IN}/
      -DRELATIVE_DIR=${PROJECT_SOURCE_DIR}/run
      -DSHOULD_FAIL=${SHOULD_FAIL}
      -P ${PROJECT_SOURCE_DIR}/cmake/CompileWrapper.cmake
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
      MAIN_DEPENDENCY ${CLTEST_SRCFILE}
      COMMENT "${ColourReset}Performing ${BoldYellow}${HOSTDEV} \
${BoldCyan}${TEST_LANGUAGE}${ColourReset} \
(${ColourBold}${CLVERSION}${ColourReset}) \
${BoldBlue}compile-time${ColourReset} tests for \
${BoldMagenta}${READABLE_NAME}${ColourReset} \
(${BoldGreen}${CLTEST_IN}${ColourReset})..."    
    )
    list(APPEND ${OUTPUT_DEPENDS} ${CLTEST_DSTFILE})
    set(${OUTPUT_DEPENDS} "${${OUTPUT_DEPENDS}}" PARENT_SCOPE)   
  endif()
endfunction(add_compile_time_conformance_test)

#
# end_compile_time_conformance_tests(type,target,hostdev,lang,clver,deps)
#
function(end_compile_time_conformance_tests TEST_TYPE TARGETNAME HOSTDEV 
    TEST_LANGUAGE CLVERSION DEPENDS)

  #message("Adding target ${TARGETNAME} for ${TEST_LANGUAGE} with depends: ${DEPENDS}")
  add_custom_target(${TARGETNAME}
    DEPENDS ${DEPENDS}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMENT "${ColourReset}${BoldBlue}Compile-time tests for \
${BoldYellow}${HOSTDEV} ${BoldCyan}${TEST_LANGUAGE} \
${ColourReset}(${ColourBold}${CLVERSION}${ColourReset})${BoldBlue} complete!${ColourReset}"

  )

  add_custom_command(
    TARGET ${TARGETNAME}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -DSEARCHDIR=${CMAKE_CURRENT_BINARY_DIR} -P ${PROJECT_SOURCE_DIR}/cmake/Summary.cmake
    WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  )

endfunction(end_compile_time_conformance_tests)

#
# add_run_time_test(name,in,out,type,hostdev,lang,clver,cli,deps)
#
function(add_run_time_conformance_test READABLE_NAME CLTEST_IN CLTEST_OUT
    TEST_TYPE HOSTDEV TEST_LANGUAGE CLVERSION OUTPUT_DEPENDS)

  #Add dependencies needed?
  add_executable(${CLTEST_OUT} EXCLUDE_FROM_ALL ${CLTEST_IN})
  # TODO: Do this properly
  target_link_libraries(${CLTEST_OUT} "OpenCL")
  add_test(NAME ${CLTEST_OUT} COMMAND ${CMAKE_CURRENT_BINARY_DIR}/${CLTEST_OUT})

  add_dependencies(${OUTPUT_DEPENDS} ${CLTEST_OUT})
  #list(APPEND ${OUTPUT_DEPENDS} ${CMAKE_CURRENT_BINARY_DIR}/${CLTEST_OUT})
  #set(${OUTPUT_DEPENDS} "${${OUTPUT_DEPENDS}}" PARENT_SCOPE)

endfunction(add_run_time_conformance_test)

