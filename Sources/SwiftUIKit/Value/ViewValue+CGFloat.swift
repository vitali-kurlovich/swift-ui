//
//  ViewValue+CGFloat.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

public extension ViewValue where BaseType == CGFloat {
    func value(_ environmentValues: EnvironmentValues) -> BaseType {
        value(environmentValues.dynamicTypeSize)
    }

    func value(_ typeSize: DynamicTypeSize) -> BaseType {
        value(UITraitCollection(preferredContentSizeCategory: typeSize.contentSizeCategory))
    }

    func value(_ traitCollection: UITraitCollection) -> BaseType {
        switch self {
        case let .fixed(value):
            return value
        case let .dynamic(value):
            return UIFontMetrics.default.scaledValue(for: value, compatibleWith: traitCollection)
        }
    }
}
