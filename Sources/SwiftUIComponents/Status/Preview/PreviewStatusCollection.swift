//
//  Created by Kurlovich Vitali on 5/30/26.
//

import SwiftUI

public struct PreviewStatusCollection<State: Hashable & CustomStringConvertible & CaseIterable,
    Resolver: StatusIndicatorColorResolver>: View
    where Resolver.State == State

{
    @Environment(\.verticalSizeClass)
    private var verticalSizeClass

    private let resolver: Resolver

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 44) {
                rows().padding()
            }
        }
    }
}

private extension PreviewStatusCollection {
    @ViewBuilder
    func rows() -> some View {
        if verticalSizeClass == .compact {
            rowHorizontal(title: "DefaultStatusStyle")
                .statusStyle(
                    DefaultStatusStyle(resolver)
                )

            if #available(iOS 26.0, *) {
                rowHorizontal(title: "DefaultStatusStyle")
                    .statusStyle(
                        DefaultStatusGlassStyle(resolver)
                    )
            }
        } else {
            row(title: "DefaultStatusStyle")
                .statusStyle(
                    DefaultStatusStyle(resolver)
                )

            if #available(iOS 26.0, *) {
                row(title: "DefaultStatusStyle")
                    .statusStyle(
                        DefaultStatusGlassStyle(resolver)
                    )
            }
        }

        rowHorizontal(title: "DefaultStatusCompactStyle")
            .statusStyle(
                DefaultStatusCompactStyle(resolver)
            )

        if #available(iOS 26.0, *) {
            rowHorizontal(title: "DefaultStatusCompactGlassStyle")
                .statusStyle(
                    DefaultStatusCompactGlassStyle(resolver)
                )
        }
    }

    func row(title: String, axid _: Axis = .horizontal) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
            VStack(alignment: .leading) {
                ForEach(Array(State.allCases),
                        id: \.self)
                { state in
                    Status(state: state)
                }
            }
        }
    }

    func rowHorizontal(title: String, axid _: Axis = .horizontal) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
            HStack {
                ForEach(Array(State.allCases),
                        id: \.self)
                { state in
                    Status(state: state)
                }
            }
        }
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

#Preview {
    PreviewStatusCollection(resolver: PreviewStateColorResolver())
}
