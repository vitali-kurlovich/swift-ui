//
//  SymbolDisclosureIndicatorStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 5.02.26.
//

import SwiftUI

public struct SymbolDisclosureIndicatorStyle: DisclosureIndicatorStyle, Equatable {
    let systemName: String
    let insets: EdgeInsets

    public init(systemName: String = "chevron.forward", insets: EdgeInsets = .init()) {
        self.systemName = systemName
        self.insets = insets
    }

    public init(_ symbol: Symbol) {
        switch symbol {
        case .chevron:
            self.init(systemName: symbol.rawValue, insets: .init(top: 4, leading: 4, bottom: 4, trailing: 4))
        case .chevronCircle:
            self.init(systemName: symbol.rawValue)
        case .chevronCircleFill:
            self.init(systemName: symbol.rawValue)
        }
    }

    public func makeBody(configuration: Configuration) -> some View {
        Image(systemName: systemName)
            .frame(aspectRatio: 1)
            .rotationEffect(rotation(for: configuration))
            .padding(insets)
    }
}

private extension SymbolDisclosureIndicatorStyle {
    func rotation(for configuration: Configuration) -> Angle {
        configuration.isExpanded ? .degrees(90) : .zero
    }
}

public extension SymbolDisclosureIndicatorStyle {
    enum Symbol: String {
        case chevron = "chevron.forward"
        case chevronCircle = "chevron.forward.circle"
        case chevronCircleFill = "chevron.forward.circle.fill"
    }
}

public extension DisclosureIndicatorStyle where Self == SymbolDisclosureIndicatorStyle {
    @MainActor static var chevron: Self {
        .init(.chevron)
    }

    @MainActor static var chevronCircle: Self {
        .init(.chevronCircle)
    }

    @MainActor static var chevronCircleFill: Self {
        .init(.chevronCircleFill)
    }
}

#Preview {
    @Previewable @State var configuration: DisclosureIndicatorConfiguration = .init(isExpanded: false, isPressed: false)

    VStack {
        HStack {
            DisclosureIndicator(style: .chevron, configuration: configuration)

            DisclosureIndicator(style: .chevronCircle, configuration: configuration)

            DisclosureIndicator(style: .chevronCircleFill, configuration: configuration)
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
