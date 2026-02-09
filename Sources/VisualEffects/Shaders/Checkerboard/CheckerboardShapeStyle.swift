//
//  CheckerboardShapeStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

public struct CheckerboardShapeStyle: ShapeStyle, Equatable {
    public var checkSize: CGSize
    public var origin: UnitPoint
    public var first: Color
    public var second: Color

    public init(checkSize: CGSize, origin: UnitPoint = .zero, first: Color = .primary, second: Color = .secondary) {
        self.checkSize = checkSize
        self.origin = origin
        self.first = first
        self.second = second
    }

    public func resolve(in _: EnvironmentValues) -> some ShapeStyle {
        let checkerboardShader = CheckerboardShader(checkSize: checkSize, origin: origin, first: first, second: second, reverse: false)

        return checkerboardShader.shader()
    }
}

public extension CheckerboardShapeStyle {
    init(checkSize: CGFloat, origin: UnitPoint = .zero, first: Color = .primary, second: Color = .secondary) {
        self.init(checkSize: CGSize(width: checkSize, height: checkSize), origin: origin, first: first, second: second)
    }
}

#Preview {
    Circle().fill(CheckerboardShapeStyle(checkSize: 20))
}
