//
//  File.metal
//  swift-metalui
//
//  Created by Vitali Kurlovich on 20.01.26.
//

#include <metal_stdlib>
using namespace metal;

bool isBlackChecker(float2 position, float checkSize, bool reverse) {
    uint2 posInChecks = uint2(position.x / checkSize, position.y / checkSize);
    return reverse ^ ((posInChecks.x ^ posInChecks.y) & 1);
}

half4 _checkerboard(float2 position, half4 currentColor, float checkSize, float opacity, bool reverse) {
    bool isOpaque = isBlackChecker(position, checkSize, reverse);
    return isOpaque ? currentColor * opacity : currentColor;
}

[[ stitchable ]] half4 checkerboard(float2 position, half4 currentColor, float checkSize, float opacity) {
    return _checkerboard(position, currentColor, checkSize, opacity, false);
}

[[ stitchable ]] half4 checkerboardReverse(float2 position, half4 currentColor, float checkSize, float opacity) {
    return _checkerboard(position, currentColor, checkSize, opacity, true);
}

