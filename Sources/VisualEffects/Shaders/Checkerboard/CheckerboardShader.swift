//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public struct CheckerboardShader: Sendable, Equatable {
    public enum ColorConfiguration: Equatable, Sendable {
        case opacity(CGFloat)
        case color(SwiftUI.Color)
        case colors(SwiftUI.Color, SwiftUI.Color)
    }

    public var checkSize: CGSize
    public var origin: UnitPoint
    public var secondColor: ColorConfiguration
    public var reverse: Bool

    public init(checkSize: CGSize, origin: UnitPoint = .center, secondColor: ColorConfiguration, reverse: Bool = false) {
        self.checkSize = checkSize
        self.origin = origin
        self.secondColor = secondColor
        self.reverse = reverse
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension CheckerboardShader {
    init(checkSize: CGSize,
         origin: UnitPoint = .center,
         first: Color, second: Color, reverse: Bool = false)
    {
        self.init(checkSize: checkSize, origin: origin, secondColor: .colors(first, second), reverse: reverse)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension CheckerboardShader: ColorEffectShaderProvider {
    public var shaderLibrary: ShaderLibrary {
        ShaderLibrary.bundle(Bundle.module)
    }

    public func shader() -> Shader {
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
                ]
            )
        case let .opacity(opacity):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardReverse" : "checkerboard"),
                arguments: [
                    .float2(offset),
                    .float2(checkSize),
                    .float(opacity),
                ]
            )
        case let .colors(first, second):
            return Shader(
                function: shaderFunction(for: reverse ? "checkerboardColoredReverse" : "checkerboardColored"),
                arguments: [
                    .color(first),
                    .float2(offset),
                    .float2(checkSize),
                    .color(second),
                ]
            )
        }
    }
}
