//
//  ColorEffectShader.metal
//  MetalDemo
//
//  Created by Itsuki on 2025/08/16.
//

#include <metal_stdlib>
using namespace metal;


// position: (x, y)
// position of the current pixel in user-space coordinates
// for example, to get the x position, position.x
//
// return value: new position for the source pixel
// for example, float2(0.0, 0.0)
[[ stitchable ]] float2 rainbow(float2 position, float viewWidth, float maxHeightOffset) {
    float newPositionY =  sqrt(pow(maxHeightOffset, 2) - pow(position.x - viewWidth / 2, 2))  + position.y;
    return float2(position.x, newPositionY);
}
