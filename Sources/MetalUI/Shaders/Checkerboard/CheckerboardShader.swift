//
//  CheckerboardShader.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

struct CheckerboardShader: Sendable, Equatable {
    enum ColorConfiguration: Equatable {
        case opacity(CGFloat)
        case color(SwiftUI.Color)
    }

    var checkSize: CGFloat
    var secondColor: ColorConfiguration

    var reverse: Bool
}

extension CheckerboardShader: ColorEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        ShaderLibrary.bundle(Bundle.module)
    }

    func shader(_: GeometryProxy) -> Shader {
        switch secondColor {
        case let .color(color):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardColoredReverse" : "checkerboardColored"),
                arguments: [
                    .color(color),
                    .float(checkSize),
                ]
            )
        case let .opacity(opacity):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardReverse" : "checkerboard"),
                arguments: [
                    .float(checkSize),
                    .float(opacity),
                ]
            )
        }
    }
}
