//
//  swift-metalui
//
//  Created by Vitali Kurlovich on 20.01.26.
//

#include <metal_stdlib>
using namespace metal;

float checkerMixFactor(float2 position, float2 offset, float2 checkSize, float displayScale, bool reverse) {
    
    position += offset;
  //  position *= displayScale;
    
    uint2 posInChecks = uint2( floor((position.x / checkSize.x) ) ,
                              floor((position.y / checkSize.y)) );
    return float(reverse ^ ((posInChecks.x ^ posInChecks.y) & 1));
}

half4 _checkerboard(float2 position, half4 currentColor,  float2 offset, float2 checkSize, float opacity, float displayScale, bool reverse) {
    float mixFactor = checkerMixFactor(position, offset, checkSize, displayScale, reverse);
    return mix(currentColor, currentColor * opacity, mixFactor);
}

half4 _checkerboardColored(float2 position,  half4 currentColor, float2 offset, float2 checkSize, half4 secondColor, float displayScale, bool reverse) {
    float mixFactor = checkerMixFactor(position, offset, checkSize, displayScale, reverse);
    secondColor.w *= currentColor.w;
    return  mix(currentColor, secondColor, mixFactor);
}


[[ stitchable ]] half4 checkerboard(float2 position,  half4 currentColor, float2 offset, float2 checkSize, float opacity, float displayScale) {
    return _checkerboard(position,  currentColor, offset, checkSize, opacity, displayScale, false);
}

[[ stitchable ]] half4 checkerboardReverse(float2 position,  half4 currentColor, float2 offset, float2 checkSize, float opacity, float displayScale) {
    return _checkerboard(position, currentColor, offset,  checkSize, opacity, displayScale, true);
}

[[ stitchable ]] half4 checkerboardColored(float2 position,  half4 currentColor, float2 offset,  float2 checkSize, half4 secondColor, float displayScale) {
    return _checkerboardColored(position,  currentColor, offset, checkSize, secondColor, displayScale, false);
}

[[ stitchable ]] half4 checkerboardColoredReverse(float2 position, half4 currentColor,  float2 offset, float2 checkSize,  half4 secondColor, float displayScale ) {
    return _checkerboardColored(position,  currentColor, offset, checkSize, secondColor, displayScale, true);
}


