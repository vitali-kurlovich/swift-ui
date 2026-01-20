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
                                       opacity: opacity,
                                       reverse: reverse)
        )
    }
}

struct CheckerboardShaderModifier: ViewModifier {
    let checkSize: CGFloat
    let opacity: CGFloat
    let reverse: Bool

    func body(content: Content) -> some View {
        content.shaderEffect(
            CheckerboardShader(checkSize: checkSize, opacity: opacity, reverse: reverse)
        )
    }
}

#Preview {
    @Previewable @State var reverse = false
    VStack {
        RoundedRectangle(cornerRadius: 44)
            .fill(Color.indigo.gradient)
            .frame(width: 200, height: 150)
            .checkerboard(reverse: reverse)
        Button("Toggle") {
            reverse.toggle()
        }
    }
}
