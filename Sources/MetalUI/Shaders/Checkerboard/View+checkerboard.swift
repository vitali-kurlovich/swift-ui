//
//  View+checkerboard.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

extension ViewValue where BaseType == CGFloat {
    func convertToSize() -> ViewValue<CGSize> {
        switch self {
        case let .fixed(value):
            return .fixed(.init(width: value, height: value))
        case let .dynamic(value):
            return .dynamic(.init(width: value, height: value))
        }
    }
}

public extension View {
    func checkerboard(checkSize: ViewValue<CGFloat> = .fixed(20),
                      origin: UnitPoint = .center,
                      opacity: CGFloat = 0.3,
                      reverse: Bool = false) -> some View
    {
        checkerboard(checkSize: checkSize.convertToSize(), origin: origin,
                     opacity: opacity,
                     reverse: reverse)
    }

    func checkerboard(checkSize: ViewValue<CGSize>,
                      origin: UnitPoint = .center,
                      opacity: CGFloat = 0.3,
                      reverse: Bool = false) -> some View
    {
        modifier(
            CheckerboardShaderModifier(checkSize: checkSize,
                                       origin: origin,
                                       secondColor: .opacity(opacity),

                                       reverse: reverse)
        )
    }

    func checkerboard(checkSize: ViewValue<CGFloat> = .fixed(20),
                      origin: UnitPoint = .center,
                      secondColor: Color, reverse: Bool = false) -> some View
    {
        modifier(
            CheckerboardShaderModifier(checkSize: checkSize.convertToSize(),
                                       origin: origin,
                                       secondColor: .color(secondColor),

                                       reverse: reverse)
        )
    }

    func checkerboard(checkSize: ViewValue<CGSize>,
                      origin: UnitPoint = .center,
                      secondColor: Color, reverse: Bool = false) -> some View
    {
        modifier(
            CheckerboardShaderModifier(checkSize: checkSize,
                                       origin: origin,
                                       secondColor: .color(secondColor),

                                       reverse: reverse)
        )
    }
}

struct CheckerboardShaderModifier: ViewModifier {
    @ScaledMetric
    private var scaledFactor: CGFloat = 1

    @Environment(\.displayScale)
    private var displayScale: CGFloat

    var checkSize: ViewValue<CGSize>
    var origin: UnitPoint
    var secondColor: CheckerboardShader.ColorConfiguration

    var reverse: Bool

    func body(content: Content) -> some View {
        content.shaderEffect(shader)
    }
}

extension CheckerboardShaderModifier {
    private var shader: CheckerboardShader {
        let checkSize: CGSize
        switch self.checkSize {
        case let .fixed(value):
            checkSize = value
        case let .dynamic(value):
            checkSize = .init(width: value.width * scaledFactor,
                              height: value.height * scaledFactor)
        }

        return .init(checkSize: checkSize,
                     origin: origin,
                     secondColor: secondColor,
                     reverse: reverse,
                     displayScale: displayScale)
    }
}

#Preview {
    @Previewable @State var reverse = false
    VStack {
        RoundedRectangle(cornerRadius: 6)
            .fill(Color.indigo.gradient)
            .frame(width: 20 * 9, height: 20 * 6 + 4)
            .checkerboard(reverse: reverse)

        RoundedRectangle(cornerRadius: 6)
            .fill(Color.indigo.gradient)
            .frame(width: 20 * 9, height: 20 * 6 + 4)
            .checkerboard(checkSize: .dynamic(20), reverse: reverse)

        Button("Toggle") {
            reverse.toggle()
        }
    }
}
