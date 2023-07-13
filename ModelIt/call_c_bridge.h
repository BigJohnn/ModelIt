//
//  call_c_bridge.h
//  ModelIt
//
//  Created by HouPeihong on 2023/7/13.
//

#ifndef call_c_bridge_h
#define call_c_bridge_h

#ifdef __cplusplus
extern "C" {
#endif

typedef void* Pipeline;

Pipeline Pipeline_Create();
void Pipeline_CameraInit(Pipeline pipeline);

#ifdef __cplusplus
}
#endif


#endif /* call_c_bridge_h */
