//
//  ViewValue+CGSize.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

public extension ViewValue where BaseType == CGSize {
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
            let norm = (value.width * value.width + value.height * value.height).squareRoot()
            let scaledNorm = UIFontMetrics.default.scaledValue(for: norm, compatibleWith: traitCollection)
            let scale = scaledNorm / norm

            return CGSize(width: value.width * scale, height: value.height * scale)
        }
    }
}
