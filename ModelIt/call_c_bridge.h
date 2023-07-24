//
//  call_c_bridge.h
//  ModelIt
//
//  Created by HouPeihong on 2023/7/13.
//

#ifndef call_c_bridge_h
#define call_c_bridge_h

#include "stdint.h"
#ifdef __cplusplus
extern "C" {
#endif

//typedef void* Pipeline;

void Pipeline_CameraInit();

void Pipeline_AppendSfMData(uint32_t viewId,
                   uint32_t poseId,
                   uint32_t intrinsicId,
                   uint32_t frameId,
                   uint32_t width,
                   uint32_t height,
                    const char* metadata);
//void LoadSfmDatafromSomeSwiftStuff(void* data);
void Pipeline_FeatureExtraction(void* data);

#ifdef __cplusplus
}
#endif


#endif /* call_c_bridge_h */
