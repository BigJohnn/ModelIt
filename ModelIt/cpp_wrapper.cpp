//
//  camerainit.cpp
//  SoftVision
//
//  Created by HouPeihong on 2023/7/13.
//

#include "call_c_bridge.h"
#include "ReconPipeline.h"

static ReconPipeline* pPipeline = nullptr;

void Pipeline_CameraInit()
{
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->CameraInit();
}

