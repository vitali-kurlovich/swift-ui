//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public protocol StatusIndicatorColorResolver<State>: Equatable, Sendable {
    associatedtype State: Equatable

    func resolveColor(for state: State) -> Color
}

public struct DefaultStatusIndicatorColorResolver<State: Equatable>: StatusIndicatorColorResolver {
    public init(_: State.Type) {}

    public func resolveColor(for _: State) -> Color {
        .primary
    }
}
