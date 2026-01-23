//
//  LayerEffectShaderModifier.swift
//  swift-mathkit
//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

public extension View {
    func shaderEffect<Provider: LayerEffectShaderProvider>(_ provider: Provider, isEnabled: Bool = true) -> some View {
        modifier(LayerEffectShaderModifier(provider: provider, isEnabled: isEnabled))
    }
}

struct LayerEffectShaderModifier<Provider: LayerEffectShaderProvider>: ViewModifier {
    let provider: Provider
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content.layerEffect(provider.shader(proxy),
                                maxSampleOffset: provider.maxSampleOffset(proxy),
                                isEnabled: isEnabled)
        }
    }
}
