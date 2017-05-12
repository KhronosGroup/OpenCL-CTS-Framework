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
 #include <CL/cl.h>
#endif // #ifdef __APPLE__

//===========================================================================

#include <stddef.h>
#include <stdbool.h>

//===========================================================================

int main()
{
  _Bool success = true;
  {
    //  Check: If num_entries is equal to zero AND platforms is not NULL.
    // Result: CL_INVALID_VALUE
    cl_uint num_platforms = 0;
    cl_platform_id platform_id;
    cl_int result = clGetPlatformIDs(0, &platform_id, &num_platforms);
    success &= result == CL_INVALID_VALUE;
  }
  return !success;
}

//===========================================================================
