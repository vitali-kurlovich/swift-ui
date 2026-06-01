//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public struct Status<State: Equatable & CustomStringConvertible>: View {
    @Environment(\.self)
    private var environmentValues

    public let state: State

    public init(state: State) {
        self.state = state
    }

    public var body: some View {
        AnyView(style.makeBody(configuration: configuration))
    }
}

private extension Status {
    var style: any StatusStyle<State> {
        environmentValues.statusStyle(State.self)
    }

    var configuration: StatusStyleConfiguration<State> {
        let indicator = Image(systemName: "circlebadge.fill")
        let label = Text(state.description).lineLimit(1)

        return StatusStyleConfiguration<State>(indicator: .init(indicator),
                                               label: .init(label),
                                               state: state)
    }
}
