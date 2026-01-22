//
//  Checkerboard.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 22.01.26.
//

import SwiftUI

public struct Checkerboard: View, Equatable {
    private let firstColor: Color
    private let secondColor: Color

    private let configuration: Configuration

    public init(primary: Color = .primary, secondary: Color = .secondary, _ configuration: Configuration) {
        firstColor = primary
        secondColor = secondary
        self.configuration = configuration
    }

    public var body: some View {
        firstColor.checkerboard(checkSize: configuration.checkSize,
                                origin: configuration.origin,
                                secondColor: secondColor)
    }
}

public extension Checkerboard {
    struct Configuration: Equatable, Sendable {
        public let size: CGFloat
        public let origin: UnitPoint
        public let dynamicSize: Bool

        public init(size: CGFloat, origin: UnitPoint = .center, dynamicSize: Bool = false) {
            self.size = size
            self.origin = origin
            self.dynamicSize = dynamicSize
        }
    }
}

public extension Checkerboard.Configuration {
    static func small(_ dynamic: Bool = true) -> Self {
        .init(size: 6, dynamicSize: dynamic)
    }

    static func medium(_ dynamic: Bool = true) -> Self {
        .init(size: 10, dynamicSize: dynamic)
    }

    static func large(_ dynamic: Bool = true) -> Self {
        .init(size: 16, dynamicSize: dynamic)
    }
}

private extension Checkerboard.Configuration {
    var checkSize: ViewValue<CGSize> {
        if dynamicSize {
            return .dynamic(.init(width: size, height: size))
        }

        return .fixed(.init(width: size, height: size))
    }
}

#Preview {
    Checkerboard(.small())
    Checkerboard(.medium())
    Checkerboard(.large())
}
