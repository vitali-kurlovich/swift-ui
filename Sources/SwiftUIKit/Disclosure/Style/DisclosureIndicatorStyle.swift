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

        init<V: View>(_ view: V) {
            storge = AnyView(view)
        }
    }

    public let indicator: DisclosureStyleConfiguration.Indicator

    public let isExpanded: Bool
}

private struct IndicatorStyleEnvironmentKey: EnvironmentKey {
    static let defaultValue: any DisclosureIndicatorStyle = DefaultDisclosureIndicatorStyle()
}

extension EnvironmentValues {
    var indicatorStyle: any DisclosureIndicatorStyle {
        get { self[IndicatorStyleEnvironmentKey.self] }
        set { self[IndicatorStyleEnvironmentKey.self] = newValue }
    }
}

public extension View {
    func disclosureIndicatorStyle<S: DisclosureIndicatorStyle>(_ style: S) -> some View {
        environment(\.indicatorStyle, style)
    }
}
