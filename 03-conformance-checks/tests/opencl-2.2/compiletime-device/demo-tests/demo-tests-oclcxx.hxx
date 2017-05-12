#ifndef demo-tests_oclcxx_hxx_
#define demo-tests_oclcxx_hxx_

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

#include <opencl_limits>
#include <opencl_type_traits>

//===========================================================================

namespace demo-tests {

//===========================================================================

// Define a type list...
template <typename... TS>
struct tl
{
};

//===========================================================================

#define DEFINE_SFINAE_HAS_MEMBER(CLASS_NAME,MEMBER_NAME) \
template <typename T> \
struct CLASS_NAME \
{ \
  using yes = char[1]; \
  using no = char[2]; \
  \
  template <typename U> \
  static yes& test(typename U::MEMBER_NAME); \
  \
  template <typename> \
  static no& test(...); \
  \
  static constexpr bool value = sizeof(test<T>(nullptr)) == sizeof(yes); \
};

//===========================================================================

#define STATIC_ASSERT_0_ARG_FUNC(FNAME,RETTYPE) \
  static_assert( \
  cl::is_same< \
      decltype(FNAME()), \
      RETTYPE \
    >::value, \
    #FNAME " must return " #RETTYPE \
  );

//===========================================================================

#define STATIC_ASSERT_1_ARG_FUNC(FNAME,RETTYPE,ARG1) \
  static_assert( \
  cl::is_same< \
      decltype(FNAME(cl::declval<ARG1>())), \
      RETTYPE \
    >::value, \
    #FNAME "(" #ARG1 ") must return " #RETTYPE \
  );

//===========================================================================

#define STATIC_ASSERT_2_ARG_FUNC(FNAME,RETTYPE,ARG1,ARG2) \
  static_assert( \
  cl::is_same< \
      decltype(FNAME(cl::declval<ARG1>(),cl::declval<ARG2>())), \
      RETTYPE \
    >::value, \
    #FNAME "(" #ARG1 "," #ARG2 ") must return " #RETTYPE \
  );

//===========================================================================

struct invalid_type final { };

template <typename RetType = invalid_type>
struct sfinae_no_return_type
{
  using boolean_type = cl::false_type;
  using return_type = RetType;
};

template <typename RetType>
struct sfinae_return_type
{
  using boolean_type = cl::true_type;
  using return_type = RetType;
};

#define DEFINE_SFINAE_FUNC(CLASS_NAME,FNAME) \
template <typename ReturnType, typename... Args> \
struct CLASS_NAME \
{ \
 template <typename... TArgs> \
  static constexpr auto sfinae_CE(...) -> \
    demo-tests::sfinae_no_return_type< void > { return {}; } \
  \
  template < \
    typename... TArgs, \
    typename RetType = \
      decltype( FNAME( cl::declval<TArgs>()... ) ) \
  > \
  static constexpr auto sfinae_CE(void*) -> \
    demo-tests::sfinae_return_type< RetType > { return {}; } \
  \
  using func_is_good_type = \
    typename decltype( \
      sfinae_CE<Args...>(nullptr) \
    )::boolean_type \
  ; \
  \
  using func_return_type = \
    typename decltype( \
      sfinae_CE<Args...>(nullptr) \
    )::return_type \
  ; \
  \
  static constexpr bool value = \
    cl::conditional< \
      func_is_good_type::value, \
      typename cl::is_same< func_return_type, ReturnType >::type, \
      cl::false_type \
    >::type::value \
  ; \
};

//===========================================================================

template <
  template <typename...> class TT,
  typename TL
>
struct apply_all_ret_arg1_same;

template <
  template <typename...> class TT
>
struct apply_all_ret_arg1_same<TT, tl<>>
{
  static constexpr bool value = true;
};

template <
  template <typename...> class TT,
  typename T
>
struct apply_all_ret_arg1_same<TT, tl<T>>
{
  static constexpr bool value = TT<T,T>::value;
};

template <
  template <typename...> class TT,
  typename T1, typename T2, typename... TS
>
struct apply_all_ret_arg1_same<TT, tl<T1,T2,TS...>>
{
  static constexpr bool value =
    TT<T1,T1>::value
    && apply_all_ret_arg1_same<TT, tl<T2,TS...>>::value
  ;
};

//===========================================================================

#ifdef cl_khr_fp16
using tl_halfn = tl<half, half2, half3, half4, half8, half16>;
#endif // #ifdef cl_khr_fp16

using tl_floatn = tl<float, float2, float3, float4, float8, float16>;

#ifdef cl_khr_fp64
using tl_doublen = tl<double, double2, double3, double4, double8, double16>;
#endif // #ifdef cl_khr_fp64


//===========================================================================

} // namespace demo-tests

//===========================================================================

#endif // demo-tests_oclcxx_hxx_
