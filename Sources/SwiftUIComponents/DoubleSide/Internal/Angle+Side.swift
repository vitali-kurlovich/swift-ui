//
//  Created by Kurlovich Vitali on 5/16/26.
//

import MathKit
import SwiftUI

@available(iOS 17.0, macOS 14.0, tvOS 17.0, *)
extension Angle {
    var side: Side {
        CGVector(dx: 1, dy: 0)
            .cross(CGVector(dx: 0, dy: 1)
                .rotated(self)) >= 0 ? .front : .back
    }
}
