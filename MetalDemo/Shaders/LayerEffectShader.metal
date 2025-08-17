//
//  ColorEffectShader.metal
//  MetalDemo
//
//  Created by Itsuki on 2025/08/16.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;



// same effect as applying distortionEffect with rainbow and then colorEffect with checkerboard
[[ stitchable ]] half4 rainbowCheckerboard
(
 float2 position,
 SwiftUI::Layer layer,
 float viewWidth,
 float maxHeightOffset,
 float checkSize,
 float opacity
 ) {
    // make rainbow
    float newPositionY =  sqrt(pow(maxHeightOffset, 2) - pow(position.x - viewWidth / 2, 2))  + position.y;
    float2 newPosition = float2(position.x, newPositionY);

    // key difference
    // calculate from original position instead of new location
    uint2 posInChecks = uint2(position.x / checkSize, position.y / checkSize);
    
    // make checkerboard
    half4 currentColor = layer.sample(newPosition);
    bool isOpaque = (posInChecks.x ^ posInChecks.y) & 1;
    return isOpaque ? currentColor * opacity : currentColor;
}


// same effect as applying colorEffect with checkerboard and then distortionEffect with rainbow
[[ stitchable ]] half4 checkerboardRainbow
(
 float2 position,
 SwiftUI::Layer layer,
 float viewWidth,
 float maxHeightOffset,
 float checkSize,
 float opacity
 ) {
    // make rainbow
    float newPositionY =  sqrt(pow(maxHeightOffset, 2) - pow(position.x - viewWidth / 2, 2))  + position.y;
    float2 newPosition = float2(position.x, newPositionY);
    
    // key difference
    // calculate from new position instead of original location
    uint2 posInChecks = uint2(newPosition.x / checkSize, newPosition.y / checkSize);

    // make checkerboard
    half4 currentColor = layer.sample(newPosition);
    bool isOpaque = (posInChecks.x ^ posInChecks.y) & 1;
    return isOpaque ? currentColor * opacity : currentColor;
}
