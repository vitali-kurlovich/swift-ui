//
//  View+StateGroupStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 13.02.26.
//

import SwiftUI

public extension View {
    func stateGroupStyle<State: Equatable, Style: StateGroupStyle>(_ style: Style) -> some View where Style.State == State {
        transformEnvironment(\.self) { environment in
            environment.updateStateGroupStyle(style)
        }
    }
}
