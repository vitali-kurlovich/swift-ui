//
//  VisualEffectShaderProvider.swift
//  swift-mathkit
//
//  Created by Vitali Kurlovich on 3.01.26.
//

import SwiftUI

public protocol VisualEffectShaderProvider: Sendable {
    var shaderLibrary: ShaderLibrary { get }

    func shader() -> Shader
}

public extension VisualEffectShaderProvider {
    var shaderLibrary: ShaderLibrary {
        .default
    }

    func shaderFunction(for name: String) -> ShaderFunction {
        assert(!name.isEmpty)

        return ShaderFunction(library: shaderLibrary, name: name)
    }

    func shader(_: GeometryProxy) -> Shader {
        shader()
    }
}

public protocol ColorEffectShaderProvider: VisualEffectShaderProvider {}

public protocol SampleOffsetEffectShaderProvider: VisualEffectShaderProvider {
    /// If the shader function samples from the layer at locations not equal to the destination position, this value must specify the maximum sampling distance in each axis, for all source pixels.

    func maxSampleOffset(_ proxy: GeometryProxy) -> CGSize
}

public extension SampleOffsetEffectShaderProvider {
    func maxSampleOffset(_: GeometryProxy) -> CGSize { .zero }
}

public protocol DistortionEffectShaderProvider: SampleOffsetEffectShaderProvider {}

public protocol LayerEffectShaderProvider: SampleOffsetEffectShaderProvider {}
