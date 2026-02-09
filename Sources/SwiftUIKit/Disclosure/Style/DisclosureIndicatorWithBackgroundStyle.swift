//
//  DisclosureIndicatorWithBackgroundStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 9.02.26.
//

import SwiftUI

struct DisclosureIndicatorWithBackgroundStyle<Background: View>: DisclosureIndicatorStyle {
    let padding: CGFloat
    let background: () -> Background

    init(padding: CGFloat, @ViewBuilder background: @escaping () -> Background) {
        self.padding = padding
        self.background = background
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.indicator
            .rotationEffect(rotation(for: configuration))
            .frame(aspectRatio: 1)
            .padding(padding)
            .background {
                background()
            }
    }
}

struct IndicatorCircleBackgroundStyle<FillStyle: ShapeStyle>: DisclosureIndicatorStyle {
    let padding: CGFloat
    let fillStyle: FillStyle

    init(padding: CGFloat = 2, fillStyle: FillStyle) {
        self.padding = padding
        self.fillStyle = fillStyle
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.indicator
            .rotationEffect(rotation(for: configuration))
            .frame(aspectRatio: 1)
            .padding(padding)
            .background {
                Circle().fill(fillStyle)
            }
    }
}

extension DisclosureIndicatorStyle where Self == IndicatorCircleBackgroundStyle<Material> {
    @MainActor static var ultraThinCircle: Self { IndicatorCircleBackgroundStyle(fillStyle: .ultraThin)
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
            DisclosureIndicator(isExpanded: isExpanded)

            DisclosureIndicator(isExpanded: isExpanded)
                .disclosureIndicatorStyle(DisclosureIndicatorWithBackgroundStyle(padding: 4, background: {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(LinearGradient(gradient: .systemRainbow, startPoint: .bottom, endPoint: .top))
                }))

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
