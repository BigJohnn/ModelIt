#include <metal_stdlib>
using namespace metal;

// mn MATRIX ADDRESSING: mxy = x*n+y (x-row,y-col), (m-number of rows, n-number of columns)


namespace depthMap {

//void outerMultiply(thread float3x3& O3x3, const thread float3& a, const thread float3& b)
//{
//    O3x3[0] = a.x * b.x;
//    O3x3[3] = a.x * b.y;
//    O3x3[6] = a.x * b.z;
//    O3x3[1] = a.y * b.x;
//    O3x3[4] = a.y * b.y;
//    O3x3[7] = a.y * b.z;
//    O3x3[2] = a.z * b.x;
//    O3x3[5] = a.z * b.y;
//    O3x3[8] = a.z * b.z;
//}

inline float3 linePlaneIntersect(constant float3& linePoint,
                                            const thread float3& lineVect,
                                            const thread float3& planePoint,
                                 constant float3& planeNormal)
{
    const float k = (dot(planePoint, planeNormal) - dot(planeNormal, linePoint)) / dot(planeNormal, lineVect);
    return linePoint + lineVect * k;
}

inline float3 closestPointOnPlaneToPoint(const thread float3& point, const thread float3& planePoint, const thread float3& planeNormalNormalized)
{
    return point - planeNormalNormalized * dot(planeNormalNormalized, point - planePoint);
}

inline float3 closestPointToLine3D(const thread float3& point, const thread float3& linePoint, const thread float3& lineVectNormalized)
{
    return linePoint + lineVectNormalized * dot(lineVectNormalized, point - linePoint);
}



// v1,v2 dot not have to be normalized
inline float angleBetwV1andV2(const device float3& iV1, const device float3& iV2)
{
    float3 V1 = iV1;
    V1 = normalize(V1);

    float3 V2 = iV2;
    V2 = normalize(V2);

    return abs(acos(V1.x * V2.x + V1.y * V2.y + V1.z * V2.z) / (M_PI_F / 180.0f));
}

inline float angleBetwABandAC(const thread float3& A, const thread float3& B, const thread float3& C)
{
    float3 V1 = B - A;
    float3 V2 = C - A;

    V1 = normalize(V1);
    V2 = normalize(V2);

    const float x = float(V1.x * V2.x + V1.y * V2.y + V1.z * V2.z);
    float a = acos(x);
    a = isinf(a) ? 0.0 : a;
    return float(fabs(a) / (M_PI_F / 180.0));
}


/**
 * @brief Sigmoid function filtering
 * @note f(x) = min + (max-min) * \frac{1}{1 + e^{10 * (x - mid) / width}}
 * @see https://www.desmos.com/calculator/1qvampwbyx
 */
inline float sigmoid(float zeroVal, float endVal, float sigwidth, float sigMid, float xval)
{
    return zeroVal + (endVal - zeroVal) * (1.0f / (1.0f + exp(10.0f * ((xval - sigMid) / sigwidth))));
}

/**
 * @brief Sigmoid function filtering
 * @note f(x) = min + (max-min) * \frac{1}{1 + e^{10 * (mid - x) / width}}
 */
inline float sigmoid2(float zeroVal, float endVal, float sigwidth, float sigMid, float xval)
{
    return zeroVal + (endVal - zeroVal) * (1.0f / (1.0f + exp(10.0f * ((sigMid - xval) / sigwidth))));
}

} // namespace depthMap

