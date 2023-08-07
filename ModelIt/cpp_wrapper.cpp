//
//  camerainit.cpp
//  SoftVision
//
//  Created by HouPeihong on 2023/7/13.
//

#define TEST_XX
#include "call_c_bridge.h"

#ifndef TEST_XX
#include <ReconPipeline.h>
#endif

#include <cstdio>

//#include "test.hpp"
//#include "test.h"

void Pipeline_CameraInit()
{
//    test::foo(); //okay
//    foo2(); //error
#ifndef TEST_XX
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->CameraInit();
#endif
}

void Pipeline_AppendSfMData(uint32_t viewId,
                   uint32_t poseId,
                   uint32_t intrinsicId,
                   uint32_t frameId,
                   uint32_t width,
                   uint32_t height,
                   const unsigned char* bufferData)
{
#ifndef TEST_XX
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->AppendSfMData(viewId, poseId, intrinsicId, frameId, width, height, bufferData);
#endif
}

void Pipeline_FeatureExtraction()
{
    printf("Pipeline_FeatureExtraction\n");
#ifndef TEST_XX
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->FeatureExtraction();
#endif
    //
}


