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

//===========================================================================

/*
 * For Appendix C.1, our compile time check will ensure that the scalar 
 * types cl_* defined in Appendix C.1 exist. Since no guarantees about 
 * these types are made in the specification, no further properties of 
 * these types are checked.

 * TODO: Clarify: does the opencl-environment.pdf specification make
 * more guarantees about these types?  It seems to pertain more to device
 * rather than host code.

*/

int main()
{
  //Check that the scalars in Appendix C.1 are defined:
  cl_char t1;
  cl_uchar t2;
  cl_short t3;
  cl_ushort t4;
  cl_int t5;
  cl_uint t6;
  cl_long t7;
  cl_ulong t8;
  cl_half t9;
  cl_float t10;
  cl_double t11;
  return 0;
}

//===========================================================================
