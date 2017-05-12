//===========================================================================
// Copyright (c) 2017 The Khronos Group Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//===========================================================================

#include <opencl_math>
#include "demo-tests-oclcxx.hxx"

using demo-tests::apply_all_ret_arg1_same;

#define EASY_DEF(CLASS_NAME,MATH_FUNC,TYPEN) \
  DEFINE_SFINAE_FUNC(CLASS_NAME ## _ ## MATH_FUNC,cl::MATH_FUNC) \
  static_assert( \
    apply_all_ret_arg1_same< \
      CLASS_NAME ## _ ## MATH_FUNC, demo-tests::tl_ ## TYPEN \
    >::value, \
    #TYPEN " " #MATH_FUNC "(" #TYPEN ") failed." \
  );

#ifdef cl_khr_fp16
  EASY_DEF(sect_3_10_4_1, acos, halfn)
#endif // #ifdef cl_khr_fp16

EASY_DEF(sect_3_10_4_1, acos, floatn)

#ifdef cl_khr_fp64
  EASY_DEF(sect_3_10_4_1, acos, doublen)
#endif // #ifdef cl_khr_fp64

kernel void test0()
{
}

