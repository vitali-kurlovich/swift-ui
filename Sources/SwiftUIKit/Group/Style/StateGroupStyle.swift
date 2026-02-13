//
//  StateGroupStyle.swift
//  swift-ui
//
//  Created by Vitali Kurlovich on 13.02.26.
//

import SwiftUI

public protocol StateGroupStyle<State>: Sendable {
    associatedtype State: Equatable
    associatedtype Body: View

    init()

    @ViewBuilder @MainActor func makeBody(configuration: Self.Configuration) -> Self.Body

    typealias Configuration = StateGroupStyleConfiguration<State>
}

public struct StateGroupStyleConfiguration<State: Equatable> {
    @MainActor
    public struct Content: View {
        public var body: AnyView {
            storge
        }

        let storge: AnyView

        init<V: View>(_ view: V) {
            storge = AnyView(view)
        }
    }

    @MainActor
    public struct Label: View {
        public var body: AnyView {
            storge
        }

        let storge: AnyView

        init<V: View>(_ view: V) {
            storge = AnyView(view)
        }
    }

    public let label: StateGroupStyleConfiguration<State>.Label
    public let content: StateGroupStyleConfiguration<State>.Content

    @Binding
    public var state: State
}
