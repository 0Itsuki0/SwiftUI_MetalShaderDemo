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
// for example, to get the x position, position.x or position[0]
//
// current color: (r, g, b, a)
// source color of the position
// for example, to get the red component, currentColor.r or currentColor[0]
//
// return value:  the half4 color
// for example, half4(0.0, 0.0, 0.0, 0.0) for black
[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float checkSize, float opacity) {
    // A view will consist of a certain number of checkers in the x and y direction
    // posInChecks gives which checker will the given pixel belongs to.
    uint2 posInChecks = uint2(position.x / checkSize, position.y / checkSize);
    bool isOpaque = (posInChecks.x ^ posInChecks.y) & 1;
    return isOpaque ? currentColor * opacity : currentColor;
}
