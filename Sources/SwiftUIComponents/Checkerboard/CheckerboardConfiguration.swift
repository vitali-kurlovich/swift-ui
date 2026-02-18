//
//  CheckerboardConfiguration.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

public struct CheckerboardConfiguration: Equatable, Sendable {
    public let size: CGFloat
    public let origin: UnitPoint
    public let dynamicSize: Bool

    public init(size: CGFloat, origin: UnitPoint = .center, dynamicSize: Bool = false) {
        self.size = size
        self.origin = origin
        self.dynamicSize = dynamicSize
    }
}

extension CheckerboardConfiguration {
    func resolveSize(_ dynamicTypeSize: DynamicTypeSize) -> CGSize {
        let size = CGSize(width: size, height: size)

        if dynamicSize {
            return ViewValue.dynamic(size).value(dynamicTypeSize)
        }
        return size
    }

    func resolveSize(_ environmentValues: EnvironmentValues) -> CGSize {
        resolveSize(environmentValues.dynamicTypeSize)
    }
}

public extension CheckerboardConfiguration {
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
