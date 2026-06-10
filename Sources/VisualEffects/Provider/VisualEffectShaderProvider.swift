//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public protocol VisualEffectShaderProvider: Sendable {
    var shaderLibrary: ShaderLibrary { get }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension VisualEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        .default
    }

    func shaderFunction(for name: String) -> ShaderFunction {
        assert(!name.isEmpty)

        return ShaderFunction(library: shaderLibrary, name: name)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public protocol ColorEffectShaderProvider: VisualEffectShaderProvider {
    func shader() -> Shader

    @available(iOS 18.0, macOS 15.0, *)
    func compile() async throws
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension ColorEffectShaderProvider {
    @available(iOS 18.0, macOS 15.0, *)
    func compile() async throws {
        try await shader().compile(as: .colorEffect)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public protocol SampleOffsetEffectShaderProvider: VisualEffectShaderProvider {
    func shader(_ proxy: GeometryProxy) -> Shader

    /// If the shader function samples from the layer at locations not equal to the destination position, this value must specify the maximum sampling distance in each axis, for all source pixels.
    func maxSampleOffset(_ proxy: GeometryProxy) -> CGSize

    @available(iOS 18.0, macOS 15.0, *)
    func compile() async throws
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension SampleOffsetEffectShaderProvider {
    @available(macOS 15.0, *)
    func compile() async throws {
        assertionFailure("Do not implemented")
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public extension SampleOffsetEffectShaderProvider {
    func maxSampleOffset(_: GeometryProxy) -> CGSize {
        .zero
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public protocol DistortionEffectShaderProvider: SampleOffsetEffectShaderProvider {}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
public protocol LayerEffectShaderProvider: SampleOffsetEffectShaderProvider {}
