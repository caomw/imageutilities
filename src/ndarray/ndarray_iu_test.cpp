#include "ndarray_iu.h"

void foo(const iu::LinearDeviceMemory<float> & L){
	L.length();
};

int main(){

		{
			iu::LinearDeviceMemory<float> L1;
			iu::LinearHostMemory<float> L2;

			ndarray_ref<float, 1> x1 = L1;
			ndarray_ref<float, 1> x2 = L2;

			const iu::LinearDeviceMemory<float> & L11 = x1;
		};
		{
			iu::ImageCpu_32f_C1 I1;
			iu::ImageGpu_32f_C3 I2;

			ndarray_ref<float, 2> x1 = I1;
			ndarray_ref<float3, 2> x2 = I2;

			//const iu::ImageGpu_32f_C1 & _I2 = x2.recast<float>();
		};

	return 0;
};