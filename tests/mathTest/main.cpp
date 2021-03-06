#include <iostream>
#include "../config.h"
#include "../../src/iucore.h"
#include "../../src/iuio.h"
#include "../../src/iumath.h"
int main()
{
    std::cout << "Read image to device directly" << std::endl;
    std::cout << DATA_PATH("army_1.png") << std::endl;
    //	iu::ImageCpu_32f_C1 I1(320,240);
    //	iu::ImageGpu_32f_C1 I2(320,240);
    //	iu::copy(&I1,&I2);
    iu::ImageGpu_32f_C1 *I1 = iu::imread_cu32f_C1(DATA_PATH("army_1.png"));
    iu::ImageGpu_32f_C1 *I2 = iu::imread_cu32f_C1(DATA_PATH("army_2.png"));
    iu::ImageGpu_32f_C1 result(I1->size());

    iu::math::addC(*I1,0.5,result);
    iu::imsave(&result,RESULTS_PATH("army_1_bright.png"));
    iu::math::addWeighted(*I1,1,*I2,-1,result);
    iu::imsave(&result,RESULTS_PATH("army_1_minus_2.png"));
    std::cout << "DONE :)" << std::endl;
}
