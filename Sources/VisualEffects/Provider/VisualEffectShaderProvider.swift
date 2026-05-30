//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

public protocol VisualEffectShaderProvider: Sendable {
    var shaderLibrary: ShaderLibrary { get }
}

public extension VisualEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        .default
    }

    func shaderFunction(for name: String) -> ShaderFunction {
        assert(!name.isEmpty)

        return ShaderFunction(library: shaderLibrary, name: name)
    }
}

public protocol ColorEffectShaderProvider: VisualEffectShaderProvider {
    func shader() -> Shader

    func compile() async throws
}

public extension ColorEffectShaderProvider {
    func compile() async throws {
        try await shader().compile(as: .colorEffect)
    }
}

public protocol SampleOffsetEffectShaderProvider: VisualEffectShaderProvider {
    func shader(_ proxy: GeometryProxy) -> Shader

    /// If the shader function samples from the layer at locations not equal to the destination position, this value must specify the maximum sampling distance in each axis, for all source pixels.
    func maxSampleOffset(_ proxy: GeometryProxy) -> CGSize

    func compile() async throws
}

public extension SampleOffsetEffectShaderProvider {
    func compile() async throws {
        assertionFailure("Do not implemented")
    }
}

public extension SampleOffsetEffectShaderProvider {
    func maxSampleOffset(_: GeometryProxy) -> CGSize {
        .zero
    }
}

public protocol DistortionEffectShaderProvider: SampleOffsetEffectShaderProvider {}

public protocol LayerEffectShaderProvider: SampleOffsetEffectShaderProvider {}
