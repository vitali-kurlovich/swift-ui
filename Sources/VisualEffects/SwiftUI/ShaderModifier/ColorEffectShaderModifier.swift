//
//  ColorEffectShaderModifier.swift
//  swift-mathkit
//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

public extension View {
    func shaderEffect<Provider: ColorEffectShaderProvider>(_ provider: Provider, isEnabled: Bool = true) -> some View {
        modifier(ColorEffectShaderModifier(provider: provider, isEnabled: isEnabled))
    }
}

struct ColorEffectShaderModifier<Provider: ColorEffectShaderProvider>: ViewModifier {
    let provider: Provider
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content
                .colorEffect(
                    provider.shader(proxy),
                    isEnabled: isEnabled
                )
        }
    }
}
