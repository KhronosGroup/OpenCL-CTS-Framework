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
# NOTE: Requires the Mali SDK installed in vendor-host/opencl-1.1/android/mali
#
set(HOST android)
set(HOST_TOOLCHAIN_FILE android.toolchain)
set(ANDROID_NDK /opt/android-ndk)
set(ANDROID_ABI "arm64-v8a")
set(ANDROID_NATIVE_API_LEVEL "android-21")
set(ANDROID_TOOLCHAIN_NAME "aarch64-linux-android-4.9")
set(OPENCL_VERSION 1.1)
set(TEST_TYPE runtime)
set(VENDOR mali)
