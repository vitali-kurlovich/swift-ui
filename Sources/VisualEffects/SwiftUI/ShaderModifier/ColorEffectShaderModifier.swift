//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension View {
    func shaderEffect(_ provider: some ColorEffectShaderProvider, isEnabled: Bool = true) -> some View {
        modifier(ColorEffectShaderModifier(provider: provider, isEnabled: isEnabled))
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
struct ColorEffectShaderModifier<Provider: ColorEffectShaderProvider>: ViewModifier {
    let provider: Provider
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content.visualEffect { content, _ in
            content
                .colorEffect(
                    provider.shader(),
                    isEnabled: isEnabled
                )
        }
    }
}
