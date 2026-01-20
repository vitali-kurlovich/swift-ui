//
//  CheckerboardShader.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

struct CheckerboardShader: Sendable, Equatable {
    var checkSize: CGFloat
    var opacity: CGFloat
    var reverse: Bool
}

extension CheckerboardShader: ColorEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        ShaderLibrary.bundle(Bundle.module)
    }

    func shader(_: GeometryProxy) -> Shader {
        Shader(
            function: shaderFunction(for: reverse ? "checkerboardReverse" : "checkerboard"),
            arguments: [
                .float(checkSize),
                .float(opacity),
            ]
        )
    }
}
