//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public protocol StatusStyle<State>: Sendable {
    associatedtype State: Equatable
    associatedtype Body: View

    @ViewBuilder @MainActor func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = StatusStyleConfiguration<State>
}

public struct StatusStyleConfiguration<State: Equatable> {
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

    public let indicator: StatusStyleConfiguration<State>.Indicator
    public let label: StatusStyleConfiguration<State>.Label

    public let state: State
}

public extension View {
    func statusStyle<State: Equatable, Style: StatusStyle>(_ style: Style) -> some View where Style.State == State {
        transformEnvironment(\.self) { environment in
            environment.updateStatusStyle(style)
        }
    }
}
