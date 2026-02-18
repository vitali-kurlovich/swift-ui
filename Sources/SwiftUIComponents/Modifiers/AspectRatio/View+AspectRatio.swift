//
//  View+AspectRatio.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 4.02.26.
//

import SwiftUI

public extension View {
    nonisolated func frame(aspectRatio: CGFloat) -> some View {
        modifier(AspectRatioModifier(aspectRatio: aspectRatio))
    }
}

#Preview {
    Image(systemName: "chevron.forward")
        .border(.green)
        .frame(aspectRatio: 1)
        .border(.red)
}
