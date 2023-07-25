//
//  camerainit.cpp
//  SoftVision
//
//  Created by HouPeihong on 2023/7/13.
//

#include "call_c_bridge.h"
#include <ReconPipeline.h>
#include <cstdio>

void Pipeline_CameraInit()
{
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->CameraInit();
}

void Pipeline_AppendSfMData(uint32_t viewId,
                   uint32_t poseId,
                   uint32_t intrinsicId,
                   uint32_t frameId,
                   uint32_t width,
                   uint32_t height,
                   const unsigned char* bufferData)
{
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->AppendSfMData(viewId, poseId, intrinsicId, frameId, width, height, bufferData);
}

void Pipeline_FeatureExtraction()
{
    printf("Pipeline_FeatureExtraction\n");
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->FeatureExtraction();
    //
}

