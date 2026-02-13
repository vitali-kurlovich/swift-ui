//
//  EnvironmentValues+GroupStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 13.02.26.
//

import SwiftUI

private struct StateGroupStyleEnvironmentKey<State: Equatable>: EnvironmentKey {
    static var defaultValue: any StateGroupStyle<State> { DefaultStateGroupStyle<State>() }
}

extension EnvironmentValues {
    func stateGroupStyle<State: Equatable>(_: State.Type) -> any StateGroupStyle<State> {
        self[StateGroupStyleEnvironmentKey<State>.self]
    }

    mutating func updateStateGroupStyle<State: Equatable, Style: StateGroupStyle>(_ style: Style) where Style.State == State {
        self[StateGroupStyleEnvironmentKey<State>.self] = style
    }
}
