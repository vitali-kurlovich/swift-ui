//
//  AspectRatioModifier.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 4.02.26.
//

import SwiftUI

public struct AspectRatioModifier: ViewModifier, Equatable {
    public let aspectRatio: CGFloat

    public init(aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }

    public func body(content: Content) -> some View {
        AspectRatioLayout(aspectRatio: aspectRatio) {
            content
        }
    }
}
