//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public struct DefaultStatusStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StatusStyleConfiguration<State>) -> some View {
        HStack {
            configuration.indicator
                .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
            configuration.label
        }
    }
}

public struct DefaultStatusCompactStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StatusStyleConfiguration<State>) -> some View {
        configuration.indicator
            .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
    }
}

@available(iOS 26.0, macOS 26.0, *)
public struct DefaultStatusGlassStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StatusStyleConfiguration<State>) -> some View {
        HStack {
            configuration.indicator
                .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
            configuration.label
        }
        .padding(.all, 5)
        .glassEffect(.regular.interactive())
    }
}

@available(iOS 26.0, macOS 26.0, *)
public struct DefaultStatusCompactGlassStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StatusStyleConfiguration<State>) -> some View {
        configuration.indicator
            .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
            .padding(.all, 5)
            .glassEffect(.regular.interactive())
    }
}
