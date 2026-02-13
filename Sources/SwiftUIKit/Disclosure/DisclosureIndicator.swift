//
//  DisclosureIndicator.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 7.02.26.
//

import SwiftUI

struct DisclosureIndicator<Indicator: View>: View {
    @Environment(\.indicatorStyle)
    private var style

    let isExpanded: Bool
    let indicator: () -> Indicator

    init(isExpanded: Bool, indicator: @escaping () -> Indicator) {
        self.isExpanded = isExpanded
        self.indicator = indicator
    }

    var body: some View {
        let indicator = DisclosureStyleConfiguration.Indicator(indicator())

        let configuration = DisclosureStyleConfiguration(
            indicator: indicator,
            isExpanded: isExpanded
        )

        return AnyView(style.makeBody(configuration: configuration))
    }
}

extension DisclosureIndicator where Indicator == Image {
    enum Symbol: String {
        case chevron = "chevron.forward"
        case chevronCircle = "chevron.forward.circle"
        case chevronCircleFill = "chevron.forward.circle.fill"
    }

    init(isExpanded: Bool,
         _ symbol: Symbol = .chevron)
    {
        self.init(isExpanded: isExpanded,
                  systemName: symbol.rawValue)
    }

    init(isExpanded: Bool,
         _ symbol: Symbol = .chevron,
         renderingMode: Image.TemplateRenderingMode)
    {
        self.init(isExpanded: isExpanded,
                  systemName: symbol.rawValue,
                  renderingMode: renderingMode)
    }

    init(isExpanded: Bool,
         systemName: String,
         renderingMode: Image.TemplateRenderingMode)
    {
        self.init(
            isExpanded: isExpanded,
            indicator: {
                Image(systemName: systemName)
                    .renderingMode(renderingMode)
            }
        )
    }

    init(isExpanded: Bool,
         systemName: String)
    {
        self.init(
            isExpanded: isExpanded,
            indicator: {
                Image(systemName: systemName)
            }
        )
    }
}

#Preview {
    @Previewable @State var isExpanded = false

    VStack {
        HStack {
            DisclosureIndicator(isExpanded: isExpanded)
            DisclosureIndicator(isExpanded: isExpanded, .chevronCircle)
        }
        Spacer()
        HStack {
            if #available(iOS 18.0, *) {
                DisclosureIndicator(isExpanded: isExpanded, systemName: "sun.max.fill", renderingMode: .original)
                    .symbolEffect(.bounce, options: .repeating)
            } else {
                DisclosureIndicator(isExpanded: isExpanded, systemName: "sun.max.fill", renderingMode: .original)
            }

            DisclosureIndicator(isExpanded: isExpanded)
                .disclosureIndicatorStyle(IndicatorCircleBackgroundStyle(fillStyle: Color.orange.secondary))

            DisclosureIndicator(isExpanded: isExpanded)
                .disclosureIndicatorStyle(IndicatorCircleBackgroundStyle(fillStyle: Color.red.gradient))

            DisclosureIndicator(isExpanded: isExpanded, .chevronCircleFill)
                .disclosureIndicatorStyle(IndicatorCircleBackgroundStyle(fillStyle: .checkerboard(.small(), first: .pink, second: .mint)))
                .dynamicTypeSize(.accessibility2)

        }.disclosureIndicatorStyle(.ultraThinCircle)
        Form {
            Section {
                Group {
                    Toggle("isExpanded", isOn: $isExpanded.animation())
                }.toggleStyle(.button)
            }
        }
    }
}
