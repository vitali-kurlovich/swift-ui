//
//  StateGroup.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 10.02.26.
//

import SwiftUI

public struct StateGroup<State: Equatable, Content: View, Label: View>: View {
    @Environment(\.self)
    private var environmentValues

    private var style: any StateGroupStyle<State> {
        environmentValues.stateGroupStyle(State.self)
    }

    @Binding
    private var state: State

    private let content: (State) -> Content
    private let label: (State) -> Label

    public init(state: Binding<State>,
                @ViewBuilder label: @escaping (State) -> Label,
                @ViewBuilder content: @escaping (State) -> Content)
    {
        _state = state
        self.content = content
        self.label = label
    }

    public var body: some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}

private extension StateGroup {
    var configuration: StateGroupStyleConfiguration<State> {
        let label = StateGroupStyleConfiguration<State>.Label(label(state))
        let content = StateGroupStyleConfiguration<State>.Content(content(state))

        return StateGroupStyleConfiguration<State>(label: label, content: content, state: $state)
    }
}
