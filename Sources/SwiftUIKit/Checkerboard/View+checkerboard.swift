//
//  View+checkerboard.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI
import VisualEffects

public extension View {
    func checkerboard(_ configuration: CheckerboardConfiguration = .medium(),
                      opacity: CGFloat = 0.3,
                      reverse: Bool = false) -> some View
    {
        modifier(
            CheckerboardShaderModifier(configuration: configuration,
                                       secondColor: .opacity(opacity),
                                       reverse: reverse)
        )
    }

    func checkerboard(_ configuration: CheckerboardConfiguration = .medium(),
                      secondColor: Color, reverse: Bool = false) -> some View
    {
        modifier(
            CheckerboardShaderModifier(configuration: configuration,
                                       secondColor: .color(secondColor),
                                       reverse: reverse)
        )
    }
}

struct CheckerboardShaderModifier: ViewModifier {
    typealias Configuration = CheckerboardConfiguration

    @Environment(\.dynamicTypeSize) var dynamicTypeSize

    let configuration: Configuration
    let secondColor: CheckerboardShader.ColorConfiguration
    let reverse: Bool

    func body(content: Content) -> some View {
        content.shaderEffect(shader)
    }
}

extension CheckerboardShaderModifier {
    private var shader: CheckerboardShader {
        let checkSize = configuration.resolveSize(dynamicTypeSize)
        let origin = configuration.origin

        return .init(checkSize: checkSize,
                     origin: origin,
                     secondColor: secondColor,
                     reverse: reverse)
    }
}

#Preview {
    @Previewable @State var reverse = false
    VStack {
        Image(systemName: "rainbow")
            .renderingMode(.original)
            .resizable()
            .symbolEffect(.variableColor.iterative, options: .repeating)
            .frame(width: 200, height: 110)
            .checkerboard(.small(), opacity: 0.3)

        RoundedRectangle(cornerRadius: 6)
            .fill(Color.indigo.gradient)
            .frame(width: 20 * 9, height: 20 * 6 + 4)
            .checkerboard(reverse: reverse)

        RoundedRectangle(cornerRadius: 6)
            .fill(Color.indigo.gradient)
            .frame(width: 20 * 9, height: 20 * 6 + 4)
            .checkerboard(.init(size: 33), reverse: reverse)

        Button("Toggle") {
            reverse.toggle()
        }
    }
}
