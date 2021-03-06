#pragma once

#include <iucore/coredefs.h>
#include <iucore/memorydefs.h>

namespace iuprivate {

/* ***************************************************************************/
// median filter; 32-bit; 1-channel
void cuFilterMedian3x3(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst);

/* ***************************************************************************/
// Gaussian filter; 32-bit; 1-channel
void cuFilterGauss(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                   float sigma, int kernel_size,
                   iu::ImageGpu_32f_C1* temp, cudaStream_t stream);

// Gaussian filter; Volume; 32-bit; 4-channel
void cuFilterGauss(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C4* dst, 
                       float sigma, int kernel_size);

// Gaussian filter; Volume; 32-bit; 1-channel
void cuFilterGauss(const iu::VolumeGpu_32f_C1* src, iu::VolumeGpu_32f_C1* dst,
                       float sigma, int kernel_size);

/* ***************************************************************************/
// Cubic bspline coefficients prefilter.
void cuCubicBSplinePrefilter_32f_C1I(iu::ImageGpu_32f_C1 *input);

/* ***************************************************************************/
// edge filter
void cuFilterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C2* dst);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                      float alpha, float beta, float minval);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C2* dst,
                      float alpha, float beta, float minval);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C4* dst,
                      float alpha, float beta, float minval);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C1* dst,
                      float alpha, float beta, float minval);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C2* dst,
                      float alpha, float beta, float minval);

// edge filter  + evaluation
void cuFilterEdge(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C4* dst,
                      float alpha, float beta, float minval);

/* ***************************************************************************/
// bilateral filter
void cuFilterBilateral(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                       const iu::ImageGpu_32f_C1* prior, const int iters,
                       const float sigma_spatial, const float sigma_range,
                       const int radius);

void cuFilterBilateral(const iu::ImageGpu_32f_C1* src, iu::ImageGpu_32f_C1* dst,
                       const iu::ImageGpu_32f_C4* prior, const int iters,
                       const float sigma_spatial, const float sigma_range,
                       const int radius);

void cuFilterBilateral(const iu::ImageGpu_32f_C4* src, iu::ImageGpu_32f_C4* dst,
                       const iu::ImageGpu_32f_C4* prior, const int iters,
                       const float sigma_spatial, const float sigma_range,
                       const int radius);


} // namespace iuprivate

