//
//  View+checkerboard.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 21.01.26.
//

import SwiftUI

public extension View {
    func checkerboard(checkSize: CGFloat = 20, opacity: CGFloat = 0.3, reverse: Bool = false) -> some View {
        modifier(
            CheckerboardShaderModifier(checkSize: checkSize,
                                       secondColor: .opacity(opacity),
                                       reverse: reverse)
        )
    }

    func checkerboard(checkSize: CGFloat = 20, secondColor: Color, reverse: Bool = false) -> some View {
        modifier(
            CheckerboardShaderModifier(checkSize: checkSize,
                                       secondColor: .color(secondColor),
                                       reverse: reverse)
        )
    }
}

struct CheckerboardShaderModifier: ViewModifier {
    var checkSize: CGFloat
    var secondColor: CheckerboardShader.ColorConfiguration

    var reverse: Bool

    func body(content: Content) -> some View {
        content.shaderEffect(shader)
    }
}

extension CheckerboardShaderModifier {
    private var shader: CheckerboardShader {
        .init(checkSize: checkSize, secondColor: secondColor, reverse: reverse)
    }
}

#Preview {
    @Previewable @State var reverse = false
    VStack {
        RoundedRectangle(cornerRadius: 44)
            .fill(Color.indigo.gradient)
            .frame(width: 133, height: 150)
            .checkerboard(secondColor: .red, reverse: reverse)
        Button("Toggle") {
            reverse.toggle()
        }
    }
}
