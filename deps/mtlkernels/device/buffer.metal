//#pragma once

#include <depthMap/gpu/device/DeviceCameraParams.hpp>
//#include "DeviceCameraParams.hpp"
//#include "../planeSweeping/similarity.hpp"
#include <depthMap/gpu/planeSweeping/similarity.hpp>
#include <mvsData/ROI_d.hpp>

//#include "
//#include <depthMap/gpu/device/BufPtr.metal>
//#include <depthMap/BufPtr.hpp>

#include <metal_stdlib>

using namespace metal;

//#include "depthMap/gpu/device/DeviceCameraParams.hpp"

namespace depthMap {



/**
* @brief
* @param[int] ptr
* @param[int] spitch raw length of a 2D array in bytes
* @param[int] pitch raw length of a line in bytes
* @param[int] x
* @param[int] y
* @return
*/
template <typename T>
device T* get3DBufferAt(device T* ptr, constant int& spitch, constant int& pitch, unsigned x, unsigned y, unsigned z)
{
    return ((device T*)(((device unsigned char*)ptr) + z * spitch + y * pitch)) + x;
}
template device TSim* get3DBufferAt(device TSim* ptr, constant int& spitch, constant int& pitch, unsigned x, unsigned y, unsigned z);
template device TSimRefine* get3DBufferAt(device TSimRefine* ptr, constant int& spitch, constant int& pitch, unsigned x, unsigned y, unsigned z);

//template <typename T>
//const device T* get3DBufferAt(const device T* ptr, int spitch, int pitch, int x, int y, int z)
//{
//    return ((const device T*)(((const device unsigned char*)ptr) + z * spitch + y * pitch)) + x;
//}
//template const device TSim* get3DBufferAt(device const TSim* ptr, int spitch, int pitch, unsigned x, unsigned y, unsigned z);

template <typename T>
device T* get3DBufferAt(device T* ptr, constant int& spitch, constant int& pitch, thread int3& v)
{
    return get3DBufferAt(ptr, spitch, pitch, v.x, v.y, v.z);
}
template device TSim* get3DBufferAt(device TSim* ptr, constant int& spitch, constant int& pitch, thread int3& v);
    
//template <typename T>
//inline const device T* get3DBufferAt(const device T* ptr, int spitch, int pitch, thread int3& v)
//{
//    return get3DBufferAt(ptr, spitch, pitch, v.x, v.y, v.z);
//}
//inline const device TSim* get3DBufferAt(const device TSim* ptr, int spitch, int pitch, thread int3& v);

inline float multi_fminf(float a, float b, float c)
{
  return min(min(a, b), c);
}

inline float multi_fminf(float a, float b, float c, float d)
{
  return min(min(min(a, b), c), d);
}


//#ifdef ALICEVISION_DEPTHMAP_TEXTURE_USE_UCHAR
//
//inline float4 tex2D_float4(cudaTextureObject_t rc_tex, float x, float y)
//{
//#ifdef ALICEVISION_DEPTHMAP_TEXTURE_USE_INTERPOLATION
//    // cudaReadNormalizedFloat
//    float4 a = tex2D<float4>(rc_tex, x, y);
//    return make_float4(a.x * 255.0f, a.y * 255.0f, a.z * 255.0f, a.w * 255.0f);
//#else
//    // cudaReadElementType
//    uchar4 a = tex2D<uchar4>(rc_tex, x, y);
//    return make_float4(a.x, a.y, a.z, a.w);
//#endif
//}
//
//#else
//
//inline float4 tex2D_float4(cudaTextureObject_t rc_tex, float x, float y)
//{
//    return tex2D<float4>(rc_tex, x, y);
//}
//
//#endif

} // namespace depthMap

