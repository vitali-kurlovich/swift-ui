//
//  DisclosureIndicatorStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 8.02.26.
//

import SwiftUI

@MainActor
public protocol DisclosureIndicatorStyle: Sendable {
    associatedtype Body: View

    @ViewBuilder @MainActor func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = DisclosureStyleConfiguration
}

extension DisclosureIndicatorStyle {
    func rotation(for configuration: Configuration) -> Angle {
        configuration.isExpanded ? .degrees(90) : .zero
    }
}

public struct DisclosureStyleConfiguration {
    @MainActor
    public struct Indicator: View {
        public var body: AnyView {
            storge
        }

        let storge: AnyView

        init(_ view: some View) {
            storge = AnyView(view)
        }
    }

    public let indicator: DisclosureStyleConfiguration.Indicator

    public let isExpanded: Bool
}

extension EnvironmentValues {
    @Entry var indicatorStyle: any DisclosureIndicatorStyle = DefaultDisclosureIndicatorStyle()
}

public extension View {
    func disclosureIndicatorStyle(_ style: some DisclosureIndicatorStyle) -> some View {
        environment(\.indicatorStyle, style)
    }
}
