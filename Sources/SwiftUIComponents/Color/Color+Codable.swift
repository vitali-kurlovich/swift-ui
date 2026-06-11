//
//  Color+Codable.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 16.02.26.
//

import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension Color: @retroactive Encodable {
    public func encode(to encoder: any Encoder) throws {
        let container = ColorContainer(color: self)
        try container.encode(to: encoder)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension Color: @retroactive Decodable {
    public init(from decoder: any Decoder) throws {
        let container = try ColorContainer(from: decoder)
        self.init(container)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
struct ColorContainer: Codable {
    let light: Color.Resolved
    let dark: Color.Resolved
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension ColorContainer {
    init(color: Color) {
        var environmentValues = EnvironmentValues()

        environmentValues.colorScheme = .light
        let light = color.resolve(in: environmentValues)

        environmentValues.colorScheme = .dark
        let dark = color.resolve(in: environmentValues)

        self.init(light: light, dark: dark)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension Color {
    init(_ container: ColorContainer) {
        #if canImport(UIKit)

            let color = UIColor { traitCollection in
                if traitCollection.userInterfaceStyle == .dark {
                    return UIColor(cgColor: container.dark.cgColor)
                }

                return UIColor(cgColor: container.light.cgColor)
            }

            self.init(uiColor: color)
        #endif

        #if canImport(AppKit)
            let color = NSColor(name: nil) { appearance in
                switch appearance.name {
                case .aqua, .accessibilityHighContrastAqua, .accessibilityHighContrastVibrantLight:
                    NSColor(ciColor: CIColor(cgColor: container.light.cgColor))
                default:
                    NSColor(ciColor: CIColor(cgColor: container.dark.cgColor))
                }
            }

            self.init(nsColor: color)

        #endif
    }
}
