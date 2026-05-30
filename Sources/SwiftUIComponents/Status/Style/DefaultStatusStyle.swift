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

    public func makeBody(configuration: StateStyleConfiguration<State>) -> some View {
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

    public func makeBody(configuration: StateStyleConfiguration<State>) -> some View {
        configuration.indicator
            .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
    }
}

@available(iOS 26.0, *)
public struct DefaultStatusGlassStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StateStyleConfiguration<State>) -> some View {
        HStack {
            configuration.indicator
                .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
            configuration.label
        }
        .padding(.all, 5)
        .glassEffect(.regular.interactive())
    }
}

@available(iOS 26.0, *)

public struct DefaultStatusCompactGlassStyle<Resolver: StatusIndicatorColorResolver>: StatusStyle, Equatable {
    public typealias State = Resolver.State

    let resolver: Resolver

    public init(_ resolver: Resolver) where Resolver.State == Self.State {
        self.resolver = resolver
    }

    public func makeBody(configuration: StateStyleConfiguration<State>) -> some View {
        configuration.indicator
            .foregroundStyle(resolver.resolveColor(for: configuration.state).gradient)
            .padding(.all, 5)
            .glassEffect(.regular.interactive())
    }
}

private enum PreviewState: Int, CustomStringConvertible, CaseIterable {
    case first
    case second
    case third

    var description: String {
        switch self {
        case .first:
            "First"
        case .second:
            "Second"
        case .third:
            "Third"
        }
    }
}

private struct PreviewStateColorResolver: StatusIndicatorColorResolver {
    func resolveColor(for state: PreviewState) -> Color {
        switch state {
        case .first:
            .red
        case .second:
            .yellow
        case .third:
            .green
        }
    }
}

private struct PreviewStatesCollection: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
            HStack {
                ForEach(PreviewState.allCases, id: \.self) { state in
                    Status(state: state)
                }
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 44) {
        PreviewStatesCollection(title: "DefaultStatusStyle")

        PreviewStatesCollection(title: "DefaultStatusStyle - colorize")
            .statusStyle(
                DefaultStatusStyle(PreviewStateColorResolver())
            )

        PreviewStatesCollection(title: "DefaultStatusCompactStyle")
            .statusStyle(
                DefaultStatusCompactStyle(PreviewStateColorResolver())
            )

        if #available(iOS 26.0, *) {
            PreviewStatesCollection(title: "DefaultStatusGlassStyle")
                .statusStyle(
                    DefaultStatusGlassStyle(PreviewStateColorResolver())
                )

            PreviewStatesCollection(title: "DefaultStatusCompactGlassStyle")
                .statusStyle(
                    DefaultStatusCompactGlassStyle(PreviewStateColorResolver())
                )
        }
    }
}
