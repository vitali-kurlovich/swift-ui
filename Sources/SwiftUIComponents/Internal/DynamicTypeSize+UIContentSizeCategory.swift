//
//  DynamicTypeSize+UIContentSizeCategory.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

extension DynamicTypeSize {
    #if canImport(UIKit)

        var contentSizeCategory: UIContentSizeCategory {
            switch self {
            case .xSmall:
                return .extraSmall
            case .small:
                return .small
            case .medium:
                return .medium
            case .large:
                return .large
            case .xLarge:
                return .extraLarge
            case .xxLarge:
                return .extraExtraLarge
            case .xxxLarge:
                return .extraExtraExtraLarge
            case .accessibility1:
                return .accessibilityMedium
            case .accessibility2:
                return .accessibilityLarge
            case .accessibility3:
                return .accessibilityExtraLarge
            case .accessibility4:
                return .accessibilityExtraExtraLarge
            case .accessibility5:
                return .accessibilityExtraExtraExtraLarge
            @unknown default:
                return .medium
            }
        }

    #endif
}
