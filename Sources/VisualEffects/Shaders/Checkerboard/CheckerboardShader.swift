//
//  CheckerboardShader.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

public struct CheckerboardShader: Sendable, Equatable {
    public enum ColorConfiguration: Equatable, Sendable {
        case opacity(CGFloat)
        case color(SwiftUI.Color)
    }

    public var checkSize: CGSize
    public var origin: UnitPoint
    public var secondColor: ColorConfiguration
    public var reverse: Bool
    public var displayScale: CGFloat

    public init(checkSize: CGSize, origin: UnitPoint, secondColor: ColorConfiguration, reverse: Bool, displayScale: CGFloat) {
        self.checkSize = checkSize
        self.origin = origin
        self.secondColor = secondColor
        self.reverse = reverse
        self.displayScale = displayScale
    }
}

extension CheckerboardShader: ColorEffectShaderProvider {
    public var shaderLibrary: ShaderLibrary {
        ShaderLibrary.bundle(Bundle.module)
    }

    public func shader(_: GeometryProxy) -> Shader {
        let size = checkSize
        let offset = CGSize(width: size.width * origin.x, height: size.height * origin.y)

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
