#ifndef sect_3_5_2_1_hxx_
#define sect_3_5_2_1_hxx_

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

#include <opencl_def>
#include <opencl_memory>
#include <opencl_type_traits>

//===========================================================================

template <typename T>
constexpr bool constexpr_check_global_class_CE()
{
  if (cl::is_fundamental<T>::value || cl::is_array<T>::value)
  {
    return
      // No user-provided default constructor...
      cl::is_trivially_default_constructible<T>::value
      // Has copy and move constructors...
      && cl::is_copy_constructible<T>::value 
      && cl::is_move_constructible<T>::value
      // Has copy and move assignment operators...
      && cl::is_copy_assignable<T>::value
      && cl::is_move_assignable<T>::value
      // Address-of operators that return a generic T pointer (T*)...
      && cl::is_pointer<decltype(&cl::declval<T>())>::value
      // Conversion operators to a generic T lvalue reference type (T&)...
      && cl::is_lvalue_reference<
        decltype(static_cast<T const&>(cl::declval<T>()))
      >::value

      // Assignment const T& operator...
          // NOTE: Same as copy assignable.

      //  ptr() methods that return a global_ptr<T> pointer class
          // NOTE: What does this mean? What is "ptr() methods"?
    ;
  }
  else if (cl::is_class<T>::value)
  {
    return
      // the same public interface as T type including constructors and assignment
      // operator saddress-of operators that return a generic T pointer (T*)
        // NOTE: This cannot be checked generically.

      //  conversion operators to a generic T lvalue reference type (T&)
      cl::is_lvalue_reference<
        decltype(static_cast<T const&>(cl::declval<T>()))
      >::value

      // ptr() methods that return a global_ptr<T> pointer class
        // NOTE: What does this mean? What is "ptr() methods"?
    ;
  }
  else
    return true; 
}

//===========================================================================

#endif // #ifndef sect_3_5_2_1_hxx_
