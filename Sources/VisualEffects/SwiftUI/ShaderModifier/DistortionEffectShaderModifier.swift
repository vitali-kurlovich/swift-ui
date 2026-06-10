//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension View {
    func shaderEffect(_ provider: some DistortionEffectShaderProvider, isEnabled: Bool = true) -> some View {
        modifier(DistortionEffectShaderModifier(provider: provider, isEnabled: isEnabled))
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
struct DistortionEffectShaderModifier<Provider: DistortionEffectShaderProvider>: ViewModifier {
    let provider: Provider
    let isEnabled: Bool

    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content.distortionEffect(provider.shader(proxy),
                                     maxSampleOffset: provider.maxSampleOffset(proxy),
                                     isEnabled: isEnabled)
        }
    }
}
