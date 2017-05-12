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

include(${CMAKE_CURRENT_LIST_DIR}/Colours.cmake)

# Find unexpected result directories
file(GLOB_RECURSE RESULTS_UNEXPECTED "${SEARCHDIR}/*/stderr.log")

if ("${RESULTS_UNEXPECTED}" STREQUAL "")
  message(STATUS "${BoldGreen}All tests passed!${ColourReset}")
else("${RESULTS_UNEXPECTED}" STREQUAL "")
  message("${BoldRed}The following tests failed:${ColourReset}")
  
  set(UNEXPECTED_FAILURES "")
  set(UNEXPECTED_PASSES "")

  # Divide up the unexpected passes from the unexpected failures

  foreach(i ${RESULTS_UNEXPECTED})
    get_filename_component(TESTDIR ${i} DIRECTORY)
    #get_filename_component(TESTDIR2 ${TESTDIR} NAME)
    file(RELATIVE_PATH RELPATH ${SEARCHDIR} ${TESTDIR})
    #message("\t${Magenta}${RELPATH}${ColourReset}")

    # Count up unexpected passes and failures
    if(EXISTS ${TESTDIR}/shouldfail)
      #math(EXPR UNEXPECTED_PASSES "${UNEXPECTED_PASSES} + 1")
      list(APPEND UNEXPECTED_PASSES ${RELPATH})
    else(EXISTS ${TESTDIR}/shouldfail)
      #math(EXPR UNEXPECTED_FAILURES "${UNEXPECTED_FAILURES} + 1")
      list(APPEND UNEXPECTED_FAILURES ${RELPATH})
    endif()
  endforeach(i)

  list(LENGTH UNEXPECTED_PASSES UNEXPECTED_PASSES_COUNT)
  list(LENGTH UNEXPECTED_FAILURES UNEXPECTED_FAILURES_COUNT)

  # Output unexpected passes
  message("${ColourBold}Unexpected passes (${UNEXPECTED_PASSES_COUNT}):${ColourReset}")
  foreach(i ${UNEXPECTED_PASSES})
    message("    ${Magenta}${i}${ColourReset}")
  endforeach(i)

  # Output unexpected failures
  message("${ColourBold}Unexpected failures (${UNEXPECTED_FAILURES_COUNT}):${ColourReset}")
  foreach(i ${UNEXPECTED_FAILURES})
    message("    ${Magenta}${i}${ColourReset}")
  endforeach(i)

  message("${BoldRed}One or more tests failed :(${ColourReset}")
endif()

# Find expected results
#file(GLOB_RECURSE RESULTS_EXPECTED "${SEARCHDIR}/*.spv")

#message("\nTotal number of tests: ${TOTAL_TESTS}")
#message("Expected passes: ${EXPECTED_PASSES}")
message("\nUnexpected passes: ${UNEXPECTED_PASSES_COUNT}")
#message("Expected failures: ${EXPECTED_FAILURES}")
message("Unexpected failures: ${UNEXPECTED_FAILURES_COUNT}")
