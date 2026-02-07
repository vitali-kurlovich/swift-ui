//
//  DisclosureIndicatorStyle+Fill.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 6.02.26.
//

import SwiftUI

public extension DisclosureIndicatorStyle {
    func fill<S: ShapeStyle>(_ shapeStyle: S) -> DisclosureIndicatorWithBackgroundStyle<Self, S> {
        DisclosureIndicatorWithBackgroundStyle(baseStyle: self, fillStyle: shapeStyle)
    }
}

public extension FilledDisclosureIndicatorStyle {
    func fill<S: ShapeStyle>(_ shapeStyle: S) -> DisclosureIndicatorWithBackgroundStyle<BaseStyle, S> {
        DisclosureIndicatorWithBackgroundStyle(baseStyle: baseStyle, fillStyle: shapeStyle)
    }
}

#Preview {
    @Previewable @State var configuration: DisclosureIndicatorConfiguration = .init(isExpanded: false, isPressed: false)

    VStack {
        HStack {
            DisclosureIndicator(style: .chevron.fill(.regularMaterial), configuration: configuration)

            DisclosureIndicator(style: .chevron.fill(.pink), configuration: configuration)

            DisclosureIndicator(style: .chevronCircleFill.fill(.tint), configuration: configuration)

            DisclosureIndicator(style: .chevron.fill(.orange.gradient), configuration: configuration)

            DisclosureIndicator(style: .chevron.fill(.tint).fill(.green.secondary), configuration: configuration)
        }
        Form {
            Section {
                Group {
                    Toggle("isExpanded", isOn: $configuration.isExpanded.animation())

                    Toggle("isPressed", isOn: $configuration.isPressed.animation())

                }.toggleStyle(.button)
            }
        }
    }
}
