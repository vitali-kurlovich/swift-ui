//
//  CheckerboardShapeStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import VisualEffects

import SwiftUI

public struct CheckerboardShapeStyle: ShapeStyle, Equatable {
    public typealias Configuration = CheckerboardConfiguration

    private let configuration: Configuration

    private let firstColor: Color
    private let secondColor: Color

    public init(_ configuration: Configuration, first: Color = .primary, second: Color = .secondary) {
        self.configuration = configuration
        firstColor = first
        secondColor = second
    }

    public func resolve(in environment: EnvironmentValues) -> some ShapeStyle {
        let checkSize = configuration.resolveSize(environment)
        let origin = configuration.origin

        let style = VisualEffects.CheckerboardShapeStyle(checkSize: checkSize, origin: origin, first: firstColor, second: secondColor)

        return style.resolve(in: environment)
    }
}

public extension ShapeStyle where Self == CheckerboardShapeStyle {
    static func checkerboard(
        _ configuration: CheckerboardConfiguration = .medium(),
        first: Color = .primary,
        second: Color = .secondary
    ) -> Self {
        CheckerboardShapeStyle(configuration, first: first, second: second)
    }
}

#Preview {
    Circle().fill(.checkerboard(.small()))
    Circle().fill(.checkerboard())
    Circle().fill(.checkerboard(.medium(false)))

    RoundedRectangle(cornerRadius: 43).fill(.checkerboard(.medium(), second: .accentColor))
    Capsule().fill(.checkerboard(.large(), first: .indigo, second: .orange))
}
