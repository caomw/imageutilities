/*
 * Copyright (c) ICG. All rights reserved.
 *
 * Institute for Computer Graphics and Vision
 * Graz University of Technology / Austria
 *
 *
 * This software is distributed WITHOUT ANY WARRANTY; without even
 * the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE.  See the above copyright notices for more information.
 *
 *
 * Project     : ImageUtilities
 * Module      : Core
 * Class       : none
 * Language    : C/CUDA
 * Description : CUDA kernels for core functions
 *
 * Author     : Manuel Werlberger
 * EMail      : werlberger@icg.tugraz.at
 *
 */

#ifndef IUCORE_CONVERT_CU
#define IUCORE_CONVERT_CU

#include <cutil_math.h>
#include "coredefs.h"
#include "memorydefs.h"
#include "iutextures.cuh"

namespace iuprivate {


/* ***************************************************************************
 *  CUDA KERNELS
 * ***************************************************************************/

//-----------------------------------------------------------------------------
/** convert kernel 32f_C3 -> 32f_C4 (float3 -> float4)
 */
__global__ void cuConvertC3ToC4Kernel(const float3* src, size_t src_stride, int src_width, int src_height,
                                      float4* dst, size_t dst_stride, int dst_width, int dst_height)
{
  const int x = blockIdx.x*blockDim.x + threadIdx.x;
  const int y = blockIdx.y*blockDim.y + threadIdx.y;
  int src_c = y*src_stride + x*3;
  int dst_c = y*dst_stride + x*4;

  if (x<src_width && y<src_height && x<dst_width && y<dst_height)
  {
    dst[dst_c] =  make_float4(src[src_c],1.0f);
  }
}

//-----------------------------------------------------------------------------
/** convert kernel 32f_C4 -> 32f_C3 (float4 -> float3)
 */
__global__ void cuConvertC4ToC3Kernel(const float4* src, size_t src_stride, int src_width, int src_height,
                                      float3* dst, size_t dst_stride, int dst_width, int dst_height)
{
  const int x = blockIdx.x*blockDim.x + threadIdx.x;
  const int y = blockIdx.y*blockDim.y + threadIdx.y;
  int src_c = y*src_stride + x*4;
  int dst_c = y*dst_stride + x*3;

  if (x<src_width && y<src_height && x<dst_width && y<dst_height)
  {
    dst[dst_c] = make_float3(src[src_c]);
  }
}


/* ***************************************************************************
 *  CUDA WRAPPERS
 * ***************************************************************************/

//-----------------------------------------------------------------------------
/** convert kernel 32f_C3 -> 32f_C4 (float3 -> float4)
 */
IuStatus cuConvert(const iu::ImageGpu_32f_C3* src, const IuRect& src_roi,
                   iu::ImageGpu_32f_C4* dst, const IuRect& dst_roi)
{
  // fragmentation
  const unsigned int block_size = 16;
  dim3 dimBlock(block_size, block_size);
  dim3 dimGrid(iu::divUp(dst_roi.width - dst_roi.x, dimBlock.x),
               iu::divUp(dst_roi.height - dst_roi.y, dimBlock.y));

  cuConvertC3ToC4Kernel <<< dimGrid, dimBlock >>> (
      src->data(src_roi.x, src_roi.y), src->stride(), src_roi.width, src_roi.height,
      dst->data(dst_roi.x, dst_roi.y), dst->stride(), dst_roi.width, dst_roi.height);

  IU_CHECK_AND_RETURN_CUDA_ERRORS();
  return IU_SUCCESS;
}

//-----------------------------------------------------------------------------
/** convert kernel 32f_C4 -> 32f_C3 (float4 -> float3)
 */
IuStatus cuConvert(const iu::ImageGpu_32f_C4* src, const IuRect& src_roi,
                   iu::ImageGpu_32f_C3* dst, const IuRect& dst_roi)
{
  // fragmentation
  const unsigned int block_size = 16;
  dim3 dimBlock(block_size, block_size);
  dim3 dimGrid(iu::divUp(dst_roi.width - dst_roi.x, dimBlock.x),
               iu::divUp(dst_roi.height - dst_roi.y, dimBlock.y));

  cuConvertC4ToC3Kernel <<< dimGrid, dimBlock >>> (
      src->data(src_roi.x, src_roi.y), src->stride(), src_roi.width, src_roi.height,
      dst->data(dst_roi.x, dst_roi.y), dst->stride(), dst_roi.width, dst_roi.height);

  IU_CHECK_AND_RETURN_CUDA_ERRORS();
  return IU_SUCCESS;
}



} // namespace iuprivate

#endif // IUCORE_CONVERT_CU
