//
//  camerainit.cpp
//  SoftVision
//
//  Created by HouPeihong on 2023/7/13.
//

#include "call_c_bridge.h"
#include "ReconPipeline.h"

void Pipeline_CameraInit()
{
    ReconPipeline *p = ReconPipeline::GetInstance();
    p->CameraInit();
}

//void LoadSfmDatafromSomeSwiftStuff(void* data)
//{
//    ReconPipeline *p = ReconPipeline::GetInstance();
//    //
//}

