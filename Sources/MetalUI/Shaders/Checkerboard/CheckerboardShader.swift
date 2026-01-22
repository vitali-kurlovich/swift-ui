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

    var checkSize: CGSize
    var origin: UnitPoint
    var secondColor: ColorConfiguration
    var reverse: Bool
    var displayScale: CGFloat
}

extension CheckerboardShader: ColorEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        ShaderLibrary.bundle(Bundle.module)
    }

    func shader(_: GeometryProxy) -> Shader {
        // let size = proxy.size
        // let size = proxy.frame(in: .local).size

        let size = checkSize
        let offset = CGSize(width: size.width * origin.x, height: size.height * origin.y)
        debugPrint(offset)
        switch secondColor {
        case let .color(color):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardColoredReverse" : "checkerboardColored"),
                arguments: [
                    .float2(offset),
                    .float2(checkSize),
                    .color(color),
                    .float(displayScale),
                ]
            )
        case let .opacity(opacity):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardReverse" : "checkerboard"),
                arguments: [
                    .float2(offset),
                    .float2(checkSize),
                    .float(opacity),
                    .float(displayScale),
                ]
            )
        }
    }
}
