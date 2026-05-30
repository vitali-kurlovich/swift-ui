//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

private struct StatusStyleEnvironmentKey<State: Equatable>: EnvironmentKey {
    static var defaultValue: any StatusStyle<State> {
        DefaultStatusStyle(DefaultStatusIndicatorColorResolver(State.self))
    }
}

extension EnvironmentValues {
    func statusStyle<State: Equatable>(_: State.Type) -> any StatusStyle<State> {
        self[StatusStyleEnvironmentKey<State>.self]
    }

    mutating func updateStatusStyle<State: Equatable, Style: StatusStyle>(_ style: Style) where Style.State == State {
        self[StatusStyleEnvironmentKey<State>.self] = style
    }
}
