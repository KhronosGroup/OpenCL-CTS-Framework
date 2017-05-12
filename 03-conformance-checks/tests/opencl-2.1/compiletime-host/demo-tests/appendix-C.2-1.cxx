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

#ifdef __APPLE__
 #include <OpenCL/cl.h>
#else
 #include <CL/cl_platform.h>
#endif // #ifdef __APPLE__

#include <type_traits>

//===========================================================================

/*
 * For Appendix C.2, our compile time check will ensure that the vector 
 * types cl_*n defined in Appendix C.2 exist.  Furthermore,
 * we will check that they are union types as defined in the standard.
*/

//NOTE: Due to a bug, cl_halfn does not exist in khronos cl_platform.h!
#define VECTOR_DEFINE(n) \
    cl_char##n v##n##1; \
    cl_uchar##n v##n##2; \
    cl_short##n v##n##3; \
    cl_ushort##n v##n##4; \
    cl_int##n v##n##5; \
    cl_uint##n v##n##6; \
    cl_long##n v##n##7; \
    cl_ulong##n v##n##8; \
    /*cl_half##n v##n##9;*/ \
    cl_float##n v##n##10; \
    cl_double##n v##n##11; \

//NOTE: Due to a bug, cl_halfn does not exist!  Disabled for now.
#define VECTOR_ASSERT_UNION(n) \
    static_assert(std::is_union<cl_char##n>::value, "FAIL: the type cl_char##n is required to be a union!"); \
    static_assert(std::is_union<cl_uchar##n>::value, "FAIL: the type cl_uchar##n is required to be a union!"); \
    static_assert(std::is_union<cl_short##n>::value, "FAIL: the type cl_short##n is required to be a union!"); \
    static_assert(std::is_union<cl_ushort##n>::value, "FAIL: the type cl_ushort##n is required to be a union!"); \
    static_assert(std::is_union<cl_int##n>::value, "FAIL: the type cl_int##n is required to be a union!"); \
    static_assert(std::is_union<cl_uint##n>::value, "FAIL: the type cl_uint##n is required to be a union!"); \
    static_assert(std::is_union<cl_long##n>::value, "FAIL: the type cl_long##n is required to be a union!"); \
    static_assert(std::is_union<cl_ulong##n>::value, "FAIL: the type cl_ulong##n is required to be a union!"); \
    /*static_assert(std::is_union<cl_half##n>::value, "FAIL: the type cl_half##n is required to be a union!");*/ \
    static_assert(std::is_union<cl_float##n>::value, "FAIL: the type cl_float##n is required to be a union!"); \
    static_assert(std::is_union<cl_double##n>::value, "FAIL: the type cl_double##n is required to be a union!");

int main()
{
    //Check that the union vector types in Appendix C.2 are defined:
  
    /*
    cl_charn vn1;
    cl_ucharn vn2;
    cl_shortn vn3;
    cl_ushortn vn4;
    cl_intn vn5;
    cl_uintn vn6;
    cl_longn vn7;
    cl_ulongn vn8;
    cl_halfn vn9;
    cl_floatn vn10;
    cl_doublen vn11;
    */

    //Check that these types exist
    VECTOR_DEFINE(2)
    VECTOR_DEFINE(3)
    VECTOR_DEFINE(4)
    VECTOR_DEFINE(8)
    VECTOR_DEFINE(16)

    //Check that they are union types (required in spec)
    VECTOR_ASSERT_UNION(2)
    VECTOR_ASSERT_UNION(3)
    VECTOR_ASSERT_UNION(4)
    VECTOR_ASSERT_UNION(8)
    VECTOR_ASSERT_UNION(16)

    return 0;
}

//===========================================================================
