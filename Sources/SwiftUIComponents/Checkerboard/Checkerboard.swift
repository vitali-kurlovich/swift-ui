//
//  Checkerboard.swift
//  swift-metalui
//
//  Created by Vitali Kurlovich on 22.01.26.
//

import SwiftUI
import VisualEffects

public struct Checkerboard: View, Equatable {
    public typealias Configuration = CheckerboardConfiguration

    private let firstColor: Color
    private let secondColor: Color

    private let configuration: Configuration

    public init(primary: Color = .primary, secondary: Color = .secondary, _ configuration: Configuration) {
        firstColor = primary
        secondColor = secondary
        self.configuration = configuration
    }

    public var body: some View {
        firstColor.checkerboard(configuration,
                                secondColor: secondColor)
    }
}

#Preview {
    Checkerboard(.small())
    Checkerboard(.medium())
    Checkerboard(.large())
}
