#pragma once

#include <iucore/coredefs.h>
#include <iucore/memorydefs.h>

namespace iuprivate {

/* ***************************************************************************
 *  Declaration of CUDA WRAPPERS
 * ***************************************************************************/

// Median filter; device; 32-bit; 1-channel;
void filterMedian3x3(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst);

/* ***************************************************************************/
// Gaussian convolution

// 32-bit; 1-channel
void filterGauss(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                 float sigma, int kernel_size,
                 iu::ImageGpu_32f_C1* temp=NULL, cudaStream_t stream=0);

// Volume; 32-bit; 1-channel
void filterGauss(const iu::VolumeGpu_32f_C1* src, iu::VolumeGpu_32f_C1* dst,
                 float sigma, int kernel_size);

// 32-bit; 4-channel
void filterGauss(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C4* dst,
                 float sigma, int kernel_size);


/* ***************************************************************************/
// Edge Filters
void filterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C2* dst);
void filterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                float alpha, float beta, float minval);
void filterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C2* dst,
                float alpha, float beta, float minval);
void filterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C4* dst,
                float alpha, float beta, float minval);
void filterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C1* dst,
                float alpha, float beta, float minval);
void filterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C2* dst,
                float alpha, float beta, float minval);
void filterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C4* dst,
                float alpha, float beta, float minval);

/* ***************************************************************************/
// Cubic B-Spline coefficients prefilter
void cubicBSplinePrefilter(iu::ImageGpu_32f_C1* srcdst);


} // namespace iuprivate

