//
//  AspectRatioLayout.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 4.02.26.
//

import SwiftUI

struct AspectRatioLayout: Layout, Equatable {
    let aspectRatio: CGFloat

    init(aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        guard let first = subviews.first else {
            return .zero
        }

        let size = first.sizeThatFits(proposal)

        var width = size.width
        var height = size.height

        for view in subviews.dropFirst() {
            let size = view.sizeThatFits(proposal)

            width = max(width, size.width)
            height = max(height, size.height)
        }

        if width < aspectRatio * height {
            width = aspectRatio * height
        } else if width > aspectRatio * height {
            height = width / aspectRatio
        }

        return CGSize(width: width, height: height)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        let midX = bounds.midX
        let midY = bounds.midY

        for view in subviews {
            let size = view.sizeThatFits(proposal)

            view.place(at: .init(x: midX - size.width / 2,
                                 y: midY - size.height / 2),
                       anchor: .topLeading,
                       proposal: .init(size))
        }
    }
}

#Preview {
    AspectRatioLayout(aspectRatio: 1) {
        Image(systemName: "chevron.forward")
            .border(.green)
        // Rectangle()
    }.border(.red)
        .frame(width: 200, height: 200)
}
