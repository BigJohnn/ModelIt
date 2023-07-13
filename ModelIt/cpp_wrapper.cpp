//
//  camerainit.cpp
//  SoftVision
//
//  Created by HouPeihong on 2023/7/13.
//

#include "call_c_bridge.h"
#include "camerainit.h"

Pipeline Pipeline_Create()
{
    return new ReconPipeline();
}

void Pipeline_CameraInit(Pipeline pipeline)
{
    ReconPipeline *p = (ReconPipeline*)pipeline;
    p->CameraInit();
}

