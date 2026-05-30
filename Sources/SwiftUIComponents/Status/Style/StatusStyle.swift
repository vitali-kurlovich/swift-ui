//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public protocol StatusStyle<State>: Sendable {
    associatedtype State: Equatable
    associatedtype Body: View

    @ViewBuilder @MainActor func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = StateStyleConfiguration<State>
}

public struct StateStyleConfiguration<State: Equatable> {
    @MainActor
    public struct Label: View {
        public var body: AnyView {
            storge
        }

        let storge: AnyView

        init(_ view: some View) {
            storge = AnyView(view)
        }
    }

    @MainActor
    public struct Indicator: View {
        public var body: AnyView {
            storge
        }

        let storge: AnyView

        init(_ view: some View) {
            storge = AnyView(view)
        }
    }

    public let indicator: StateStyleConfiguration<State>.Indicator
    public let label: StateStyleConfiguration<State>.Label

    public let state: State
}

public extension View {
    func statusStyle<State: Equatable, Style: StatusStyle>(_ style: Style) -> some View where Style.State == State {
        transformEnvironment(\.self) { environment in
            environment.updateStatusStyle(style)
        }
    }
}
