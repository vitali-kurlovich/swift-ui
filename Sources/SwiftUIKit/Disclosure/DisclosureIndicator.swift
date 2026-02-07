//
//  DisclosureIndicator.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 5.02.26.
//

import SwiftUI

public struct DisclosureIndicator<Style: DisclosureIndicatorStyle>: View {
    let style: Style
    let configuration: DisclosureIndicatorConfiguration

    public init(style: Style, configuration: DisclosureIndicatorConfiguration) {
        self.style = style
        self.configuration = configuration
    }

    public var body: some View {
        style.makeBody(configuration: configuration)
    }
}

public extension DisclosureIndicator where Style == SymbolDisclosureIndicatorStyle {
    init(configuration: DisclosureIndicatorConfiguration) {
        self.init(style: .chevron, configuration: configuration)
    }
}

public extension DisclosureIndicator {
    func disclosureIndicatorStyle<S: DisclosureIndicatorStyle>(_ style: S) -> DisclosureIndicator<S> {
        DisclosureIndicator<S>(style: style, configuration: configuration)
    }
}

public protocol DisclosureIndicatorStyle: Sendable {
    associatedtype Body: View

    @ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = DisclosureIndicatorConfiguration
}

public struct DisclosureIndicatorConfiguration: Sendable, Equatable {
    public var isExpanded: Bool
    public var isPressed: Bool
}

extension DisclosureIndicator: Equatable where Style: Equatable {}

#Preview {
    @Previewable @State var configuration: DisclosureIndicatorConfiguration = .init(isExpanded: false, isPressed: false)

    VStack {
        HStack {
            DisclosureIndicator(configuration: configuration)

            DisclosureIndicator(style: .chevronUltraThin, configuration: configuration)

            DisclosureIndicator(configuration: configuration).disclosureIndicatorStyle(.chevron.fill(.green))

            DisclosureIndicator(configuration: configuration).disclosureIndicatorStyle(.chevron.fill(.green))
                .disclosureIndicatorStyle(.chevron.fill(.red.quinary))
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
