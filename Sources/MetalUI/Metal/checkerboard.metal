//
//  swift-metalui
//
//  Created by Vitali Kurlovich on 20.01.26.
//

#include <metal_stdlib>
using namespace metal;

float checkerMixFactor(float2 position, float checkSize, bool reverse) {
    uint2 posInChecks = uint2(position.x / checkSize, position.y / checkSize);
    return float(reverse ^ ((posInChecks.x ^ posInChecks.y) & 1));
}

half4 _checkerboard(float2 position, half4 currentColor, float checkSize, float opacity, bool reverse) {
    float mixFactor = checkerMixFactor(position, checkSize, reverse);
    return mix(currentColor, currentColor * opacity, mixFactor);
}

half4 _checkerboardColored(float2 position, half4 currentColor, half4 secondColor, float checkSize, bool reverse) {
    float mixFactor = checkerMixFactor(position, checkSize, reverse);
    secondColor.w *= currentColor.w;
    return  mix(currentColor, secondColor, mixFactor);
}


[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float checkSize, float opacity) {
    return _checkerboard(position, currentColor, checkSize, opacity, false);
}

[[ stitchable ]] half4 checkerboardReverse(float2 position, half4 currentColor, float checkSize, float opacity) {
    return _checkerboard(position, currentColor, checkSize, opacity, true);
}

[[ stitchable ]] half4 checkerboardColored(float2 position, half4 currentColor,  half4 secondColor, float checkSize) {
    return _checkerboardColored(position, currentColor, secondColor, checkSize, false);
}

[[ stitchable ]] half4 checkerboardColoredReverse(float2 position, half4 currentColor,  half4 secondColor, float checkSize) {
    return _checkerboardColored(position, currentColor, secondColor, checkSize, true);
}


