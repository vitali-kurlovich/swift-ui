//
//  DisclosureIndicatorWithBackgroundStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 5.02.26.
//

import SwiftUI

public protocol FilledDisclosureIndicatorStyle: DisclosureIndicatorStyle {
    associatedtype BaseStyle: DisclosureIndicatorStyle
    associatedtype FillStyle: ShapeStyle

    var baseStyle: BaseStyle { get }
    var fillStyle: FillStyle { get }
}

public struct DisclosureIndicatorWithBackgroundStyle<BaseStyle: DisclosureIndicatorStyle, FillStyle: ShapeStyle>: FilledDisclosureIndicatorStyle {
    public let baseStyle: BaseStyle
    public let fillStyle: FillStyle

    public init(baseStyle: BaseStyle, fillStyle: FillStyle) {
        self.baseStyle = baseStyle
        self.fillStyle = fillStyle
    }

    public func makeBody(configuration: Configuration) -> some View {
        baseStyle.makeBody(configuration: configuration)
            .background {
                Circle().fill(fillStyle)
            }
    }
}

extension DisclosureIndicatorWithBackgroundStyle: Equatable where BaseStyle: Equatable, FillStyle: Equatable {}

public extension DisclosureIndicatorStyle where Self == DisclosureIndicatorWithBackgroundStyle<SymbolDisclosureIndicatorStyle, Material> {
    @MainActor static var chevronUltraThin: some DisclosureIndicatorStyle {
        DisclosureIndicatorWithBackgroundStyle(baseStyle: .chevron, fillStyle: .ultraThinMaterial)
    }
}

public extension DisclosureIndicatorStyle where Self == DisclosureIndicatorWithBackgroundStyle<SymbolDisclosureIndicatorStyle, Color> {
    @MainActor static func chevron(with color: Color) -> Self {
        DisclosureIndicatorWithBackgroundStyle(baseStyle: .chevron, fillStyle: color)
    }
}

#Preview {
    @Previewable @State var configuration: DisclosureIndicatorConfiguration = .init(isExpanded: false, isPressed: false)

    VStack {
        HStack {
            DisclosureIndicator(style: .chevronUltraThin, configuration: configuration)

            DisclosureIndicator(style: .chevron(with: .indigo), configuration: configuration)

            DisclosureIndicator(style: .chevron.fill(.pink), configuration: configuration)
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
