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

extern "C" 
{
#ifdef __APPLE__
 #include <OpenCL/cl.h>
#else
 #include <CL/cl_platform.h>
#endif // #ifdef __APPLE__
}

#include <cstddef>
#include <limits>
#include <type_traits>
#include <utility>
#include <iostream>

//===========================================================================

//
// For Appendix C.5, check that the vector has an array member "s" with at 
// least the minimum required number of elements that can safely hold the 
// values needed (e.g, a cl_int4 should not be represented with three 
// cl_chars (unless a cl_char and cl_int are interchangeable))
//

// C.5 Vector Components

//===========================================================================

template <typename T>
constexpr std::size_t get_vector_extent_CE()
{
  return std::extent<T>::value;
}

//===========================================================================

//
// Can we safely contain a variable of type Scalar in a variable of type 
// ElementType?
//
// If the Vec::s array element type can hold any value that the Scalar type 
// can hold, then this test passes.  Otherwise, the Vec::s array element type 
// is smaller than the scalar type it is supposed to represent. For instance, 
// a cl_int4 could be represented with an array of type long, but not always 
// an array of type char (platform dependent).
//
// An alternative test would be to check that the types are exactly the same.
//
template <typename ScalarType, typename VecType>
constexpr bool vector_array_type_matches_CE() 
{
  using ElementType = typename std::remove_extent<decltype(VecType::s)>::type;
  return 
    std::numeric_limits<ElementType>::lowest() <= std::numeric_limits<ScalarType>::lowest()
    && std::numeric_limits<ScalarType>::max() >= std::numeric_limits<ElementType>::max()
  ;
}

int main()
{
  //
  // Check that vector literals work as per the standard...
  //
  
#define MAKE_TYPE(TYPE,EXTENT)  TYPE ## EXTENT

#define CHECK_EXTENT(TYPE,EXTENT) \
  static_assert( \
    get_vector_extent_CE<decltype(std::declval<MAKE_TYPE(TYPE, EXTENT)>().s)>() >= EXTENT, \
    "FAIL: " #TYPE #EXTENT ".s should hold at least " \
      #EXTENT " elements, but holds fewer" \
  ); \
  static_assert( \
    vector_array_type_matches_CE<TYPE, MAKE_TYPE(TYPE, EXTENT)>(), \
    "FAIL: " #TYPE #EXTENT ".s does not have elements of type " #TYPE \
  );

#define CHECK_EXTENTS(TYPE) \
  CHECK_EXTENT(TYPE,2) \
  CHECK_EXTENT(TYPE,3) \
  CHECK_EXTENT(TYPE,4) \
  CHECK_EXTENT(TYPE,8) \
  CHECK_EXTENT(TYPE,16)

  CHECK_EXTENTS(cl_char)
  CHECK_EXTENTS(cl_uchar)
  CHECK_EXTENTS(cl_short)
  CHECK_EXTENTS(cl_ushort)
  CHECK_EXTENTS(cl_int)
  CHECK_EXTENTS(cl_uint)
  CHECK_EXTENTS(cl_long)
  CHECK_EXTENTS(cl_ulong)

  //CHECK_EXTENTS(cl_half) 
  CHECK_EXTENTS(cl_float)
  CHECK_EXTENTS(cl_double)
  
  return 0;
}

//===========================================================================
