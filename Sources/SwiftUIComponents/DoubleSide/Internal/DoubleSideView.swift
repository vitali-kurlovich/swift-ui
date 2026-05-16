//
//  Created by Kurlovich Vitali on 5/16/26.
//

import SwiftUI
import MathKit

struct DoubleSideView<Front: View, Back: View>: View {
    var angle: Angle

    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
    let anchor: UnitPoint
    let anchorZ: CGFloat
    let perspective: CGFloat
    
     let front: Front
     let back: Back
    
    var body: some View {
        content()
            .rotation3DEffect(
                angle,
                axis: axis,
                anchor: anchor,
                anchorZ: anchorZ,
                perspective: perspective,
            ).brightness(brightnessValue)
    }
}

extension DoubleSideView: @MainActor Animatable {
    var animatableData: Angle.AnimatableData {
        get {
            angle.animatableData
        }
        set {
            angle.animatableData = newValue
        }
    }
}

private extension DoubleSideView {
    @ViewBuilder
    func content() -> some View {
        switch currentSide {
        case .front:
            front
        case .back:
            back
        }
    }
}

private extension DoubleSideView {
    var brightnessValue: Double {
        let br = abs(dot)
        return br > (1.0 / 512.0) ? -br * 0.33 : 0
    }

    var currentSide: Side {
        angle.side
    }

    var dot: CGFloat {
        CGVector(dx: 1, dy: 0)
            .dot(CGVector(dx: 0, dy: 1)
                .rotated(angle))
    }

    var cross: CGFloat {
        CGVector(dx: 1, dy: 0)
            .cross(CGVector(dx: 0, dy: 1)
                .rotated(angle))
    }
}
