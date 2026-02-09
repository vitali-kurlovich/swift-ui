//
//  swift-metalui
//
//  Created by Vitali Kurlovich on 20.01.26.
//

#include <metal_stdlib>
using namespace metal;

float checkerMixFactor(float2 position, float2 offset, float2 checkSize,  bool reverse) {
    position += offset;
    uint2 posInChecks = uint2( floor((position.x / checkSize.x) ) ,
                              floor((position.y / checkSize.y)) );
    return float(reverse ^ ((posInChecks.x ^ posInChecks.y) & 1));
}

half4 _checkerboard(float2 position, half4 currentColor, float2 offset, float2 checkSize, float opacity, bool reverse) {
    float mixFactor = checkerMixFactor(position, offset, checkSize, reverse);
    return mix(currentColor, currentColor * opacity, mixFactor);
}

half4 _checkerboardColored(float2 position,  half4 currentColor, float2 offset, float2 checkSize, half4 secondColor, bool reverse) {
    float mixFactor = checkerMixFactor(position, offset, checkSize, reverse);
    secondColor.w *= currentColor.w;
    return  mix(currentColor, secondColor, mixFactor);
}


[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float2 offset, float2 checkSize, float opacity) {
    return _checkerboard(position, currentColor, offset, checkSize, opacity, false);
}

[[ stitchable ]] half4 checkerboardReverse(float2 position,  half4 currentColor, float2 offset, float2 checkSize, float opacity) {
    return _checkerboard(position, currentColor, offset,  checkSize, opacity, true);
}

[[ stitchable ]] half4 checkerboardColored(float2 position,  half4 currentColor, float2 offset,  float2 checkSize, half4 secondColor) {
    return _checkerboardColored(position,  currentColor, offset, checkSize, secondColor, false);
}

[[ stitchable ]] half4 checkerboardColoredReverse(float2 position, half4 currentColor,  float2 offset, float2 checkSize,  half4 secondColor, float displayScale ) {
    return _checkerboardColored(position, currentColor, offset, checkSize, secondColor, true);
}


