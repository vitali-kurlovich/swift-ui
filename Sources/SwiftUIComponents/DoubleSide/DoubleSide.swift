//
//  Created by Kurlovich Vitali on 5/16/26.
//

import MathKit
import SwiftUI

public struct DoubleSide<Front: View, Back: View>: View {
    @Binding
    private var side: Side

    private let front: Front
    private let back: Back

    private let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
    private let anchor: UnitPoint
    private let anchorZ: CGFloat
    private let perspective: CGFloat

    private let reversed: Bool

    public init(_ side: Binding<Side>,
                axis: (x: CGFloat, y: CGFloat, z: CGFloat) = (x: 0, y: 1, z: 0),
                anchor: UnitPoint = .center,
                anchorZ: CGFloat = 0,
                perspective: CGFloat = 0.333,

                reversed: Bool = false,

                @ViewBuilder front: () -> Front,
                @ViewBuilder back: () -> Back)
    {
        _side = side

        self.axis = axis
        self.anchor = anchor
        self.anchorZ = anchorZ
        self.perspective = perspective

        self.reversed = reversed

        self.front = front()
        self.back = back()
    }

    public var body: some View {
        DoubleSideView(angle: angle,
                       axis: axis,
                       anchor: anchor,
                       anchorZ: anchorZ,
                       perspective: perspective,
                       front: front,
                       back: back)
    }
}

private extension DoubleSide {
    var angle: Angle {
        switch side {
        case .front:
            .degrees(0)
        case .back:
            reversed ? .degrees(-180) : .degrees(180)
        }
    }
}

#Preview {
    @Previewable
    @State
    var side: Side = .front

    HStack {
        DoubleSide($side, front: {
            PreviewContent(color: .green, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .red, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })

        DoubleSide($side, reversed: true, front: {
            PreviewContent(color: .purple, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .mint, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })

        DoubleSide($side,
                   axis: (x: 1, y: 0, z: 0),
                   front: {
                       PreviewContent(color: .green, systemName: "moon.stars.fill")
                   }, back: {
                       PreviewContent(color: .red, systemName: "cloud.moon.fill")
                           .scaleEffect(y: -1)

                   })

        DoubleSide($side, anchor: .trailing, front: {
            PreviewContent(color: .purple, systemName: "moon.stars.fill")
        }, back: {
            PreviewContent(color: .mint, systemName: "cloud.moon.fill")
                .scaleEffect(x: -1)

        })
    }
    Button("Toggle") {
        withAnimation {
            side.toggle()
        }
    }
}

struct PreviewContent: View {
    let color: Color
    let systemName: String

    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(color)
            .overlay {
                Image(systemName: systemName)
                    .symbolEffect(.breathe)
                    .symbolRenderingMode(.multicolor)
                    .font(.largeTitle)
                    .foregroundStyle(.regularMaterial)
            }
            .frame(width: 275 / 2,
                   height: 475 / 2)
    }
}
